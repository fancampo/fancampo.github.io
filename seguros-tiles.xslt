<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xo="http://panax.io/xover"
xmlns="http://www.w3.org/1999/xhtml"
>
	<xsl:key name="seguros" match="item[@title='Seguros agropecuarios']/item" use="'*'"/>
	<xsl:key name="seguros" match="item[@title='Seguros de vida']/item" use="'*'"/>
	
	<xsl:template match="/">
		<div>
			<xsl:apply-templates mode="tile" select="key('seguros','*')"/>
		</div>
	</xsl:template>

	<xsl:template mode="tile" match="*">
		<div class="col-xs-6 col-sm-6 col-md-3">
			<div class="position-relative banner-2">
				<img src="./assets/img/{@image}" class="img-fluid rounded" alt=""/>
				<div class="text-center banner-content-2">
					<h4 class="mb-2 fw-bold text-white">Seguro</h4>
					<p class="mb-2 h2 fw-bold text-white">
						<xsl:apply-templates select="@title"/>
					</p>
					<a href="#" class="btn btn-primary px-4">Ver más</a>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>