<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment"
 xmlns:searchParams="http://panax.io/site/searchParams"
>
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>
	<xsl:param name="searchParams:tag"/>

	<xsl:key name="data" match="data[starts-with(@name,'evento_')]/value" use="concat('#',substring(substring-after(../@name,'_'),1,8))"/>
	<xsl:template match="/">
		<script src="https://cdn.jsdelivr.net/npm/masonry-layout@4.2.2/dist/masonry.pkgd.min.js" integrity="sha384-GNFwBvfVxBkLMJpYMOABq3c+d3KnQxudP/mGPkzpZSTYykLBNsZEnG2D9G/X/+7D" crossorigin="anonymous" async="" defer=""></script>
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
				min-height: 250px;
				margin: 0 20px 20px 0;
				shape-outside: inset(0);
				clip-path: inset(0);
				-webkit-shape-outside: inset(0);
				-webkit-clip-path: inset(0);
				object-fit: cover;
			}
			
			.clearfix::after {
				content: "";
				clear: both;
				display: table;
			}
			]]>
		</style>
		<div class="container">
			<div class="row g-4" data-masonry="{{&quot;percentPosition&quot;: true }}">
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

	<xsl:template match="value">
		<xsl:apply-templates select="parent::data"/>
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

		<xsl:variable name="single-note" select="key('data',concat('#',$searchParams:tag))"/>
		<div class="nota col-lg-6 ">
			<xsl:if test="$single-note">
				<xsl:attribute name="class">nota-completa col-12</xsl:attribute>
			</xsl:if>
			<div class="card">
				<div class="p-4 d-flex flex-column position-static">
					<strong class="d-inline-block mb-2 text-primary-emphasis">Evento</strong>
					<h3 class="mb-0">
						<xsl:value-of select="$title" disable-output-escaping="yes"/>
					</h3>
					<div class="mb-1 text-body-secondary">
						<xsl:apply-templates mode="date" select="."/>
					</div>
					<div class="card-text mb-auto clearfix" style="min-height: 250px;">
						<xsl:apply-templates mode="widget" select="key('file', @name)"/>
						<p>
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
												<xsl:attribute name="style">display:none;</xsl:attribute>
												<xsl:text>Ver nota</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</a>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$body" disable-output-escaping="yes"/>
								</xsl:otherwise>
							</xsl:choose>
						</p>
						<div class="row">
							<xsl:apply-templates mode="gallery" select="key('file', concat('#',@name))"/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template mode="gallery" match="*">
		<div class="col-6">
			<xsl:apply-templates mode="widget" select="key('file', ancestor-or-self::data[1]/@name)">
				<xsl:with-param name="html:class">img-fluid</xsl:with-param>
			</xsl:apply-templates>
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

	<xsl:template mode="widget" match="*">
		<comment>No mapeado</comment>
	</xsl:template>

	<xsl:template mode="widget" match="key('widget','video')">
		<video src="./assets/img/evento.jpg" class="shape-image col-12 col-md-6" autoplay="true" muted="true" alt="..." controls="">
			<xsl:apply-templates mode="src-attribute" select="ancestor-or-self::data[1]">
				<xsl:with-param name="path">./assets/img</xsl:with-param>
			</xsl:apply-templates>
		</video>
	</xsl:template>

	<xsl:template mode="widget" match="key('widget','image')">
		<xsl:param name="html:class">img-fluid rounded-start shape-image col-12 col-md-6</xsl:param>
		<img src="./assets/img/evento.jpg" class="{$html:class}" alt="...">
			<xsl:apply-templates mode="src-attribute" select="ancestor-or-self::data[1]">
				<xsl:with-param name="path">./assets/img</xsl:with-param>
			</xsl:apply-templates>
		</img>
	</xsl:template>
</xsl:stylesheet>