<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>

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
			<section class="container-fluid bg-breadcrumb" style="background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url(assets/{$cover});background-position: center center;background-repeat: no-repeat;background-size: cover;background-attachment: fixed;padding: 150px 0 50px 0;" xo-stylesheet="section_title.xslt" xo-source="seed" xo-swap="self::*">
			</section>
			<div class="container p-5">
				<div class="list-group info">
					<xsl:apply-templates select="key('data','body')"/>
				</div>
			</div>
		</main>
	</xsl:template>

	<xsl:template match="data">
		<a href="{value}" class="list-group-item list-group-item-action" aria-current="true" style="text-align: center" target="_blank">
			<h3>
				<xsl:apply-templates mode="title" select="@name"/>
			</h3>
		</a>
	</xsl:template>
</xsl:stylesheet>