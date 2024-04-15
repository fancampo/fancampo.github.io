<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl"
>
	<xsl:key name="icon" match="data[starts-with(@name,'icon_')]" use="''"/>
	<xsl:key name="icon" match="data[starts-with(@name,'icon_')]" use="string(comment)"/>

	<xsl:template match="/*">
		<div class="social-links mt-3">
			<xsl:apply-templates mode="caracteristicas-item" select="key('icon','')">
				<xsl:sort select="@name"/>
			</xsl:apply-templates>

			<a href="#" class="facebook">
				<i class="bx bxl-facebook"></i>
			</a>
			<a href="#" class="instagram">
				<i class="bx bxl-instagram"></i>
			</a>
		</div>
	</xsl:template>

	<xsl:template mode="caracteristicas-item-title" match="*">
		<xsl:value-of select="substring-before(.,':')"/>
	</xsl:template>

	<xsl:template mode="caracteristicas-item-text" match="*">
		<xsl:value-of select="substring-after(.,':')"/>
	</xsl:template>

	<xsl:template mode="caracteristicas-item" match="*">
		<a href="#" class="twitter">
			<xsl:apply-templates mode="caracteristicas-item-icon" select="."/>
		</a>
	</xsl:template>

	<xsl:template mode="caracteristicas-item-icon" match="*">
		<i class="bx bxl-twitter"></i>
	</xsl:template>
</xsl:stylesheet>