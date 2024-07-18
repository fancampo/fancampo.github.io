<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xo="http://panax.io/xover"
xmlns:searchParams="http://panax.io/site/searchParams"
xmlns="http://www.w3.org/1999/xhtml"
>
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>
	<xsl:param name="title"></xsl:param>

	<xsl:template mode="mapa-coordenadas" match="*">
		<xsl:if test="position()&gt;1">, </xsl:if>
		<xsl:value-of select="../comment"/>
	</xsl:template>
	
	<xsl:template match="root">
		<div>
			<script>
				<![CDATA[
		window.initMap = function() {
			map = new google.maps.Map(document.getElementById('map'), {
				zoom: 5.3,
				center: { "lat": 25.0000, "lng": -102.0000 },
				streetViewControl: false,
				tilt: 0,
				mapId: "nuestra_presencia",
				zoomControlOptions: {
				position: google.maps.ControlPosition.LEFT_BOTTOM
				}
			});

			let uniones = []]>
				<xsl:apply-templates mode="mapa-coordenadas" select="key('image','*')"/>
				<![CDATA[];

			for (let point of uniones.filter(el => el)) {
				const AdvancedMarkerElement = new google.maps.marker.AdvancedMarkerElement({
					map,
					content: buildContent(point),
					position: point,
					title: point.title,
				});

				AdvancedMarkerElement.addListener("click", () => {
					toggleHighlight(AdvancedMarkerElement, point);
				});
			}
		}

		function toggleHighlight(markerView, property) {
			if (markerView.content.classList.contains("highlight")) {
				markerView.content.classList.remove("highlight");
				markerView.zIndex = null;
			} else {
				markerView.content.classList.add("highlight");
				markerView.zIndex = 1;
			}
		}

		function buildContent(property) {
			const content = document.createElement("div");

			content.classList.add("property");
			content.innerHTML = `
			<div class="icon">
				<img class="logo" src="${property.image}"/>
			</div>
			<div class="details">
				<h4>${property.title}</h4>
				<div class="address">${property.address}</div>
				<!--<div class="features">
							<div>
								<i aria-hidden="true" class="fa fa-bed fa-lg bed" title="bedroom"></i>
								<span class="fa-sr-only">bedroom</span>
								<span>${property.bed}</span>
							</div>
							<div>
								<i aria-hidden="true" class="fa fa-bath fa-lg bath" title="bathroom"></i>
								<span class="fa-sr-only">bathroom</span>
								<span>${property.bath}</span>
							</div>
							<div>
								<i aria-hidden="true" class="fa fa-ruler fa-lg size" title="size"></i>
								<span class="fa-sr-only">size</span>
								<span>${property.size} ft<sup>2</sup></span>
							</div>
						</div>-->
			</div>
			`;
			return content;
		}]]>
			</script>
			<div class="section-title">
				<h2>
					<xsl:value-of select="$title" disable-output-escaping="yes"/>
				</h2>
			</div>
			<div id="map" style="height:95vh; width:auto" xo-static="self::*"></div>
			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCf4CxGRp-FNTXD2Db54g3mzr-M25E7AlY&amp;callback=initMap&amp;v=weekly&amp;libraries=marker" defer="" async=""></script>
		</div>
	</xsl:template>
</xsl:stylesheet>