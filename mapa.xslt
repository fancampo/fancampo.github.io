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
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
					<!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
					<path d="M96 224v32V416c0 17.7 14.3 32 32 32h32c17.7 0 32-14.3 32-32V327.8c9.9 6.6 20.6 12 32 16.1V368c0 8.8 7.2 16 16 16s16-7.2 16-16V351.1c5.3 .6 10.6 .9 16 .9s10.7-.3 16-.9V368c0 8.8 7.2 16 16 16s16-7.2 16-16V343.8c11.4-4 22.1-9.4 32-16.1V416c0 17.7 14.3 32 32 32h32c17.7 0 32-14.3 32-32V256l32 32v49.5c0 9.5 2.8 18.7 8.1 26.6L530 427c8.8 13.1 23.5 21 39.3 21c22.5 0 41.9-15.9 46.3-38l20.3-101.6c2.6-13-.3-26.5-8-37.3l-3.9-5.5V184c0-13.3-10.7-24-24-24s-24 10.7-24 24v14.4l-52.9-74.1C496 86.5 452.4 64 405.9 64H272 256 192 144C77.7 64 24 117.7 24 184v54C9.4 249.8 0 267.8 0 288v17.6c0 8 6.4 14.4 14.4 14.4C46.2 320 72 294.2 72 262.4V256 224 184c0-24.3 12.1-45.8 30.5-58.9C98.3 135.9 96 147.7 96 160v64zM560 336a16 16 0 1 1 32 0 16 16 0 1 1 -32 0zM166.6 166.6c-4.2-4.2-6.6-10-6.6-16c0-12.5 10.1-22.6 22.6-22.6H361.4c12.5 0 22.6 10.1 22.6 22.6c0 6-2.4 11.8-6.6 16l-23.4 23.4C332.2 211.8 302.7 224 272 224s-60.2-12.2-81.9-33.9l-23.4-23.4z"/>
				</svg>
			</div>
			<img src="${property.image}" style="max-height: 100%; width: auto;"/>
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