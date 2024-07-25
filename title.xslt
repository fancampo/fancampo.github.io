<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">

	<xsl:param name="cover"></xsl:param>
	<xsl:param name="title"></xsl:param>
	<xsl:template match="*">
		<section class="container-fluid" style="background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url(assets/{$cover});background-repeat: no-repeat;background-size: contain;background-attachment: fixed;padding: 150px 0 50px 0;" xo-stylesheet="section_title.xslt" xo-source="inherit" xo-swap="self::*">
			<div class="container text-center py-5" style="max-width: 900px;">
				<h3 class="text-white display-3 mb-4">
					<xsl:value-of select="$title" disable-output-escaping="yes"/>
				</h3>
			</div>
		</section>
	</xsl:template>
</xsl:stylesheet>