<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xo="http://panax.io/xover"
xmlns:searchParams="http://panax.io/site/searchParams"
xmlns:site="http://panax.io/site"
xmlns="http://www.w3.org/1999/xhtml"
>
	<xsl:key name="seguros" match="item[@title='Seguros']/item" use="'*'"/>
	<xsl:key name="seguros" match="item[@title='Seguros de vida']/item" use="'*'"/>
	<xsl:key name="seguros" match="item[@tag]/item" use="../@tag"/>
	<xsl:param name="searchParams:tipo">*</xsl:param>

	<xsl:param name="site:aspectRatio"></xsl:param>

	<xsl:param name="title"></xsl:param>
	<xsl:template match="/">
		<xsl:variable name="seguros" select="key('seguros',$searchParams:tipo)"/>
		<xsl:variable name="section_title">
			<xsl:choose>
				<xsl:when test="$title!=''">
					<xsl:value-of select="$title"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$seguros/../@title"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div>
			<xsl:if test="$seguros/ancestor::*[@tag='seguro_vida']">
				<xsl:attribute name="class">fanvida-section</xsl:attribute>
			</xsl:if>
			<xsl:if test="not($seguros/ancestor-or-self::*[@tag='seguro_vida'])">
				<xsl:attribute name="class">fancampo-section</xsl:attribute>
			</xsl:if>
			<script>
				<![CDATA[
				for (let section of document.querySelectorAll('.fanvida-section, .fancampo-section, #video-container')) {
				observer.observe(section);
				}]]>
			</script>
			<div class="section-title" style="padding-inline: 1rem">
				<h2>
					<xsl:value-of select="$section_title" disable-output-escaping="yes"/>
				</h2>
			</div>
			<div class="row row-cols-1 row-cols-md-2 align-items-md-top g-3">
				<xsl:if test="$site:aspectRatio = 'portrait'">
					<xsl:attribute name="class">row row-cols-1 row-cols-md-2 align-items-md-top g-3</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates mode="tile" select="$seguros"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template mode="tile" match="*">
		<xsl:variable name="href">
			<xsl:value-of select="substring-before(concat(@href,'#'),'#')"/>
		</xsl:variable>
		<xsl:variable name="tipo">
			<xsl:choose>
				<xsl:when test="self::*[*]/@tag">
					<xsl:text>?tipo=</xsl:text>
					<xsl:value-of select="@tag"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('#',substring-after(@href,'#'))"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div class="tile">
			<div class="position-relative banner-2" style="overflow: hidden;
    height: 300px;">
				<img src="./assets/img/{@image}" class="img-fluid rounded" alt="" style="width: 100%;
    height: 100%;
    object-fit: cover;
    clip-path: inset(0);
    min-height: 400px;
    max-height: 400px;"/>
				<div class="text-center banner-content-2" style="gap: 15px;">
					<h4 class="mb-2 fw-bold text-accent">Seguro</h4>
					<p class="mb-2 h2 fw-bold text-white">
						<xsl:apply-templates select="@title"/>
					</p>
					<a href="{$href}{$tipo}" class="btn btn-primary px-4">Ver más</a>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>