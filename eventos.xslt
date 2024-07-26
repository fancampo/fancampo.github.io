<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
 xmlns:env="http://panax.io/state/environment"
 xmlns:searchParams="http://panax.io/site/searchParams"
>
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>
	<xsl:param name="searchParams:tag"/>

	<xsl:key name="data" match="data[starts-with(@name,'evento_')]/value" use="concat('#',substring(substring-after(../@name,'_'),1,8))"/>
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
			<![CDATA[
			.shape-image {
				float: left;
				height: 250px;
				margin: 0 20px 20px 0;
				shape-outside: inset(0);
				clip-path: inset(0);
				-webkit-shape-outside: inset(0);
				-webkit-clip-path: inset(0);
				object-fit: cover;
			}			
			]]>
		</style>
		<div class="container">
			<div class="row mb-2">
				<xsl:choose>
					<xsl:when test="key('data',concat('#',$searchParams:tag))">
						<xsl:apply-templates select="key('data',concat('#',$searchParams:tag))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="key('data','*')">
							<xsl:sort select="@name" order="descending"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*">
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

		<xsl:variable name="single-note" select="key('data',concat('#',$searchParams:tag))"/>
		<div class="nota col-md-6" xo-scope="data_8264da50_d9e4_4421_a595_abab434c7a9f">
			<xsl:if test="$single-note">
				<xsl:attribute name="class">nota-completa col-12</xsl:attribute>
			</xsl:if>
			<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col p-4 d-flex flex-column position-static">
					<strong class="d-inline-block mb-2 text-primary-emphasis">Evento</strong>
					<h3 class="mb-0">
						<xsl:value-of select="$title"/>
					</h3>
					<div class="mb-1 text-body-secondary">
						<xsl:apply-templates mode="date" select="."/>
					</div>
					<div class="card-text mb-auto">
						<img src="./assets/img/evento.jpg" class="img-fluid rounded-start shape-image col-12 col-md-6" alt="...">
							<xsl:apply-templates mode="image-src" select="ancestor-or-self::data[1]">
								<xsl:with-param name="path">./assets/img</xsl:with-param>
							</xsl:apply-templates>
						</img>
						<xsl:choose>
							<xsl:when test="not($single-note)">
								<xsl:value-of select="substring-before(concat($body,'&lt;wbr&gt;'),'&lt;wbr')" disable-output-escaping="yes"/>
								<br/>
								<a href="eventos.html?tag={@name}" class="btn btn-primary">
									<xsl:choose>
										<xsl:when test="contains($body,'&lt;wbr')">
											<xsl:text>Leer más...</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>Ver nota</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$body" disable-output-escaping="yes"/>
							</xsl:otherwise>
						</xsl:choose>
					</div>
				</div>
			</div>
		</div>

	</xsl:template>

	<xsl:template mode="image" match="data">
		<xsl:value-of select="normalize-space(comment)"/>
	</xsl:template>

	<xsl:template mode="title" match="data">
		<xsl:value-of select="normalize-space(substring-before(value,':'))"/>
	</xsl:template>

	<xsl:template mode="body" match="data">
		<xsl:value-of select="normalize-space(substring-after(value,':'))"/>
	</xsl:template>

	<xsl:template mode="date" match="value">
		<xsl:apply-templates mode="date" select=".."/>
	</xsl:template>

	<xsl:template mode="date" match="data">
		<xsl:variable name="date" select="substring-after(@name,'_')" />
		<xsl:value-of select="concat(substring($date, 7, 2), '-', substring($date, 5, 2), '-', substring($date, 1, 4))" />
	</xsl:template>

</xsl:stylesheet>