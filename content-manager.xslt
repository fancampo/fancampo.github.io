<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover">
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>
	<xsl:key name="valid-model" match="root[@env:store='#aviso_privacidad']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#codigo_etica']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#mision']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#vision']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#valores']" use="generate-id()"/>
	<!--<xsl:key name="valid-model" match="root[@env:store='#conocenos']" use="generate-id()"/>-->
	<xsl:key name="valid-model" match="root[@env:store='#terminos_condiciones']" use="generate-id()"/>

	<xsl:key name="data" match="root[@env:store='#mision']/data[not(contains(@name,':'))]" use="'mision_vision_valores'"/>
	<xsl:key name="data" match="root[@env:store='#vision']/data[not(contains(@name,':'))]" use="'mision_vision_valores'"/>
	<xsl:key name="data" match="root[@env:store='#valores']/data[not(contains(@name,':'))]" use="'mision_vision_valores'"/>
	<xsl:key name="data" match="root[@env:store='#conocenos']/data[not(contains(@name,':'))]" use="'mision_vision_valores'"/>

	<xsl:template match="/">
		<div class="offcanvas offcanvas-bottom" xo-static="@style @role @aria-modal">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="/*">
		<script><![CDATA[bootstrap.Offcanvas.getOrCreateInstance(context.closest('.offcanvas')).hide()]]></script>
	</xsl:template>

	<xsl:template match="/html:*">
		<script><![CDATA[bootstrap.Offcanvas.getOrCreateInstance(context.closest('.offcanvas')).show()]]></script>
		<xsl:copy-of select="."/>
	</xsl:template>

	<xsl:template match="key('data','body')">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="key('data','mision_vision_valores')">
		<div style="padding-block: 3rem">
			<h1 style="text-transform: uppercase;">
				<xsl:apply-templates select="@name"/>
			</h1>
			<q style="font-size: 20pt;">
				<xsl:apply-templates/>
			</q>
		</div>
	</xsl:template>

	<xsl:template match="key('data','mision_vision_valores')">
		<div id="{@name}" class="row d-flex justify-content-center" style="position:relative;">
			<hr id="feature-{position()}-section" class="featurette-divider" style="margin-block: 2rem;"/>
			<div class="featurette" style="margin-block: auto;">
				<xsl:apply-templates mode="feature-header-class" select="."/>
				<h1 class="featurette-heading fw-normal lh-1 text-capitalize my-4">
					<xsl:apply-templates mode="headerText" select="@name"/>. <span class="text-body-secondary">
						<xsl:apply-templates mode="subtitle" select="@name"/>
					</span>
				</h1>
				<blockquote>
					<div class="quotes display-2 text-body-tertiary">
						<i class="bi bi-quote"></i>
					</div>
					<xsl:value-of select="value"/>
				</blockquote>
			</div>
			<div style="overflow: hidden;">
				<xsl:apply-templates mode="feature-body-class" select="."/>
				<img src="./assets/img/{@name}.jpg" style="width: 100%; height: 100%; object-fit: cover; clip-path: inset(0); min-height: 400px; max-height: 400px;">
					<xsl:apply-templates mode="image-src" select="key('image', @name)"/>
				</img>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="data[contains(@type,'System.Resources.ResXFileRef')]"/>

	<xsl:template match="data" mode="feature-header-class">
		<xsl:attribute name="class">col-md-4</xsl:attribute>
	</xsl:template>

	<xsl:template match="data[comment mod 2=0]" mode="feature-header-class">
		<xsl:attribute name="class">col-md-5 order-md-2</xsl:attribute>
	</xsl:template>

	<xsl:template match="data" mode="feature-body-class">
		<xsl:attribute name="class">
			<xsl:text>col-md-6 </xsl:text>
			<xsl:if test="count(preceding-sibling::data) mod 2 = 1">
				<xsl:text/>order-md-1<xsl:text/>
			</xsl:if>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="data[contains(@name,'title')]">
		<h5 class="offcanvas-title" id="offcanvasBottomLabel">
			<xsl:apply-templates/>
		</h5>
	</xsl:template>

	<xsl:template mode="headerText" match="key('data','mision')/@name">
		<xsl:text>Misión</xsl:text>
	</xsl:template>

	<xsl:template mode="headerText" match="key('data','vision')/@name">
		<xsl:text>Visión</xsl:text>
	</xsl:template>

	<xsl:template mode="subtitle" match="@*|*">
	</xsl:template>

	<xsl:template match="root[key('valid-model', generate-id())]">
		<script><![CDATA[bootstrap.Offcanvas.getOrCreateInstance($context.closest('.offcanvas')).show()]]></script>
		<div class="offcanvas-header">
			<xsl:apply-templates select="key('data','title')"/>
			<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body small">
			<xsl:apply-templates select="key('data','body')">
				<xsl:sort select="comment"/>
			</xsl:apply-templates>
		</div>
	</xsl:template>

</xsl:stylesheet>