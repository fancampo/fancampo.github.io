<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>

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
			<section xo-stylesheet="section_title.xslt" title="{$title}"/>
			<section xo-source="seed" xo-stylesheet="thumbnails.xslt" />
		</main>
	</xsl:template>
</xsl:stylesheet>