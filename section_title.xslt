<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:key name="data" match="data/@name" use="."/>
	<xsl:key name="data" match="data" use="@name"/>

	<xsl:param name="title"/>
	<xsl:template match="/">
		<section>
			<xsl:apply-templates/>
		</section>
	</xsl:template>

	<xsl:template match="/*">
		<xsl:variable name="section_title">
			<xsl:choose>
				<xsl:when test="$title!=''">
					<xsl:value-of select="$title"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="key('data','title')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div class="container text-center py-5" style="max-width: 900px;">
			<h3 class="text-white display-3 mb-4">
				<xsl:value-of select="$section_title"/>
			</h3>
		</div>
	</xsl:template>
</xsl:stylesheet>