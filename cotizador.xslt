<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xo="http://panax.io/xover"
  xmlns:state="http://panax.io/state"
>
	<xsl:import href="wizard.xslt"/>

	<xsl:key name="wizard.section" match="tipocotizacion" use="concat(1,'::',generate-id())"/>
	<xsl:key name="wizard.section" match="/*[tipocotizacion/@value!='']/cliente" use="concat(2,'::',generate-id())"/>
	<xsl:key name="wizard.section" match="/*[tipocotizacion/@value!='']/*[not(@tipo)]" use="concat(2,'::',generate-id())"/>
	<xsl:key name="wizard.section" match="/*/Cotizacion[@tipo=../tipocotizacion/@value]/*[not(self::detalle)]" use="concat(3,'::',generate-id())"/>
	<xsl:key name="wizard.section" match="/*/Cotizacion[@tipo=../tipocotizacion/@value]/detalle/row[1]/*" use="concat(4,'::',generate-id())"/>

	<xsl:key name="invalid" match="*[not(@value!='')]" use="generate-id()"/>
	<xsl:key name="hidden" match="id" use="generate-id()"/>
	<xsl:key name="readonly" match="tipocotizacion" use="generate-id()"/>

	<xsl:template match="/*">
		<main style="margin-top: 5rem;">
			<xsl:apply-templates mode="wizard" select="."/>
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
}


      ]]>
		</style>
	</xsl:template>
	
	<xsl:template mode="wizard.step.title.legend" match="*[key('wizard.section',concat(4,'::',generate-id()))]">
		<xsl:text>Detalles de seguro </xsl:text>
		<xsl:value-of select="ancestor::Cotizacion/@tipo"/>
	</xsl:template>

	<xsl:template mode="wizard.step.title.legend" match="*[key('wizard.section',concat(3,'::',generate-id()))]">
		<xsl:text>Datos de seguro </xsl:text>
		<xsl:value-of select="ancestor::Cotizacion/@tipo"/>
	</xsl:template>

	<xsl:template mode="wizard.step.title.legend" match="*[key('wizard.section',concat(2,'::',generate-id()))]">
		<xsl:text/>Generales<xsl:text/>
	</xsl:template>

	<xsl:template mode="wizard.step.title.legend" match="*[key('wizard.section',concat(1,'::',generate-id()))]">
		<xsl:text/>Seguro a cotizar<xsl:text/>
	</xsl:template>

	<xsl:template mode="wizard.step.panel.content" match="*[key('wizard.section',concat(1,'::',generate-id()))]">
		<xsl:param name="step" select="0"/>
		<div>
			<div class="body">
				<xsl:for-each select="//*[key('wizard.section',concat($step,'::',generate-id()))]">
					<div class="form-group">
						<xsl:apply-templates mode="form.body.field" select="."/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template mode="wizard.step.panel.content" match="*[key('wizard.section',concat(2,'::',generate-id()))]|*[key('wizard.section',concat(3,'::',generate-id()))]|*[key('wizard.section',concat(4,'::',generate-id()))]">
		<xsl:param name="step" select="0"/>
		<div>
			<div class="body">
				<xsl:for-each select="//*[key('wizard.section',concat($step,'::',generate-id()))][not(key('hidden', generate-id()))]">
					<div class="form-group">
						<xsl:apply-templates mode="form.body.field" select="."/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template mode="wizard.step.panel.content" match="*[key('wizard.section',concat(1,'::',generate-id()))]">
		<xsl:param name="step" select="0"/>
		<p>
			Por favor seleccione el tipo de cotización
		</p>
		<div id="main" class="mt-5" xo-source="#seguros_cotizador" xo-stylesheet="card_picker.xslt">
		</div>
	</xsl:template>


	<xsl:template mode="form.body.field" match="*">
		<xsl:param name="step"></xsl:param>
		<xsl:variable name="headerText">
			<xsl:apply-templates mode="headerText" select="."></xsl:apply-templates>
		</xsl:variable>
		<div class="mb-3 row" style="max-width: 992px;" xo-scope="field_ref_5aa775b2_0524_4186_bedb_baeec4af6883" xo-slot="Name" data-field="{name()}">
			<label class="col-sm-2 col-form-label text-capitalize" xo-scope="field_ref_5aa775b2_0524_4186_bedb_baeec4af6883" xo-slot="Name">
				<xsl:value-of select="$headerText"/>:
			</label>
			<div class="col-sm-10" xo-scope="field_ref_5aa775b2_0524_4186_bedb_baeec4af6883" xo-slot="Name">
				<!--debug:info-->
				<xsl:apply-templates mode="control" select=".">
					<xsl:with-param name="headerText" select="$headerText"/>
				</xsl:apply-templates>
			</div>
		</div>
	</xsl:template>

	<xsl:template mode="headerText" match="*">
		<xsl:value-of select="name()"/>
	</xsl:template>

	<xsl:template mode="headerText" match="tipocotizacion">
		<xsl:text>Tipo de cotizacion</xsl:text>
	</xsl:template>

	<xsl:template mode="headerText" match="fechasiembra">
		<xsl:text>Fecha de siembra</xsl:text>
	</xsl:template>

	<xsl:template mode="headerText" match="fechasiembraprimerestanque">
		<xsl:text>Fecha de siembra primer estanque</xsl:text>
	</xsl:template>

	<xsl:template mode="headerText" match="upp">
		<xsl:text>UPP</xsl:text>
	</xsl:template>

	<xsl:template match="*" mode="wizard.buttons.back" name="wizard.buttons.back">
	</xsl:template>

	<xsl:template match="*" mode="wizard.buttons.next" name="wizard.buttons.next">
	</xsl:template>

	<xsl:template match="*" mode="wizard.buttons.finish" name="wizard.buttons.finish">
	</xsl:template>

	<xsl:template mode="control" match="*">
		<xsl:param name="headerText"/>
		<div class="form-group form-floating" xo-slot="value" style="min-width: calc(6ch + 6rem);">
			<input id="input_{@xo:id}" name="{name()}" class="form-control" type="text" xo-slot="value" value="{@value}" placeholder="" xo-scope="{@xo:id}"/>
			<label for="input_{@xo:id}" class="text-capitalize">
				<xsl:value-of select="$headerText"/>
			</label>
		</div>
	</xsl:template>

	<xsl:template mode="control" match="sexo">
		<div class="btn-group" role="group">
			<input type="radio" class="btn-check" name="{name()}" id="{name()}_1" autocomplete="off" xo-slot="value" onclick="scope.set(this.value)" value="macho">
				<xsl:if test="@value='macho'">
					<xsl:attribute name="checked"/>
				</xsl:if>
			</input>
			<label class="btn btn-outline-primary" for="{name()}_1">Macho</label>

			<input type="radio" class="btn-check" name="{name()}" id="{name()}_2" autocomplete="off" xo-slot="value" onclick="scope.set(this.value)" value="hembra">
				<xsl:if test="@value='hembra'">
					<xsl:attribute name="checked"/>
				</xsl:if>
			</input>
			<label class="btn btn-outline-primary" for="{name()}_2">Hembra</label>
		</div>
	</xsl:template>

	<xsl:template mode="control" match="*[key('readonly',generate-id())]">
		<input type="text" readonly="" tabindex="-1" class="form-control-plaintext" value="{@value}"/>
	</xsl:template>

	<xsl:template mode="control" match="fechasiembra|fechacosecha">
		<input id="input_{@xo:id}" name="{name()}" class="form-control" type="date" xo-slot="value" value="{@value}" placeholder="" xo-scope="{@xo:id}"/>
	</xsl:template>
</xsl:stylesheet>