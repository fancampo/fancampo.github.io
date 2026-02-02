<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>

	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

	<xsl:param name="title"></xsl:param>
	<xsl:template match="/*">
		<style>
			<![CDATA[
				.XWE7Z, h6 {
				font-size: 1.125rem;
				}

				.th7fB {
				font-size: 2.5rem;
				line-height: 1.2;
				}

				@media(min-width: 992px) {
				.th7fB {
				font-size: 2.875rem;
				line-height: 1.04;
				}
				}

				@media(min-width: 1275px) {
				.th7fB {
				font-size: 3.625rem;
				line-height: 1.1;
				}
				}

				@media(min-width: 992px) {
				.d-none {
				display: none !important;
				}

				.d-flex {
				display: flex !important;
				}
				}

				@media(min-width: 992px) {
				.align-items-stretch {
				align-items: stretch !important;
				}
				}

				.bgzH8 {
				margin-bottom: 3rem;
				}

				._7gWhC {
				padding-top: 2rem;
				}

				@media(min-width: 992px) {
				.HLq40 {
				padding-top: 10rem;
				}
				}

				.ELNNc {
				padding-bottom: 0px;
				}

				.nUSAT {
				padding-bottom: 3rem;
				}

				@media(min-width: 992px) {
				.GPlvv {
				padding-bottom: 0px;
				}

				.MxERC {
				padding-bottom: 2.5rem;
				}
				}

				.GIFbq, .SZiCs {
				margin-left: auto;
				margin-right: auto;
				padding-left: 24px;
				padding-right: 24px;
				width: 100%;
				}

				@media(min-width: 576px) {
				.GIFbq {
				max-width: 552px;
				}
				}

				@media(min-width: 768px) {
				.GIFbq {
				max-width: 744px;
				}
				}

				@media(min-width: 992px) {
				.GIFbq {
				max-width: 968px;
				}
				}

				@media(min-width: 1275px) {
				.GIFbq {
				max-width: 1177px;
				}
				}

				@media(min-width: 1435px) {
				.GIFbq {
				max-width: 1337px;
				}
				}

				@media(min-width: 576px) {
				body[data-scrollbar] .GIFbq {
				max-width: 537px;
				}
				}

				@media(min-width: 768px) {
				body[data-scrollbar] .GIFbq {
				max-width: 729px;
				}
				}

				@media(min-width: 992px) {
				body[data-scrollbar] .GIFbq {
				max-width: 953px;
				}
				}

				@media(min-width: 1275px) {
				body[data-scrollbar] .GIFbq {
				max-width: 1162px;
				}
				}

				@media(min-width: 1435px) {
				body[data-scrollbar] .GIFbq {
				max-width: 1322px;
				}
				}

				._0PoPF {
				display: flex;
				flex-wrap: wrap;
				margin-left: -12px;
				margin-right: -12px;
				position: relative;
				}

				._8ymTl {
				padding-left: 12px;
				padding-right: 12px;
				position: relative;
				width: 100%;
				}

				@media(min-width: 992px) {
				.a2TI- {
				flex: 0 0 33.3333%;
				max-width: 33.3333%;
				}

				.z-b1A {
				flex: 0 0 66.6667%;
				max-width: 66.6667%;
				}

				.EqrWE {
				margin-left: 16.6667%;
				}
				}

				@media(min-width: 576px) {
				.GIFbq, .SZiCs {
				padding-left: 12px;
				padding-right: 12px;
				}
				}

				@media(min-width: 1275px) {
				.GIFbq, .SZiCs {
				padding-left: 15px;
				padding-right: 15px;
				}

				._0PoPF {
				margin-left: -15px;
				margin-right: -15px;
				}

				._8ymTl {
				padding-left: 15px;
				padding-right: 15px;
				}
				}

				.card-content {
				overflow-wrap: break-word;
				background-clip: border-box;
				background-color: rgb(255, 255, 255);
				border: 0px solid transparent;
				display: flex;
				flex-direction: column;
				min-width: 0px;
				position: relative;
				}

				.fTdrr {
				flex: 1 1 auto;
				min-height: 1px;
				padding: 24px;
				}

				._93cT6, .hy48F, .lVCsa {
				flex-shrink: 0;
				width: 100%;
				}

				.EgV6z {
				background-color: rgb(255, 255, 255);
				overflow: hidden;
				position: relative;
				}

				._1JTzq {
				opacity: 0.4;
				overflow: hidden;
				padding-top: 60%;
				position: absolute;
				width: 100%;
				}

				.qQdQz {
				border-width: 0px 1px 1px;
				border-style: solid;
				border-color: rgb(230, 230, 226);
				border-image: initial;
				position: static;
				}

				@media(min-width: 992px) {
				.box-shadow {
				cursor: pointer;
				min-height: 100%;
				transition: transform 0.15s linear 0s, box-shadow 0.15s linear 0s, -webkit-transform 0.15s linear 0s, -webkit-box-shadow 0.15s linear 0s;
				}

				.box-shadow:hover {
				box-shadow: rgba(36, 70, 70, 0.4) 0px 32px 64px 0px;
				transform: translateY(-40px);
				transition: transform 0.25s ease-out 0s, box-shadow 0.25s ease-out 0s, -webkit-transform 0.25s ease-out 0s, -webkit-box-shadow 0.25s ease-out 0s;
				}

				.box-shadow a, .box-shadow a:hover {
				text-decoration: none;
				}

				.qQdQz {
					padding: 40px 48px 48px;
					}
				}]]>
		</style>
		<div>
			<xsl:if test="$title!=''">
				<div class="section-title">
					<h2 style="text-transform: capitalize">
						<xsl:value-of select="$title"/>
					</h2>
				</div>
			</xsl:if>
			<div class="d-flex align-items-stretch _0PoPF">
				<xsl:apply-templates select="key('data','*')"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*">
		<div class="_8ymTl a2TI- nUSAT">
			<div class="card-content box-shadow">
				<div class="position-relative banner-2" style="overflow: hidden; height: 300px;">
					<a href="#">
						<img src="./assets/img/FanCampo.png" class="img-fluid rounded" alt="" style="width: 100%; object-fit: scale-down; clip-path: inset(0);">
							<xsl:apply-templates mode="image-src" select="key('image', @name)"/>
						</img>
						<div class="text-center banner-content-2" style="gap: 15px;">
							<xsl:attribute name="onclick">
								<xsl:text/>xo.site.searchParams.set('tipo', '<xsl:value-of select="@name"/>');<xsl:text/>
								<!--<xsl:text/>xo.stores.seed.selectFirst('/*/@tipocotizacion').set('<xsl:value-of select="@name"/>');<xsl:text/>-->
								<xsl:text/>xo.state.active = 2;<xsl:text/>
							</xsl:attribute>
							<h4 class="mb-2 fw-bold text-accent">Seguro</h4>
							<p class="mb-2 h2 fw-bold text-white">
								<xsl:value-of select="value"/>
							</p>
						</div>
					</a>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>