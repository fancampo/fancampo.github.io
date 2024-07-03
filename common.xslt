<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover">
	<xsl:import href="keys.xslt"/>
	<xsl:template mode="image-src" match="value">
		<xsl:attribute name="src">
			<xsl:text>/assets/</xsl:text>
			<xsl:value-of select="translate(substring-before(.,';'),'\','/')"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template mode="image-src" match="data">
		<xsl:apply-templates mode="image-src" select="key('image', @name)"/>
	</xsl:template>

	<xsl:template mode="title" match="data">
		<xsl:apply-templates mode="title" select="value"/>
	</xsl:template>

	<xsl:template mode="title" match="@name">
		<xsl:value-of select="normalize-space(substring-after(.,':'))"/>
	</xsl:template>

	<xsl:template mode="title" match="value">
		<xsl:value-of select="normalize-space(substring-before(.,':'))"/>
	</xsl:template>

	<xsl:template mode="body" match="value">
		<xsl:value-of select="normalize-space(substring-after(.,':'))"/>
	</xsl:template>
</xsl:stylesheet>