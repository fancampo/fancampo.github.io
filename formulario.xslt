<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl"
>
	<xsl:key name="data" match="data" use="'*'"/>
	<xsl:key name="data" match="data" use="substring-before(concat(comment,'.'),'.')"/>

	<xsl:key name="input" match="data[@name='TipoSeguro']" use="'select'"/>

	<xsl:param name="title"></xsl:param>
	<xsl:template match="/*">
		<div>
			<form action="contact.asp" method="post" role="form" class="contact-form">
				<div class="row">
					<xsl:apply-templates mode="field" select="key('data','*')">
						<xsl:sort select="comment" data-type="number"/>
					</xsl:apply-templates>
				</div>
				<div class="text-center">
					<button type="submit">Enviar</button>
				</div>
			</form>
		</div>
	</xsl:template>

	<xsl:template mode="row" match="data">
		<div class="row">
			<xsl:apply-templates mode="field" select="."/>
		</div>
	</xsl:template>

	<xsl:template mode="input" match="data">
		<input type="text" name="{@name}" class="form-control" xo-slot="value" required=""/>
	</xsl:template>

	<xsl:template mode="input" match="key('input','select')">
		<select name="{@name}" class="form-select" xo-slot="value" required="" xo-source="#menu" xo-stylesheet="seguros-combobox.xslt">
			<option selected=""> </option>
		</select>
	</xsl:template>

	<xsl:template mode="field" match="data">
		<xsl:variable name="cols" select="count(key('data', substring-before(concat(comment,'.'),'.')))"/>
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="$cols &gt; 1">col-md-<xsl:value-of select="12 div $cols"/>
			</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<div class="form-group {$class}">
			<label for="{@name}">
				<xsl:value-of select="value"/>
			</label>
			<xsl:apply-templates mode="input" select="."/>
		</div>
	</xsl:template>
</xsl:stylesheet>