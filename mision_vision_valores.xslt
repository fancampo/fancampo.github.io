<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover">
	<xsl:key name="valid-model" match="root[@env:store='#aviso_privacidad']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#codigo_etica']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#mision']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#vision']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#valores']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#terminos_condiciones']" use="generate-id()"/>

	<xsl:key name="data" match="data[not(contains(@name,'title'))]" use="'body'"/>
	
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

	<xsl:template match="data[contains(@name,'title')]">
		<h5 class="offcanvas-title" id="offcanvasBottomLabel">
			<xsl:apply-templates/>
		</h5>
	</xsl:template>

	<xsl:template match="root[key('valid-model', generate-id())]">
		<script><![CDATA[bootstrap.Offcanvas.getOrCreateInstance(context.closest('.offcanvas')).show()]]></script>
		<div class="offcanvas-header">
			<xsl:apply-templates select="data[@name='title']"/>
			<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body small">
			<xsl:apply-templates select="data[@name!='title']"/>
		</div>
	</xsl:template>

</xsl:stylesheet>