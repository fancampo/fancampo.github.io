<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xo="http://panax.io/xover"
xmlns:state="http://panax.io/state"
xmlns="http://www.w3.org/1999/xhtml"
>
	<xsl:import href="keys.xslt"/>
	<xsl:import href="common.xslt"/>
	<xsl:template match="*[@state:version='v1']">
		<section>
			<div class="container" data-aos="fade-up">
				<div class="row content">
					<div class="col-lg-6">
						<div class="position-relative overflow-hidden rounded ps-5 pt-5 h-100"
							 style="min-height: 400px">
							<img class="position-absolute w-100 h-100" src="assets/img/Imagen6.jpg" alt=""
								 style="object-fit: cover"/>
							<div class="position-absolute top-0 start-0 bg-white rounded" style="width: 200px; height: 200px">
								<div class="d-flex flex-column justify-content-center text-center bg-primary rounded h-100" style=" border-color: var(--fancampovida-creen-snow) !important; background-color: var(--fancampovida-creen-snow) !important; ">
									<img class="w-100 h-100" src="assets/img/imagen3.jpg" alt="" style="object-fit: cover"/>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div>
							<div class="section-title">
								<h2>Nuestra gestión de riesgos</h2>
							</div>
							<div class="row gy-4">
								<div class="col-12">
									<div class="d-flex">
										<div class="flex-shrink-0 btn-lg-square rounded-circle bg-primary">
											<i class="fa fa-check text-white"></i>
										</div>
										<div class="ms-4">
											<h4>Protege el patrimonio</h4>
											<span>
												de los productores agropecuarios de México y la continuidad operativa
												de sus unidades de producción
											</span>
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="d-flex">
										<div class="flex-shrink-0 btn-lg-square rounded-circle bg-primary">
											<i class="fa fa-check text-white"></i>
										</div>
										<div class="ms-4">
											<h4>Consolida un sector agropecuario</h4>
											<span>
												con capacidad, recursos y cultura para administrar los riesgos que
												afectan a la actividad rural nacional
											</span>
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="d-flex">
										<div class="flex-shrink-0 btn-lg-square rounded-circle bg-primary">
											<i class="fa fa-check text-white"></i>
										</div>
										<div class="ms-4">
											<h4>Teniendo valores </h4>
											<span>
												como la ética profesional, compromiso, responsabilidad, honestidad
												para satisfacer las necesidades de administración de riesgos de los
												productores.
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</xsl:template>

	<xsl:template match="*[@state:version='v1']">
		<section>
			<div class="container row mx-2" data-aos="fade-up" style="display: flex;
    justify-content: end;">
				<div class="col-lg-5 col-12 info" style="background-color: white; padding-block: 2rem; text-align: center; padding-inline: 0;">
					<div class="section-title" style="padding-inline: 1rem">
						<h2>Nuestra gestión de riesgos</h2>
					</div>
					<div class="row gy-4">
						<div class="col-12">
							<div class="d-flex">
								<div class="">
									<h4 style="background-color: var(--fancampovida-blue-smoke); color:white;">Protege el patrimonio</h4>
									<span style="padding-inline: 1rem;">
										de los productores agropecuarios de México y la continuidad operativa
										de sus unidades de producción
									</span>
								</div>
							</div>
						</div>
						<div class="col-12">
							<div class="d-flex">
								<div class="">
									<h4 style="background-color: var(--fancampovida-creen-snow); color:white;">Consolida un sector agropecuario</h4>
									<span style="padding-inline: 1rem;">
										con capacidad, recursos y cultura para administrar los riesgos que
										afectan a la actividad rural nacional
									</span>
								</div>
							</div>
						</div>
						<div class="col-12">
							<div class="d-flex">
								<div class="">
									<h4 style="background-color: var(--fancampovida-blue-smoke); color:white;">Teniendo valores </h4>
									<span style="padding-inline: 1rem;">
										como la ética profesional, compromiso, responsabilidad, honestidad
										para satisfacer las necesidades de administración de riesgos de los
										productores.
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</xsl:template>

	<xsl:template match="*">
		<section>
			<div class="container-fluid" data-aos="fade-up">
				<div class="section-title">
					<h2 style="text-transform: capitalize">
						Nuestra <span style="color: var(--fancampovida-creen-snow)">gestión de riesgos</span>
					</h2>
				</div>
				<div class="row content">
					<div class="col-lg-8">
						<div class="position-relative overflow-hidden rounded h-100 pb-5">
							<img class="w-100" src="assets/img/nuestra_gestion.jpg" alt=""
								 style="object-fit: contain">
							</img>
						</div>
					</div>
					<div class="col-lg-4">
						<div>
							<div class="row gy-4">
								<div class="col-12">
									<div class="d-flex">
										<div class="flex-shrink-0 btn-lg-square rounded-circle bg-primary">
											<i class="fa fa-check text-white"></i>
										</div>
										<div class="ms-4">
											<h4>Protege el patrimonio</h4>
											<span>
												de los productores agropecuarios de México y la continuidad operativa
												de sus unidades de producción
											</span>
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="d-flex">
										<div class="flex-shrink-0 btn-lg-square rounded-circle bg-primary">
											<i class="fa fa-check text-white"></i>
										</div>
										<div class="ms-4">
											<h4>Consolida un sector agropecuario</h4>
											<span>
												con capacidad, recursos y cultura para administrar los riesgos que
												afectan a la actividad rural nacional
											</span>
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="d-flex">
										<div class="flex-shrink-0 btn-lg-square rounded-circle bg-primary">
											<i class="fa fa-check text-white"></i>
										</div>
										<div class="ms-4">
											<h4>Teniendo valores </h4>
											<span>
												como la ética profesional, compromiso, responsabilidad, honestidad
												para satisfacer las necesidades de administración de riesgos de los
												productores.
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</xsl:template>
</xsl:stylesheet>