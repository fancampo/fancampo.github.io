<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>
	<xsl:key name="data" match="data[starts-with(@name,'cobertura_')]" use="'coberturas'"/>
	<xsl:key name="data" match="data[starts-with(@name,'beneficio_')]" use="'beneficios'"/>
	<xsl:key name="data" match="data[starts-with(@name,'ventaja_')]" use="'ventajas'"/>

	<xsl:param name="title"></xsl:param>
	<xsl:template match="/">
		<main>
			<xsl:variable name="cover">
				<xsl:choose>
					<xsl:when test="key('data','cover')">
						<xsl:value-of select="normalize-space(translate(substring-before(concat(key('data','cover'),';'),';'),'\','/'))"/>
					</xsl:when>
					<xsl:otherwise>img/cover.jpg</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<section class="container-fluid bg-breadcrumb" style="background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url(assets/{$cover});background-position: center center;background-repeat: no-repeat;background-size: cover;padding: 150px 0 50px 0;" xo-stylesheet="section_title.xslt" xo-source="seed" xo-swap="self::*" title="{$title}">
			</section>
			<section xo-source="seed" xo-stylesheet="thumbnails.xslt" />
		</main>
	</xsl:template>
</xsl:stylesheet>