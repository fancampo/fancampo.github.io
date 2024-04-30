<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl"
>
	<xsl:key name="icon" match="data[starts-with(@name,'icon_')]" use="''"/>
	<xsl:key name="icon" match="data[starts-with(@name,'icon_')]" use="string(comment)"/>

	<xsl:template match="/*">
		<div>
			<style>
				<![CDATA[
				.icon svg {
					height: 20px;
					fill: white;
				}sec
			]]></style>
			<xsl:apply-templates mode="item" select="key('icon','')">
				<xsl:sort select="@name"/>
			</xsl:apply-templates>
		</div>
	</xsl:template>

	<xsl:template mode="item" match="*">
		<a href="#" class="icon" target="_blank">
			<xsl:attribute name="href">
				<xsl:value-of select="value"/>
			</xsl:attribute>
			<xsl:apply-templates mode="item-icon" select="."/>
		</a>
	</xsl:template>

	<xsl:template mode="item-icon" match="*">
		<i class="fa-brands fa-{comment}"></i>
	</xsl:template>

	<xsl:template mode="item-icon" match="*[starts-with(comment,'&lt;')]">
		<xsl:value-of select="comment" disable-output-escaping="yes"/>
	</xsl:template>
</xsl:stylesheet>