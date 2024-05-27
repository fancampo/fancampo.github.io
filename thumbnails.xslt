<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover">
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>

	<xsl:template match="/">
		<section>
			<xsl:apply-templates/>
		</section>
	</xsl:template>

	<xsl:template match="/*">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="@env:store='#beneficiarios'">row-cols-lg-3 row-cols-sm-2 row-cols-md-3</xsl:when>
				<xsl:otherwise>row-cols-2 row-cols-xl-6 row-cols-lg-5 row-cols-sm-3 row-cols-md-4</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div class="album py-5 bg-body-tertiary">
			<div class="container-fluid">
				<div class="row {$class} gy-5">
					<xsl:apply-templates select="key('data','body')"/>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="data">
		<div class="col">
			<div class="card shadow-sm">
				<svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">
					<title>Placeholder</title>
					<rect width="100%" height="100%" fill="#55595c"></rect>
					<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
				</svg>
				<div class="card-body">
					<p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
					<div class="d-flex justify-content-between align-items-center">
						<div class="btn-group">
							<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
							<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
						</div>
						<small class="text-body-secondary">9 mins</small>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="data">
		<div style="text-align: center; min-height: 91px;">
			<a href="#" target="_blank">
				<xsl:if test="comment!=''">
					<xsl:attribute name="href">
						<xsl:value-of select="comment"/>
					</xsl:attribute>
				</xsl:if>
				<img src="{normalize-space(value)}" style="max-width: 25vw;"/>
			</a>
		</div>
	</xsl:template>

</xsl:stylesheet>