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
		<div class="container text-center py-5" style="max-width: 900px;">
			<h3 class="text-white display-3 mb-4">
				<xsl:value-of select="key('data','titulo')"/>
			</h3>
		</div>
	</xsl:template>
</xsl:stylesheet>