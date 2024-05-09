<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover">
	<xsl:key name="data" match="data" use="@name"/>
	
	<xsl:key name="data" match="data[not(contains(@type,'System.Resources.ResXFileRef'))][not(contains(@name,'title'))]" use="'body'"/>

	<xsl:key name="image" match="data[contains(@type,'System.Resources.ResXFileRef')]/value" use="../@name"/>
	<xsl:key name="image" match="data[contains(@type,'System.Resources.ResXFileRef')]/value" use="substring-after(../@name,':')"/>
	<xsl:key name="image" match="data[not(contains(@type,'System.Resources.ResXFileRef'))][not(comment=../data/@name)]/value" use="comment"/>
</xsl:stylesheet>