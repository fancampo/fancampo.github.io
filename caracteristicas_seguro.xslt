<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover" xmlns:swap="http://panax.io/xover/swap" xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>
	<xsl:key name="data" match="data[starts-with(@name,'cobertura_')]" use="'coberturas'"/>
	<xsl:key name="data" match="data[starts-with(@name,'beneficio_')]" use="'beneficios'"/>
	<xsl:key name="data" match="data[starts-with(@name,'ventaja_')]" use="'ventajas'"/>

	<xsl:template match="/">
		<main>
			<xsl:apply-templates/>
		</main>
	</xsl:template>

	<xsl:template match="/root">
		<xsl:variable name="cover">
			<xsl:choose>
				<xsl:when test="key('data','cover')">
					<xsl:value-of select="normalize-space(key('data','cover'))"/>
				</xsl:when>
				<xsl:otherwise>cover.jpg</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<section class="container-fluid bg-breadcrumb" style="background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url(assets/img/{$cover}); background-position: center center;background-repeat: no-repeat;background-size: cover;background-attachment: fixed;padding: 150px 0 50px 0;" xo-stylesheet="section_title.xslt" xo-source="seed" xo-swap="@style">
		</section>
		<xsl:apply-templates mode="caracteristicas" select=".">
			<xsl:with-param name="items" select="key('data','coberturas')"/>
		</xsl:apply-templates>
		<xsl:apply-templates mode="caracteristicas_hanging" select=".">
			<xsl:with-param name="title">Beneficios Adicionales</xsl:with-param>
			<xsl:with-param name="items" select="key('data','beneficios')"/>
		</xsl:apply-templates>
		<xsl:apply-templates mode="caracteristicas_hanging" select=".">
			<xsl:with-param name="title">
				¿Por qué elegir FanCampo para <xsl:value-of select="key('data','title')"/>?
			</xsl:with-param>
			<xsl:with-param name="items" select="key('data','ventajas')"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="/menu">
		<section class="container-fluid bg-breadcrumb" style="background-color: var(--fancampovida-blue-smoke);">
		</section>
		<div class="b-divider"></div>
		<div class="row g-4" xo-source="seed" xo-stylesheet="seguros-tiles.xslt">
		</div>
		<div class="b-divider"></div>
	</xsl:template>

	<xsl:template match="/*" mode="caracteristicas">
		<xsl:param name="items" select="."/>
		<section id="caracteristicas">
			<div class="container px-4 py-5">
				<h2 class="pb-2 border-bottom">Características</h2>
				<div class="row row-cols-1 row-cols-md-2 align-items-md-top g-5 py-5">
					<div class="col d-flex flex-column align-items-start gap-2">
						<h2 class="fw-bold text-body-emphasis">¿Qué es?</h2>
						<p class="text-body-secondary">
							<xsl:apply-templates mode="description" select="key('data','description')"/>
						</p>
						<a href="#" class="btn btn-primary btn-lg">Contratar</a>
					</div>

					<div class="col">
						<div class="row row-cols-1 row-cols-sm-2 g-4">
							<xsl:apply-templates mode="cobertura" select="$items"/>
						</div>
					</div>
				</div>
			</div>
		</section>
		<div class="b-divider"></div>
	</xsl:template>

	<xsl:template match="@*" mode="description"/>

	<xsl:template match="/*" mode="caracteristicas_hanging">
		<xsl:param name="title" select="."/>
		<xsl:param name="items" select="."/>
		<xsl:if test="$items">
			<section id="razones">
				<div class="container px-4 py-5" id="hanging-icons">
					<h2 class="pb-2 border-bottom">
						<xsl:value-of select="$title"/>
					</h2>
					<div class="row g-4 py-5 row-cols-1 row-cols-lg-3">
						<xsl:apply-templates mode="hanging" select="$items"/>
					</div>
				</div>
			</section>
			<div class="b-divider"></div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="data">
		<xsl:apply-templates select="value"/>
	</xsl:template>

	<xsl:template mode="cobertura" match="data">
		<div class="col d-flex flex-column gap-2">
			<div class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
				<svg class="bi" width="1em" height="1em">
					<use xlink:href="#collection"></use>
				</svg>
			</div>
			<h4 class="fw-semibold mb-0 text-body-emphasis">
				<xsl:apply-templates mode="title" select="value"/>
			</h4>
			<p class="text-body-secondary">
				<xsl:apply-templates mode="body" select="value"/>
			</p>
		</div>
	</xsl:template>

	<xsl:template mode="hanging" match="data">
		<div class="col d-flex align-items-start">
			<div class="icon-square text-body-emphasis bg-body-secondary d-inline-flex align-items-center justify-content-center fs-4 flex-shrink-0 me-3">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
					<path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0"/>
					<path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0z"/>
				</svg>
			</div>
			<div>
				<h3 class="fs-2 text-body-emphasis">
					<xsl:apply-templates mode="title" select="value"/>
				</h3>
				<p>
					<xsl:apply-templates mode="body" select="value"/>
				</p>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>