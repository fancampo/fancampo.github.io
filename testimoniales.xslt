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
		<!-- src: https://codepen.io/codingyaar/pen/MWRjKqM -->
		<section id="testiomniales">
			<xsl:apply-templates/>
		</section>
	</xsl:template>

	<xsl:template match="/*">
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
			<script>
				<![CDATA[const multipleItemCarousel = document.querySelector("#testimonialCarousel");

if (window.matchMedia("(min-width:576px)").matches) {
  const carousel = new bootstrap.Carousel(multipleItemCarousel, {
    interval: false
  });

  var carouselWidth = document.querySelector(".carousel-inner").scrollWidth;
  var cardWidth = document.querySelector(".carousel-item").style.width;

  var scrollPosition = 0;

  document.querySelector(".carousel-control-next").on("click", function () {
    if (scrollPosition < carouselWidth - cardWidth * 3) {
      console.log("next");
      scrollPosition = scrollPosition + cardWidth;
      document.querySelector(".carousel-inner").animate({ scrollLeft: scrollPosition }, 800);
    }
  });
  $(".carousel-control-prev").on("click", function () {
    if (scrollPosition > 0) {
      scrollPosition = scrollPosition - cardWidth;
      $(".carousel-inner").animate({ scrollLeft: scrollPosition }, 800);
    }
  });
} else {
  $(multipleItemCarousel).addClass("slide");
}
]]>
			</script>
			<div class="section-title" style="padding-inline: 1rem">
				<h2>Testimoniales</h2>
			</div>
			<div id="testimonialCarousel" class="carousel">
				<div class="carousel-inner">
					<div class="carousel-item active">
						<div class="card shadow-sm rounded-3">
							<div class="quotes display-2 text-body-tertiary">
								<i class="bi bi-quote"></i>
							</div>
							<div class="card-body">
								<p class="card-text">
									"Some quick example text to build on the card title and make up the
									bulk of
									the card's content."
								</p>
								<div class="d-flex align-items-center pt-2">
									<img src="https://codingyaar.com/wp-content/uploads/square-headshot-1.png" alt="bootstrap testimonial carousel slider 2"/>
										<div>
											<h5 class="card-title fw-bold">Jane Doe</h5>
											<span class="text-secondary">CEO, Example Company</span>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<div class="card shadow-sm rounded-3">
							<div class="quotes display-2 text-body-tertiary">
								<i class="bi bi-quote"></i>
							</div>
							<div class="card-body">
								<p class="card-text">
									"Some quick example text to build on the card title and make up the
									bulk of
									the card's content."
								</p>
								<div class="d-flex align-items-center pt-2">
									<img src="https://codingyaar.com/wp-content/uploads/square-headshot-2.png" alt="bootstrap testimonial carousel slider 2"/>
										<div>
											<h5 class="card-title fw-bold">June Doe</h5>
											<span class="text-secondary">CEO, Example Company</span>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<div class="card shadow-sm rounded-3">
							<div class="quotes display-2 text-body-tertiary">
								<i class="bi bi-quote"></i>
							</div>
							<div class="card-body">
								<p class="card-text">
									"Some quick example text to build on the card title and make up the
									bulk of
									the card's content."
								</p>
								<div class="d-flex align-items-center pt-2">
									<img src="https://codingyaar.com/wp-content/uploads/bootstrap-profile-card-image.jpg" alt="bootstrap testimonial carousel slider 2"/>
										<div>
											<h5 class="card-title fw-bold">John Doe</h5>
											<span class="text-secondary">CEO, Example Company</span>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<div class="card shadow-sm rounded-3">
							<div class="quotes display-2 text-body-tertiary">
								<i class="bi bi-quote"></i>
							</div>
							<div class="card-body">
								<p class="card-text">
									"Some quick example text to build on the card title and make up the
									bulk of
									the card's content."
								</p>
								<div class="d-flex align-items-center pt-2">
									<img src="https://codingyaar.com/wp-content/uploads/bootstrap-profile-card-image.jpg" alt="bootstrap testimonial carousel slider 2"/>
										<div>
											<h5 class="card-title fw-bold">John Doe</h5>
											<span class="text-secondary">CEO, Example Company</span>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<div class="card shadow-sm rounded-3">
							<div class="quotes display-2 text-body-tertiary">
								<i class="bi bi-quote"></i>
							</div>
							<div class="card-body">
								<p class="card-text">
									"Un texto de ejemplo rápido para desarrollar el título de la tarjeta y componer el grueso de el contenido de la tarjeta."
								</p>
								<div class="d-flex align-items-center pt-2">
									<img src="https://codingyaar.com/wp-content/uploads/bootstrap-profile-card-image.jpg" alt="bootstrap testimonial carousel slider 2"/>
										<div>
											<h5 class="card-title fw-bold">John Doe</h5>
											<span class="text-secondary">CEO, Example Company</span>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<div class="card shadow-sm rounded-3">
							<div class="quotes display-2 text-body-tertiary">
								<i class="bi bi-quote"></i>
							</div>
							<div class="card-body">
								<p class="card-text">
									"Un texto de ejemplo rápido para desarrollar el título de la tarjeta y componer el grueso de el contenido de la tarjeta."
								</p>
								<div class="d-flex align-items-center pt-2">
									<img src="https://codingyaar.com/wp-content/uploads/bootstrap-profile-card-image.jpg" alt="bootstrap testimonial carousel slider 2"/>
										<div>
											<h5 class="card-title fw-bold">John Doe</h5>
											<span class="text-secondary">CEO, Example Company</span>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<div class="card shadow-sm rounded-3">
							<div class="quotes display-2 text-body-tertiary">
								<i class="bi bi-quote"></i>
							</div>
							<div class="card-body">
								<p class="card-text">
									"Un texto de ejemplo rápido para desarrollar el título de la tarjeta y componer el grueso de el contenido de la tarjeta."
								</p>
								<div class="d-flex align-items-center pt-2">
									<img src="https://codingyaar.com/wp-content/uploads/bootstrap-profile-card-image.jpg" alt="bootstrap testimonial carousel slider 2"/>
										<div>
											<h5 class="card-title fw-bold">John Doe</h5>
											<span class="text-secondary">CEO, Example Company</span>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<div class="card shadow-sm rounded-3">
							<div class="quotes display-2 text-body-tertiary">
								<i class="bi bi-quote"></i>
							</div>
							<div class="card-body">
								<p class="card-text">
									"Un texto de ejemplo rápido para desarrollar el título de la tarjeta y componer el grueso de el contenido de la tarjeta."
								</p>
								<div class="d-flex align-items-center pt-2">
									<img src="https://codingyaar.com/wp-content/uploads/bootstrap-profile-card-image.jpg" alt="bootstrap testimonial carousel slider 2"/>
										<div>
											<h5 class="card-title fw-bold">John Doe</h5>
											<span class="text-secondary">CEO, Example Company</span>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<div class="card shadow-sm rounded-3">
							<div class="quotes display-2 text-body-tertiary">
								<i class="bi bi-quote"></i>
							</div>
							<div class="card-body">
								<p class="card-text">
									"Un texto de ejemplo rápido para desarrollar el título de la tarjeta y componer el grueso de el contenido de la tarjeta."
								</p>
								<div class="d-flex align-items-center pt-2">
									<img src="https://codingyaar.com/wp-content/uploads/bootstrap-profile-card-image.jpg" alt="bootstrap testimonial carousel slider 2"/>
										<div>
											<h5 class="card-title fw-bold">John Doe</h5>
											<span class="text-secondary">CEO, Example Company</span>
										</div>
									</div>
							</div>
						</div>
					</div>
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
		</div>
	</xsl:template>

</xsl:stylesheet>