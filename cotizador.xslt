<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xo="http://panax.io/xover"
	xmlns:state="http://panax.io/state"
	xmlns:searchParams="http://panax.io/site/searchParams"
	xmlns:selected="http://panax.io/state/selected"
>
	<xsl:import href="headers.xslt"/>
	<xsl:import href="wizard.xslt"/>

	<xsl:template name="format">
		<xsl:param name="value">0</xsl:param>
		<xsl:param name="mask">$#,##0.00;-$#,##0.00</xsl:param>
		<xsl:param name="value_for_invalid"></xsl:param>
		<xsl:choose>
			<xsl:when test="number($value)=$value">
				<xsl:value-of select="format-number($value,$mask)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value_for_invalid"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:key name="wizard.section" match="cotizaciones/@tipo_cotizacion" use="1"/>
	<xsl:key name="wizard.section" match="/*/cotizaciones[@tipo_cotizacion!='']/@*[namespace-uri()='']" use="2"/>
	<xsl:key name="wizard.section" match="/*/cotizaciones/cotizacion[@type=../@tipo_cotizacion]/@*[namespace-uri()='']" use="3"/>
	<xsl:key name="wizard.section" match="/*/cotizaciones/cotizacion[@type=../@tipo_cotizacion]/detalle[not(@xsi:type='mock')]/@especie" use="4"/>
	<xsl:key name="wizard.section" match="/*/cotizaciones/cotizacion[@type=../@tipo_cotizacion]/detalle[not(@xsi:type='mock')]/@*[namespace-uri()=''][not(name()='especie')]" use="4.1"/>

	<!--<xsl:key name="wizard.section" match="/*/cotizaciones/cotizacion[not(@type='ganadero')][@type=../@tipo_cotizacion]/detalle/@*" use="4"/>-->
	
	<xsl:key name="invalid" match="/*/cotizaciones/@*[namespace-uri()=''][.='']" use="generate-id()"/>
	<xsl:key name="invalid" match="/*/cotizaciones/cotizacion[@type=../@tipo_cotizacion]/@*[namespace-uri()=''][.='']" use="generate-id()"/>
	<xsl:key name="invalid" match="/*/cotizaciones/cotizacion[@type=../@tipo_cotizacion]/detalle/@*[namespace-uri()=''][.='']" use="generate-id()"/>
	<xsl:key name="hidden" match="@id" use="generate-id()"/>
	<xsl:key name="hidden" match="detalle[not(@seguro=1)]/@duracion" use="generate-id()"/>
	<xsl:key name="hidden" match="detalle[not(@seguro=1)]/@riesgo" use="generate-id()"/>
	<xsl:key name="hidden" match="detalle[not(@seguro=1)]/@origen_transporte" use="generate-id()"/>
	<xsl:key name="hidden" match="detalle[not(@seguro=1)]/@destino_transporte" use="generate-id()"/>
	<xsl:key name="readonly" match="@type" use="generate-id()"/>
	<xsl:key name="readonly" match="@tipo_cotizacion" use="generate-id()"/>
	<xsl:key name="readonly" match="@fecha" use="generate-id()"/>
	<xsl:key name="readonly" match="@suma_asegurada_total" use="generate-id()"/>

	<xsl:key name="dim" match="/*/*" use="name()"/>
	<xsl:key name="dim" match="/*/referencia_suma" use="'referencia_suma_asegurada'"/>
	<xsl:key name="dim" match="/*/origen_destino_transporte" use="'origen_transporte'"/>
	<xsl:key name="dim" match="/*/origen_destino_transporte" use="'destino_transporte'"/>

	<xsl:param name="searchParams:tipo"/>
	<xsl:param name="state:edit">${xo.site.searchParams.has("tipo")?2:1}</xsl:param>
	<xsl:param name="state:active">${xo.site.searchParams.has("tipo")?2:1}</xsl:param>

	<xsl:template match="/*">
		<main style="margin-top: 5rem;">
			<xsl:apply-templates mode="wizard" select=".">
				<xsl:with-param name="active" select="$state:active"/>
			</xsl:apply-templates>
		</main>
	</xsl:template>

	<xsl:template mode="wizard.styles" match="*|@*">
		<style>
			<![CDATA[
.custom-file-label {
    height: 100%;
    padding-top: 8px;
}

.custom-file, .custom-file-input {
    height: unset;
}

.custom-file-input:lang(en) ~ .custom-file-label:after {
    content: "Explorar";
    height: unset;
    padding-top: 8px;
}

.outer-container {
    font-family: "Trebuchet MS";
    font-size: 1.2rem;
}

.outer-container {
    padding: 0px 60px;
}

.step-content {
    padding: 10px 0;
    height: 100%;
}

.nav-justified > li > a {
    margin-bottom: 5px;
    text-align: center;
}

#wizard .nav-pills > li.active > a, #wizard .nav-pills > li.active > a:focus, #wizard .nav-pills > li.active > a:hover {
    color: #fff;
    background-color: var(--fancampovida-creen-snow);
}

.nav > li > a:focus, .nav > li > a:hover {
    text-decoration: none;
    background-color: #EFF3F7;
}

@media (min-width: 768px) .nav-justified>li>a {
    margin-bottom: 0;
}

.nav-justified > li > a {
    margin-bottom: 5px;
    text-align: center;
}

.nav-pills > li > a {
    border-radius: 4px;
}

.nav > li > a {
    position: relative;
    display: block;
    padding: 10px 15px;
}

a:active, a:hover {
    outline-width: 0;
}

a:focus, a:hover {
    /*color: #23527c;*/
}

a:active, a:hover {
    outline: 0;
}

.nav-pills > li + li {
    margin-left: 2px;
}

@media (min-width: 768px) .nav-justified>li {
    display: table-cell;
    width: 1%;
}

.nav-justified > li {
    float: none;
}

.nav-pills > li {
    float: left;
}

.wizard .nav-pills > li {
    padding: 0px 20px !important;
}

.nav > li {
    position: relative;
    display: block;
}

#wizard h1 {
    /*margin: .67em 0;*/
    color: rgb(126,128,131);
    font-weight: 650;
}
/*#wizard .completed h1, #wizard .completed a {
      color: white;
      }*/
.active > a > h1 {
    color: white !important;
}

#wizard li > a {
    color: rgb(126,128,131);
    white-space: nowrap;
    min-width: 200px;
}

#wizard li.completed > a, #wizard li.completed > a > h1 {
    color: white;
    background-color: var(--fancampovida-silver-cloud);
}

li span.wizard-icon-step-completed {
    position: absolute;
    top: -12px;
    right: -8px;
    font-size: 2.5em;
    color: mediumspringgreen;
}

* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}

#wizard .btn {
    <!-- font-size: 1.2em !important; -->
}

.step-content p {
    font-weight: 700;
}

.nav li a {
    min-width: 120px;
    text-decoration: none;
}

.wizard-steps-wrapper.row {
    align-items: start !important;
}

.wizard .nav {
    flex-wrap: nowrap;
}

.wizard table > thead.freeze > tr:nth-child(1) > td, .wizard table > thead.freeze > tr:nth-child(1) > th {
    top: 120px !important;
}]]>
		</style>
	</xsl:template>

	<xsl:template mode="wizard.step.title.legend" match="key('wizard.section','4')">
		<xsl:text>Detalles de seguro </xsl:text>
		<xsl:value-of select="ancestor::cotizacion/@type"/>
	</xsl:template>

	<xsl:template mode="wizard.step.title.legend" match="key('wizard.section','3')">
		<xsl:text>Datos de seguro </xsl:text>
		<xsl:value-of select="ancestor::cotizacion/@type"/>
	</xsl:template>

	<xsl:template mode="wizard.step.title.legend" match="key('wizard.section','2')">
		<xsl:text/>Generales<xsl:text/>
	</xsl:template>

	<xsl:template mode="wizard.step.title.legend" match="key('wizard.section','1')">
		<xsl:text/>Seguro a cotizar<xsl:text/>
	</xsl:template>

	<xsl:template mode="wizard.step.panel.content" match="key('wizard.section','1')">
		<xsl:param name="step" select="0"/>
		<div>
			<div class="body">
				<xsl:for-each select="key('wizard.section',$step)">
					<div class="form-group">
						<xsl:apply-templates mode="form.body.field" select="."/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template mode="wizard.step.panel.content" match="key('wizard.section','2')|key('wizard.section','3')">
		<xsl:param name="step" select="0"/>
		<div>
			<div class="body">
				<xsl:for-each select="key('wizard.section',$step)[not(key('hidden', generate-id()))]">
					<div class="form-group">
						<xsl:apply-templates mode="form.body.field" select="."/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template mode="wizard.step.panel.content" match="key('wizard.section','4')">
		<xsl:param name="step" select="0"/>
		<div>
			<div class="body">
				<div class="accordion" id="accordion_{../@xo:id}">
					<xsl:for-each select="key('wizard.section',$step)">
						<xsl:variable name="collapsed">
							<xsl:if test="../@state:collapsed">collapsed</xsl:if>
						</xsl:variable>
						<div class="accordion-item" xo-scope="{../@xo:id}" xo-slot="state:collapsed">
							<h4 class="accordion-header sticky-top">
								<button class="accordion-button {$collapsed}" type="button" data-bs-toggle="collapse" data-bs-target="#collapse_{position()}" aria-expanded="true" aria-controls="collapse_{position()}" onclick="scope.toggle(true)">
									<xsl:if test="$collapsed='collapsed'">
										<xsl:attribute name="aria-expanded">false</xsl:attribute>
									</xsl:if>
									<xsl:apply-templates mode="desc" select="."/>
								</button>
							</h4>
							<xsl:variable name="show">
								<xsl:if test="$collapsed!='collapsed'">show</xsl:if>
							</xsl:variable>
							<div id="collapse_{position()}" class="accordion-collapse collapse {$show}" data-bs-parent="#accordion_{../@xo:id}">
								<div class="accordion-body">
									<xsl:for-each select="key('wizard.section',number($step)+.1)[../@xo:id=current()/../@xo:id]">
										<div class="form-group">
											<xsl:apply-templates mode="form.body.field" select="."/>
										</div>
									</xsl:for-each>
								</div>
							</div>
						</div>
					</xsl:for-each>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template mode="wizard.step.panel.content" match="key('wizard.section','1')">
		<xsl:param name="step" select="0"/>
		<p>
			Por favor seleccione el tipo de cotización
		</p>
		<div id="main" class="mt-5" xo-source="#seguros_cotizador" xo-stylesheet="card_picker.xslt">
		</div>
	</xsl:template>


	<xsl:template mode="form.body.field" match="@*">
		<xsl:param name="step"></xsl:param>
		<xsl:variable name="headerText">
			<xsl:apply-templates mode="headerText" select="."></xsl:apply-templates>
		</xsl:variable>
		<div class="mb-3 row" style="max-width: 992px;" xo-slot="{name()}">
			<label class="col-sm-4 col-form-label text-capitalize">
				<xsl:value-of select="$headerText"/>:
			</label>
			<div class="col-sm-8">
				<xsl:apply-templates mode="control" select=".">
					<xsl:with-param name="headerText" select="$headerText"/>
				</xsl:apply-templates>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="@*" mode="wizard.buttons.back" name="wizard.buttons.back">
	</xsl:template>

	<xsl:template match="@*" mode="wizard.buttons.next" name="wizard.buttons.next">
	</xsl:template>

	<xsl:template match="@*" mode="wizard.buttons.finish" name="wizard.buttons.finish">
	</xsl:template>

	<xsl:key name="desc" match="especie/row/@desc" use="concat(name(../..),'::',../@id)"/>
	<xsl:key name="selected" match="@selected:especie" use="concat(generate-id(..), '::', local-name())"/>

	<xsl:key name="selected" match="cotizaciones/cotizacion/detalle/@especie" use="concat(generate-id(../..), '::', .)"/>

	<xsl:template mode="control" match="@*">
		<xsl:param name="headerText"/>
		<div class="form-group form-floating" style="min-width: calc(6ch + 6rem);">
			<input id="input_{@xo:id}" name="{name()}" class="form-control" type="text" value="{.}" placeholder="">
				<xsl:attribute name="type">
					<xsl:apply-templates mode="control_type" select="."/>
				</xsl:attribute>
			</input>
			<label for="input_{@xo:id}" class="text-capitalize">
				<xsl:value-of select="$headerText"/>
			</label>
		</div>
	</xsl:template>

	<xsl:template mode="control" match="*[key('dim',name())]/row">
		<xsl:param name="context" select="."/>
		<xsl:variable name="value">
			<xsl:value-of select="@id"/>
		</xsl:variable>
		<option value="{$value}">
			<xsl:if test="@id=$context">
				<xsl:attribute name="selected"/>
			</xsl:if>
			<xsl:value-of select="@desc"/>
		</option>
	</xsl:template>

	<xsl:template mode="control" match="*[key('dim',name())]">
		<xsl:param name="context" select="."/>
		<select class="form-select" xo-scope="{$context/../@xo:id}" xo-slot="{name($context)}" onchange="scope.set(this.value)">
			<option></option>
			<xsl:apply-templates mode="control" select="row">
				<xsl:with-param name="context" select="$context"/>
			</xsl:apply-templates>
		</select>
	</xsl:template>

	<xsl:template mode="control" match="municipio" priority="1">
		<xsl:param name="context" select="."/>
		<select class="form-select" xo-scope="{$context/../@xo:id}" xo-slot="{name($context)}" onchange="scope.set(this.value)">
			<option></option>
			<xsl:apply-templates mode="control" select="row[@edo=$context/../@estado]">
				<xsl:with-param name="context" select="$context"/>
			</xsl:apply-templates>
		</select>
	</xsl:template>

	<xsl:template mode="control-radio" match="*">
		<xsl:param name="context" select="."/>
		<xsl:variable name="value">
			<xsl:value-of select="@id"/>
		</xsl:variable>
		<input type="radio" class="btn-check" name="{$context/../@xo:id}_{name($context)}" id="{$context/../@xo:id}_{name($context)}_{position()}" xo-scope="{$context/../@xo:id}" xo-slot="{name($context)}" onclick="scope.set(this.value)" autocomplete="off" value="{$value}">
			<xsl:if test="$value=$context">
				<xsl:attribute name="checked"/>
			</xsl:if>
		</input>
		<label class="btn btn-outline-primary" for="{$context/../@xo:id}_{name($context)}_{position()}" xo-scope="{$context/../@xo:id}" xo-slot="{name($context)}">
			<xsl:value-of select="@desc"/>
		</label>
	</xsl:template>

	<xsl:template mode="control" match="deducible|sexo|funcionzootecnica|duracion|riesgo|origen_destino_transporte|origen_racial|financiamiento|referencia_suma" priority="1">
		<xsl:param name="context" select="."/>
		<div class="btn-group" role="group">
			<xsl:apply-templates mode="control-radio" select="row">
				<xsl:with-param name="context" select="$context"/>
			</xsl:apply-templates>
		</div>
	</xsl:template>

	<xsl:template match="@suma_asegurada_total">
		<xsl:call-template name="format">
			<xsl:with-param name="value" select="number(../@numero_cabezas) * number(../@suma_asegurada)"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template mode="control" match="@*[key('dim',name())]">
		<xsl:param name="context" select="."/>
		<xsl:apply-templates mode="control" select="key('dim',name())">
			<xsl:with-param name="context" select="."/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template mode="control" match="especie|enfermedades_zona" priority="1">
		<xsl:param name="context" select="."/>
		<xsl:variable name="selected_items" select="concat(';',$context,';')"/>
		<script>
			<![CDATA[
		function pushAndReturnArray(arr, ...elements) {
			arr.push(...elements);
			return arr;
		}]]>
		</script>
		<ul class="list-group">
			<xsl:for-each select="row">
				<xsl:variable name="active">
					<xsl:choose>
						<xsl:when test="key('selected',concat(generate-id($context/..),'::',@id))">active</xsl:when>
						<xsl:when test="contains($selected_items,concat(';',@id,';'))">active</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<li class="list-group-item list-group-item-action m-0 p-0 {$active}">
					<div class="d-flex justify-content-between align-items-start p-1 py-2" xo-scope="{$context/../@xo:id}" xo-slot="{name($context)}">
						<xsl:attribute name="onclick">
							<xsl:choose>
								<xsl:when test="$active='active'">
									<xsl:text/>scope.set(scope.value.split(/;/g).filter(item => item != '<xsl:value-of select="@id"/>').join(';'));<xsl:text/>
									<xsl:text/>scope.dispatch('eliminarDetalle', {srcElement: this, selection: closest('li').scope});<xsl:text/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text/>scope.set(pushAndReturnArray(scope.value?scope.value.split(';'):[], ('<xsl:value-of select="@id"/>')).join(';'));<xsl:text/>
									<xsl:text/>scope.dispatch('agregarDetalle', {srcElement: this, selection: closest('li').scope});<xsl:text/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<div class="ms-2 me-auto">
							<div class="fw-bold">
								<xsl:value-of select="@desc"/>
							</div>
						</div>
						<!--<span class="badge text-bg-primary rounded-pill ms-2">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gender-male" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M9.5 2a.5.5 0 0 1 0-1h5a.5.5 0 0 1 .5.5v5a.5.5 0 0 1-1 0V2.707L9.871 6.836a5 5 0 1 1-.707-.707L13.293 2zM6 6a4 4 0 1 0 0 8 4 4 0 0 0 0-8"/>
							</svg>
						</span>
						<span class="badge text-bg-primary rounded-pill ms-2">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gender-female" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M8 1a4 4 0 1 0 0 8 4 4 0 0 0 0-8M3 5a5 5 0 1 1 5.5 4.975V12h2a.5.5 0 0 1 0 1h-2v2.5a.5.5 0 0 1-1 0V13h-2a.5.5 0 0 1 0-1h2V9.975A5 5 0 0 1 3 5"/>
							</svg>
						</span>-->
					</div>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<xsl:template mode="control" match="@*[key('readonly',generate-id())]" priority="2">
		<input type="text" readonly="" tabindex="-1" class="form-control-plaintext">
			<xsl:attribute name="value">
				<xsl:apply-templates select="."/>
			</xsl:attribute>
		</input>
	</xsl:template>

	<xsl:template mode="form.body.field"  match="@*[key('hidden',generate-id())]" priority="2">
	</xsl:template>

	<xsl:template mode="control_type" match="@correoelectronico">email</xsl:template>
	<xsl:template mode="control_type" match="@fecha_siembra|@fecha_siembra|@fecha|@fecha_inicio|@fecha_fin">date</xsl:template>
	<xsl:template mode="control_type" match="@machosporasegurar|@hembrasporasegurar|@edad|@numero_cabezas|@suma_asegurada">number</xsl:template>

	<xsl:template mode="control_type" match="@*">text</xsl:template>

	<xsl:template mode="desc" match="@*|*">
		<xsl:value-of select="key('desc',concat(name(),'::',.))"/>
	</xsl:template>
</xsl:stylesheet>