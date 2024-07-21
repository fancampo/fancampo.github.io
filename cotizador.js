xml = xover.xml.createNode;
xo.listener.on('fetch::#cotizador', function() {
    debugger
})

xo.listener.on(`searchParams?param=tipo`, function({ params }) {
    xo.stores.seed.selectFirst('/*/cotizaciones/@tipo_cotizacion').set(params.tipo);
})

xo.listener.on(`agregarDetalle::@especie`, function({ selection, element, dimension }) {
    let detalle = element.selectFirst(`detalle[@especie='${selection.getAttribute("id")}']`);
    if (!detalle) {
        detalle = element.selectFirst(`detalle[@xsi:type='mock']`).duplicate();
        detalle.setAttribute("especie", selection.getAttribute("id"));
    }
    detalle.removeAttributeNS(xover.spaces["xsi"], "type");
})

xo.listener.on(`eliminarDetalle::@especie`, function({ selection, element, dimension }) {
    let detalle = element.selectFirst(`detalle[@especie='${selection.getAttribute("id")}']`);
    if (detalle) {
        detalle = element.selectFirst(`detalle[@xsi:type='deleted']`).duplicate();
    }
})

xo.listener.on('beforeTransform?stylesheet.href=cotizador.xslt', function() {
    let tipocotizacion = this.documentElement.getAttributeNode("tipocotizacion")
    if (xo.site.searchParams.has("tipo") && !tipocotizacion.value) tipocotizacion.value = xo.site.searchParams.get("tipo");
})