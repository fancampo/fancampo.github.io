<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
xmlns:xo="http://panax.io/xover"
xmlns:searchParams="http://panax.io/site/searchParams"
>
	<xsl:key name="seguros" match="item[@title='Seguros']/item" use="'*'"/>
	<xsl:key name="seguros" match="item[@title='Seguros de vida']/item" use="'*'"/>
	<xsl:key name="seguros" match="item[@tag]/item" use="../@tag"/>

	<xsl:param name="value">${target.scope.value}</xsl:param>
	<xsl:template match="/">
		<select>
			<option></option>
			<xsl:apply-templates mode="combobox-item" select="key('seguros','*')"/>
		</select>
	</xsl:template>

	<xsl:template mode="combobox-item" match="*">
		<option>
			<xsl:if test="$value=@title">
				<xsl:attribute name="selected"/>
			</xsl:if>
			<xsl:value-of select="@title"/>
		</option>
	</xsl:template>
</xsl:stylesheet>