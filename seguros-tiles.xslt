<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xo="http://panax.io/xover"
xmlns:searchParams="http://panax.io/site/searchParams"
xmlns="http://www.w3.org/1999/xhtml"
>
	<xsl:key name="seguros" match="item[@title='Seguros']/item" use="'*'"/>
	<xsl:key name="seguros" match="item[@title='Seguros de vida']/item" use="'*'"/>
	<xsl:key name="seguros" match="item[@tag]/item" use="../@tag"/>
	<xsl:param name="searchParams:tipo">*</xsl:param>

	<xsl:template match="/">
		<div>
			<xsl:apply-templates mode="tile" select="key('seguros',$searchParams:tipo)"/>
		</div>
	</xsl:template>

	<xsl:template mode="tile" match="*">
		<div class="col-12 col-sm-6 col-lg-4 col-xl-4 tile">
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
					<a href="{@href}" class="btn btn-primary px-4">Ver más</a>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>