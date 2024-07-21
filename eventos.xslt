<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xlink="http://www.w3.org/1999/xlink">
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
				<xsl:otherwise>row-cols-2</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--<div class="album py-5 bg-body-tertiary">
			<div class="container-fluid">
				<div class="row {$class} gy-5">
					<xsl:apply-templates select="key('data','*')"/>
				</div>
			</div>
		</div>-->
		<style>
			.shape-image {
			float: left;
			width: 200px;
			height: 250px; /* Adjust height to make it rectangular */
			margin: 0 20px 20px 0;
			shape-outside: inset(0);
			clip-path: inset(0);
			-webkit-shape-outside: inset(0);
			-webkit-clip-path: inset(0);
			}
		</style>
		<div class="container">
			<div class="row mb-2">
				<xsl:apply-templates select="key('data','*')">
					<xsl:sort select="@name" order="descending"/>
				</xsl:apply-templates>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="data">
		<xsl:variable name="title">
			<xsl:apply-templates mode="title" select="."/>
		</xsl:variable>
		<xsl:variable name="subtitle">
			<xsl:apply-templates mode="subtitle" select="."/>
		</xsl:variable>
		<xsl:variable name="body">
			<xsl:apply-templates mode="body" select="."/>
		</xsl:variable>
		<xsl:variable name="image">
			<xsl:apply-templates mode="image" select="."/>
		</xsl:variable>
		<xsl:variable name="date">
			<xsl:apply-templates mode="date" select="."/>
		</xsl:variable>
		<div class="col-md-6" xo-scope="data_8264da50_d9e4_4421_a595_abab434c7a9f">
			<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<strong class="d-inline-block mb-2 text-primary-emphasis">Evento</strong>
					<h3 class="mb-0">
						<xsl:value-of select="$title"/>
					</h3>
					<div class="mb-1 text-body-secondary">
						<xsl:apply-templates mode="date" select="."/>
					</div>
					<p class="card-text mb-auto">
						<img src="./assets/img/evento.jpg" class="img-fluid rounded-start shape-image" alt="..."/>
						<xsl:value-of select="$body"/>
					</p>
				</div>
			</div>
		</div>




		<!--<div class="col-md-6">
			<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<strong class="d-inline-block mb-2 text-primary-emphasis">Evento</strong>
					<h3 class="mb-0">
						<xsl:value-of select="$title"/>
					</h3>
					<div class="mb-1 text-body-secondary">Nov 12</div>
					<p class="card-text mb-auto">
						<xsl:value-of select="$body"/>
					</p>
					-->
		<!--<a href="#" class="icon-link gap-1 icon-link-hover stretched-link">
						Continue reading
						<svg class="bi">
							<use xlink:href="#chevron-right"></use>
						</svg>
					</a>-->
		<!--
				</div>
				<div class="col-auto d-none d-lg-block">
					<img src="./assets/img/evento.jpg" class="img-fluid rounded-start" alt="...">
						<xsl:apply-templates mode="image-src" select="key('image', comment)"/>
					</img>
				</div>
			</div>
		</div>-->

	</xsl:template>

	<!--<xsl:template match="data">
		<div class="card m-3" style="max-width: 540px;">
			<div class="row g-0">
				<div class="col-md-4">
					<img src="./assets/logos_ligas/fira.png" class="img-fluid rounded-start" alt="...">
						<xsl:apply-templates mode="image-src" select="key('image', comment)"/>
					</img>
				</div>
				<div class="col-md-8">
					<div class="card-body">
						<h5 class="card-title">
							<a href="{value}" class="list-group-item list-group-item-action" aria-current="true" style="text-align: center" target="_blank">
								<h3>
									<xsl:apply-templates mode="title" select="@name"/>
								</h3>
							</a>
						</h5>
						-->
	<!--<p class="card-text"></p>-->
	<!--
					</div>
				</div>
			</div>
		</div>
	</xsl:template>-->

	<xsl:template mode="image" match="data">
		<xsl:value-of select="normalize-space(comment)"/>
	</xsl:template>

	<xsl:template mode="title" match="data">
		<xsl:value-of select="normalize-space(substring-before(value,':'))"/>
	</xsl:template>

	<xsl:template mode="body" match="data">
		<xsl:value-of select="normalize-space(substring-after(value,':'))"/>
	</xsl:template>

	<xsl:template mode="date" match="data">
		<xsl:variable name="date" select="substring-after(@name,'_')" />
		<xsl:value-of select="concat(substring($date, 7, 2), '-', substring($date, 5, 2), '-', substring($date, 1, 4))" />
	</xsl:template>

</xsl:stylesheet>