<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover">
	<xsl:key name="valid-model" match="root[@env:store='#aviso_privacidad']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#codigo_etica']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#mision']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#vision']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#valores']" use="generate-id()"/>
	<xsl:key name="valid-model" match="root[@env:store='#terminos_condiciones']" use="generate-id()"/>

	<xsl:key name="data" match="root[@env:store='#mision']/data" use="'mision_vision_valores'"/>
	<xsl:key name="data" match="root[@env:store='#vision']/data" use="'mision_vision_valores'"/>
	<xsl:key name="data" match="root[@env:store='#valores']/data" use="'mision_vision_valores'"/>

	<xsl:key name="data" match="data[not(contains(@name,'title'))]" use="'body'"/>
	<xsl:key name="data" match="data/@name" use="."/>

	<xsl:template match="/">
		<section>
			<xsl:apply-templates/>
		</section>
	</xsl:template>

	<xsl:template match="/*">
		<div class="album py-5 bg-body-tertiary">
			<div class="container-fluid">
				<div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 g-3">
					<xsl:apply-templates select="data"/>
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
		<div class="col-lg-2" style="text-align: center; min-height: 91px;">
			<img src="{value}" style="max-width: 25vw;"/>
			<!--<p>
				<a class="btn btn-secondary" href="#">Visitar »</a>
			</p>-->
		</div>
	</xsl:template>

</xsl:stylesheet>