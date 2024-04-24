<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:key name="valid-model" match="root[@env:store='#aviso_privacidad']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#codigo_etica']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#mision']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#vision']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#valores']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#terminos_condiciones']" use="generate-id()"/>

	<xsl:key name="data" match="root[@env:store='#mision']/data" use="'mision_vision_valores'"/>
	<xsl:key name="data" match="root[@env:store='#vision']/data" use="'mision_vision_valores'"/>
	<xsl:key name="data" match="root[@env:store='#valores']/data" use="'mision_vision_valores'"/>

	<xsl:key name="data" match="data/@name" use="."/>

	<xsl:key name="data" match="data" use="@name"/>
	<xsl:key name="data" match="data[starts-with(@name,'cobertura_')]" use="'coberturas'"/>
	
	<xsl:template match="/">
		<section>
			<xsl:apply-templates/>
		</section>
	</xsl:template>

	<xsl:template match="/*">
		<div class="container px-4 py-5">
			<h2 class="pb-2 border-bottom">Características</h2>

			<div class="row row-cols-1 row-cols-md-2 align-items-md-top g-5 py-5">
				<div class="col d-flex flex-column align-items-start gap-2">
					<h2 class="fw-bold text-body-emphasis">Objetivo del servicio</h2>
					<p class="text-body-secondary">
						<xsl:apply-templates select="key('data','objetivo')"/>
					</p>
					<a href="#" class="btn btn-primary btn-lg">Contratar</a>
				</div>

				<div class="col">
					<div class="row row-cols-1 row-cols-sm-2 g-4">
						<xsl:apply-templates mode="cobertura" select="key('data','coberturas')"/>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="data">
		<xsl:apply-templates select="value"/>
	</xsl:template>

	<xsl:template mode="title" match="value">
		<xsl:value-of select="substring-before(.,':')"/>
	</xsl:template>

	<xsl:template mode="body" match="value">
		<xsl:value-of select="substring-after(.,':')"/>
	</xsl:template>

	<xsl:template mode="cobertura" match="data">
		<div class="col d-flex flex-column gap-2">
			<div class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
				<svg class="bi" width="1em" height="1em">
					<use xlink:href="#collection"></use>
				</svg>
			</div>
			<h4 class="fw-semibold mb-0 text-body-emphasis">
				<xsl:apply-templates mode="title" select="value"/>
			</h4>
			<p class="text-body-secondary">
				<xsl:apply-templates mode="body" select="value"/>
			</p>
		</div>
	</xsl:template>
</xsl:stylesheet>