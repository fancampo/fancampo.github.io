<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment">
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
		<div class="album py-5">
			<div class="container-fluid">
				<div class="row {$class} gy-5">
					<xsl:choose>
						<xsl:when test="@env:store='#uniones'">
							<xsl:apply-templates select="key('data','*')">
								<xsl:sort select="boolean(@name='socio_00')" order="descending"/>
								<xsl:sort select="boolean(@name='socio_99')"/>
								<xsl:sort select="comment"/>
								<xsl:sort select="value"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="key('data','*')">
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="data">
		<div style="min-height: 91px; overflow: hidden; align-items: center; display: flex; justify-content: center; margin-bottom: 3rem; text-align: center;">
			<a href="#" target="_self">
				<xsl:if test="comment!=''">
					<xsl:attribute name="href">
						<xsl:value-of select="comment"/>
					</xsl:attribute>
				</xsl:if>
				<img src="{normalize-space(value)}" style="max-width: 25vw;
        min-height: 110px; min-width: 110px;">
					<xsl:apply-templates mode="image-src" select="."/>
				</img>
				<xsl:if test="not(starts-with(value,'http'))">
					<label>
						<xsl:apply-templates mode="title" select="."/>
					</label>
				</xsl:if>
			</a>
		</div>
	</xsl:template>

</xsl:stylesheet>