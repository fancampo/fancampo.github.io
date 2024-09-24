<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
xmlns:xo="http://panax.io/xover"
xmlns:session="http://panax.io/session"
xmlns:sitemap="http://panax.io/sitemap"
xmlns:shell="http://panax.io/shell"
xmlns:state="http://panax.io/state"
xmlns:site="http://panax.io/site"
xmlns:meta="http://panax.io/site/meta"
				
xmlns:js="http://panax.io/languages/javascript"
xmlns:login="http://widgets.panaxbi.com/login"
>
	<xsl:output method="xml"
	   omit-xml-declaration="yes"
	   indent="yes"/>

	<xsl:param name="session:debug"/>

	<xsl:param name="session:user_login"/>
	<xsl:param name="session:status"/>
	<xsl:param name="session:connection_id"/>
	<xsl:param name="js:year">new Date().getFullYear()</xsl:param>
	<xsl:param name="js:secure"><![CDATA[location.protocol.indexOf('https')!=-1 || location.hostname=='localhost']]></xsl:param>
	<xsl:param name="site:seed"/>
	<xsl:param name="site:location-host"/>
	<xsl:param name="site:location-pathname"/>
	<xsl:param name="meta:google-signin-client_id"/>

	<xsl:template match="/" priority="-1">
		<xsl:apply-templates mode="login:widget"/>
	</xsl:template>

	<xsl:template match="*" mode="login:widget">
		<dialog style="width: fit-content; max-width: 600px; margin: auto; padding: 1rem; overflow: auto; position: fixed; z-index: var(--zindex-modal, 1055); min-width: fit-content; max-width: 90%;" role="alertdialog" xo-scope="xo_login_9226cda2_93a2_443c_b052_b1c636ef3d8c" xo-source="#login" xo-stylesheet="login.xslt" open="">
			<header style="display:flex;justify-content: end;">
				<button type="button" formmethod="dialog" aria-label="Close" onclick="this.closest('dialog').remove();" style="background-color:transparent;border: none;">
					<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-x-circle text-primary_messages" viewBox="0 0 24 24">
						<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
						<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"></path>
					</svg>
				</button>
			</header>
			<xsl:if test="$js:secure='true'">
				<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css"/>
				<script src="https://accounts.google.com/gsi/client" async="" defer=""></script>
				<!--<script src="https://apis.google.com/js/platform.js" async="" defer=""></script>-->
			</xsl:if>
			<style>
				<![CDATA[
.login {
	display: -ms-flexbox;
	display: -webkit-box;
	display: flex;
	-ms-flex-align: center;
	-ms-flex-pack: center;
	-webkit-box-align: center;
	align-items: center;
	-webkit-box-pack: center;
	justify-content: center;
	padding-top: 40px;
	padding-bottom: 40px;
	background-color: #f5f5f5;
	height: 100vh;
	width: 100vw;
}

.form-signin {
	min-width: fit-content;
	max-width: 330px;
	padding: 15px;
	margin: 0 auto;
}

.form-signin .checkbox {
	font-weight: 400;
}

.form-signin .form-control {
	position: relative;
	box-sizing: border-box;
	height: auto;
	padding: 10px;
	font-size: 16px;
}

.form-signin .form-control:focus {
	z-index: 2;
}

.form-signin input[type="email"] {
	margin-bottom: -1px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
	margin-bottom: 10px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}

.form-signin {
    text-align: center;
}

.form-signin #logo {
	max-height: 100%
}

.form-signin #logo img {
	max-height: 100%
}]]>
			</style>
			<script src="login.js" fetchpriority="high"/>
			<form class="form-signin d-flex flex-column align-items-center gap-3" method="dialog" onsubmit="closest('dialog').remove()">
				<div id="logo" class="">
					<!--<img src="assets/img/FanVida.png" alt="" class="img-fluid" style="max-width: 80%;"/>-->
					<img src="assets/img/FanCampo.png" alt="" class="img-fluid" style="view-transition-name: transition;"/>
				</div>
				<h1 class="h3 mb-3 font-weight-normal mx-auto">Bienvenido</h1>
				<xsl:choose>
					<xsl:when test="$js:secure='true'">
						<!--<label for="username" class="sr-only">Username</label>-->
						<input type="email" id="username" class="form-control" placeholder="Username" autocomplete="username" required="" autofocus="" oninvalid="this.setCustomValidity('Escriba su usuario')" oninput="this.setCustomValidity('')" value="{$session:user_login}" xo-slot="username">
							<xsl:if test="not($session:debug='true')">
								<xsl:attribute name="disabled"/>
							</xsl:if>
							<xsl:if test="@username">
								<xsl:attribute name="value">
									<xsl:value-of select="@username"/>
								</xsl:attribute>
							</xsl:if>
						</input>
						<!--<label for="password" class="sr-only">Password</label>
						<input type="password" id="password" class="form-control" placeholder="Password" autocomplete="current-password" required="" oninvalid="this.setCustomValidity('Escriba su contraseña')" oninput="this.setCustomValidity('')">
							<xsl:if test="$session:status='authorizing' or $session:status='authorized'">
								<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
								<xsl:attribute name="readonly"></xsl:attribute>
							</xsl:if>
						</input>-->
						<xsl:apply-templates mode="login:button" select="."/>
						<div class="container" style="height: 60px;">
							<xsl:if test="$meta:google-signin-client_id!='' and $js:secure='true' and $session:status!='authorizing'">
								<div class="container" xo-static="self::*" style="height: 60px;">
									<!--<div class="g-signin2" data-onsuccess="onGoogleLogin" ></div>-->
									<div id="g_id_onload"
									data-client_id="{$meta:google-signin-client_id}"
									data-callback="onGoogleLogin"
									data-auto_prompt="false">
									</div>
									<div class="g_id_signin signup_button"
										 data-type="standard"
										 data-size="large"
										 data-theme="outline"
										 data-text="sign_in_with"
										 data-shape="rectangular"
										 data-logo_alignment="left">
									</div>
								</div>
							</xsl:if>
						</div>
						<p class="mt-5 mb-3 text-muted mx-auto">
							© FanCampo <xsl:value-of select="$js:year"/>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<h3>Por favor visita</h3>
						<xsl:variable name="url">
							<xsl:value-of select="concat('https://', $site:location-host, $site:location-pathname)"/>
						</xsl:variable>
						<h4>
							<a href="{$url}">
								<xsl:value-of select="$url"/>
							</a>
						</h4>
					</xsl:otherwise>
				</xsl:choose>
			</form>
			<!--<form method="dialog" onsubmit="closest('dialog').remove()">
				<div class="p-5 mb-4 bg-light rounded-3">
					<div class="container-fluid py-5">
						<h1 class="display-5 fw-bold">Welcome to xover!</h1>
						<p class="col-md-8 fs-4">It looks like login feature is enabled and requires a template.</p>
						<p>Please create your templates in your own transformation file.</p>
						<p>Starting with login.xslt is a good idea.</p>
						<a href="https://xover.dev" target="_blank">Show me how!</a>
					</div>
				</div>
			</form>-->
		</dialog>
	</xsl:template>

	<xsl:template mode="login:button" match="*|@*">
		<button class="btn btn-lg btn-primary btn-block color-orange" type="submit">
			<xsl:choose>
				<xsl:when test="$session:status='authorized'">
					<xsl:attribute name="onclick">
						<xsl:choose>
							<xsl:when test="$site:seed = '#login'">window.location='#'</xsl:when>
							<xsl:otherwise>xo.stores.seed.render()</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					Continuar
				</xsl:when>
				<xsl:when test="$meta:google-signin-client_id!=''">
					<xsl:attribute name="style">visibility:hidden !important;</xsl:attribute>
				</xsl:when>
				<xsl:when test="$session:status='authorizing'">
					Autorizando... <i class="fas fa-spinner fa-spin"></i>
				</xsl:when>
				<xsl:otherwise>Ingresar</xsl:otherwise>
			</xsl:choose>
		</button>
	</xsl:template>
</xsl:stylesheet>
