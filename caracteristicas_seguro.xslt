<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:env="http://panax.io/state/environment"
	xmlns:xo="http://panax.io/xover"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:site="http://panax.io/site"
>
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>
	<xsl:key name="data" match="data[starts-with(@name,'cobertura_')]" use="'coberturas'"/>
	<xsl:key name="data" match="data[starts-with(@name,'riesgo_')]" use="'riesgos'"/>
	<xsl:key name="data" match="data[starts-with(@name,'beneficio_')]" use="'beneficios'"/>
	<xsl:key name="data" match="data[starts-with(@name,'ventaja_')]" use="'ventajas'"/>
	<xsl:key name="data" match="data[starts-with(@name,'especie_')]" use="'especies'"/>
	<xsl:key name="data" match="data[starts-with(@name,'depredador_')]" use="'depredadores'"/>
	<xsl:key name="data" match="data[starts-with(@name,'detalles_')]" use="'detalles'"/>
	<xsl:key name="data" match="data[starts-with(@name,'carousel_')]" use="'carousel'"/>

	<xsl:param name="site:hash"></xsl:param>

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
				<xsl:otherwise>
					<xsl:value-of select="substring-after($site:hash,'#')"/>.jpg
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<section image="{$cover}" xo-stylesheet="section_title.xslt" attachment="fixed"/>
		<xsl:apply-templates mode="caracteristicas" select=".">
			<xsl:with-param name="items" select="key('data','coberturas')"/>
		</xsl:apply-templates>
		<xsl:apply-templates mode="caracteristicas_hanging" select=".">
			<xsl:with-param name="title">Tipos de Riesgos</xsl:with-param>
			<xsl:with-param name="items" select="key('data','riesgos')"/>
		</xsl:apply-templates>
		<xsl:apply-templates mode="caracteristicas_hanging" select=".">
			<xsl:with-param name="title">Beneficios Adicionales</xsl:with-param>
			<xsl:with-param name="items" select="key('data','beneficios')"/>
		</xsl:apply-templates>
		<xsl:apply-templates mode="caracteristicas_hanging" select=".">
			<xsl:with-param name="title">Especies protegidas</xsl:with-param>
			<xsl:with-param name="items" select="key('data','especies')"/>
		</xsl:apply-templates>
		<xsl:apply-templates mode="caracteristicas_hanging" select=".">
			<xsl:with-param name="title">Depredadores</xsl:with-param>
			<xsl:with-param name="items" select="key('data','depredadores')"/>
		</xsl:apply-templates>
		<xsl:apply-templates mode="caracteristicas_hanging" select=".">
			<xsl:with-param name="title"></xsl:with-param>
			<xsl:with-param name="items" select="key('data','detalles')"/>
		</xsl:apply-templates>
		<xsl:apply-templates mode="caracteristicas_hanging" select=".">
			<xsl:with-param name="title">
				¿Por qué elegir FanCampo para <xsl:value-of select="key('data','title')"/>?
			</xsl:with-param>
			<xsl:with-param name="items" select="key('data','ventajas')"/>
		</xsl:apply-templates>
		<xsl:apply-templates mode="carousel" select=".">
			<xsl:with-param name="title">Galería</xsl:with-param>
			<xsl:with-param name="items" select="key('data','carousel')|key('image',$site:hash)"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="/menu">
		<div xo-source="seed" xo-stylesheet="seguros-tiles.xslt">
		</div>
	</xsl:template>

	<xsl:template match="/*" mode="caracteristicas">
		<xsl:param name="items" select="."/>
		<xsl:variable name="description" select="key('data','description')"/>
		<xsl:if test="$description">
			<section id="caracteristicas">
				<div class="container px-4 py-5">
					<h2 class="pb-2 border-bottom">Características</h2>
					<div class="row row-cols-1 row-cols-md-1 align-items-md-top g-5 py-5">
						<div class="col d-flex flex-column align-items-start gap-2">
							<h2 class="fw-bold text-body-emphasis">¿Qué es?</h2>
							<p class="text-body-secondary">
								<xsl:apply-templates mode="description" select="$description"/>
							</p>
							<xsl:variable name="tipo">
								<xsl:choose>
									<xsl:when test="$site:hash='#pecuario'">ganadero</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="translate($site:hash,'#','')"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<!--<a href="cotizador.html?tipo={$tipo}" class="btn btn-primary btn-lg">Contratar</a>-->
						</div>
						<div class="col">
							<xsl:if test="$items">
								<h2 class="fw-bold text-body-emphasis">¿Qué cubre?</h2>
								<div class="row row-cols-1 row-cols-md-2 g-4">
									<xsl:if test="$site:hash='#bienes_patrimoniales'">
										<xsl:attribute name="class">row row-cols-1 g-4</xsl:attribute>
									</xsl:if>
									<xsl:apply-templates mode="cobertura" select="$items"/>
								</div>
							</xsl:if>
						</div>
					</div>
				</div>
			</section>
			<div class="b-divider"></div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@*" mode="tipo">
	</xsl:template>

	<xsl:template match="@*" mode="description"/>

	<xsl:template match="*" mode="description">
		<xsl:value-of select="." disable-output-escaping="yes"/>
	</xsl:template>

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

	<xsl:template match="/*" mode="carousel">
		<xsl:param name="title" select="."/>
		<xsl:param name="items" select="."/>
		<xsl:if test="$items">
			<section id="carousel">
				<div class="container px-4 py-5">
					<h2 class="pb-2 border-bottom">
						<xsl:value-of select="$title"/>
					</h2>
					<div id="carousel_autoplay" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-inner">
							<xsl:for-each select="$items">
								<xsl:variable name="active">
									<xsl:if test="position()=1">active</xsl:if>
								</xsl:variable>
								<div class="carousel-item {$active}">
									<img src="..." class="d-block w-100" alt="..." style="height: 600px; object-fit: cover;">
										<xsl:apply-templates mode="image-src" select="."></xsl:apply-templates>
									</img>
								</div>
							</xsl:for-each>
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carousel_autoplay" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carousel_autoplay" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
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
			<xsl:apply-templates mode="paragraph" select="value">
				<xsl:with-param name="class">text-body-secondary</xsl:with-param>
			</xsl:apply-templates>
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
				<xsl:choose>
					<xsl:when test="contains(value,':')">
						<h3 class="fs-2 text-body-emphasis">
							<xsl:apply-templates mode="title" select="value"/>
						</h3>
						<xsl:apply-templates mode="paragraph" select="value"/>
					</xsl:when>
					<xsl:otherwise>
						<h3 class="fs-2 text-body-emphasis">
							<xsl:apply-templates select="value"/>
						</h3>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>