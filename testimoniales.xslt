<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:env="http://panax.io/state/environment" xmlns:xo="http://panax.io/xover">

	<xsl:param name="title">Testimoniales</xsl:param>
	<xsl:template match="/*">
		<!-- src: https://codepen.io/codingyaar/pen/MWRjKqM -->
		<div class="container-fluid bg-body-tertiary py-3" data-aos="fade-up">
			<style>
				.carousel img {
				width: 70px;
				max-height: 70px;
				border-radius: 50%;
				margin-right: 1rem;
				overflow: hidden;
				}
				.carousel-inner {
				padding: 1em;
				}

				@media screen and (min-width: 576px) {
				.carousel-inner {
				display: flex;
				width: 90%;
				margin-inline: auto;
				padding: 1em 0;
				overflow: hidden;
				}
				.carousel-item {
				display: block;
				margin-right: 0;
				flex: 0 0 calc(100% / 2);
				}
				}
				@media screen and (min-width: 768px) {
				.carousel-item {
				display: block;
				margin-right: 0;
				flex: 0 0 calc(100% / 3);
				}
				}
				.carousel .card {
				margin: 0 0.5em;
				border: 0;
				}

				.carousel-control-prev,
				.carousel-control-next {
				width: 3rem;
				height: 3rem;
				background-color: grey;
				border-radius: 50%;
				top: 50%;
				transform: translateY(-50%);
				}
			</style>
			<div class="section-title" style="padding-inline: 1rem">
				<h2>
					<xsl:value-of select="$title" disable-output-escaping="yes"/>
				</h2>
			</div>
			<div id="testimonialCarousel" class="carousel">
				<div class="carousel-inner">
					<xsl:apply-templates mode="carousel-item" select="data"/>
				</div>
				<button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
			<script defer="">
				<![CDATA[
			const multipleItemCarousel = $context.querySelector("#testimonialCarousel");

if (window.matchMedia("(min-width:576px)").matches) {
  const carousel = new bootstrap.Carousel(multipleItemCarousel, {
    interval: false
  });

  const carouselInner = document.querySelector(".carousel-inner");
  const carouselItems = document.querySelectorAll(".carousel-item");
  const carouselControlNext = document.querySelector(".carousel-control-next");
  const carouselControlPrev = document.querySelector(".carousel-control-prev");
  
  let carouselWidth = carouselInner.scrollWidth;
  let cardWidth = carouselItems[0].offsetWidth;

  let scrollPosition = 0;

  carouselControlNext.addEventListener("click", function () {
    if (scrollPosition < carouselWidth - cardWidth * 3) {
      console.log("next");
      scrollPosition = scrollPosition + cardWidth;
      carouselInner.scrollTo({ left: scrollPosition, behavior: 'smooth' });
    }
  });

  carouselControlPrev.addEventListener("click", function () {
    if (scrollPosition > 0) {
      scrollPosition = scrollPosition - cardWidth;
      carouselInner.scrollTo({ left: scrollPosition, behavior: 'smooth' });
    }
  });
} else {
  multipleItemCarousel.classList.add("slide");
}

			]]>
			</script>
		</div>
	</xsl:template>

	<xsl:template mode="carousel-item" match="data">
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
		<div class="carousel-item active">
			<div class="card shadow-sm rounded-3 h-100">
				<div class="quotes display-2 text-body-tertiary">
					<i class="bi bi-quote"></i>
				</div>
				<div class="card-body d-flex flex-column">
					<p class="card-text" style="flex: 1;">
						<xsl:value-of select="$body"/>
					</p>
					<div class="d-flex align-items-center pt-2">
						<img src="{$image}" alt="bootstrap testimonial carousel slider 2"/>
						<div>
							<h5 class="card-title fw-bold">
								<xsl:value-of select="$title"/>
							</h5>
							<span class="text-secondary">
								<xsl:value-of select="$subtitle"/>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template mode="image" match="data">
		<xsl:value-of select="normalize-space(comment)"/>
	</xsl:template>

	<xsl:template mode="subtitle" match="data">
		<xsl:value-of select="normalize-space(substring-before(substring-after(value,','),':'))"/>
	</xsl:template>

	<xsl:template mode="title" match="data">
		<xsl:value-of select="normalize-space(substring-before(value,','))"/>
	</xsl:template>

	<xsl:template mode="body" match="data">
		<xsl:value-of select="normalize-space(substring-after(value,':'))"/>
	</xsl:template>
</xsl:stylesheet>