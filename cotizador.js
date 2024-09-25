xml = xover.xml.createNode;
xo.listener.on('fetch::#cotizador', function() {
    debugger
})

xo.listener.on(`searchParams?param=tipo`, function({ params }) {
    xo.stores.seed.selectFirst('/*/cotizaciones/@tipo_cotizacion').set(params.tipo);
})

xo.listener.on(`change::*[@xsi:type="mock"]/@*`, function ({ element }) {
    element.removeAttributeNS(xover.spaces["xsi"], "type");
})

xo.listener.on(`agregarDetalle::cotizacion/@especie`, function({ selection, element }) {
    let detalle = element.selectFirst(`detalle[@especie='${selection.getAttribute("id")}']`);
    if (!detalle) {
        detalle = element.selectFirst(`detalle[@xsi:type='mock']`).duplicate();
        detalle.setAttribute("especie", selection.getAttribute("id"));
    }
})

xo.listener.on(`eliminarDetalle::@especie`, function({ selection, element }) {
    let detalle = element.select(`detalle[@especie='${selection.getAttribute("id")}']`);
    detalle.remove()
})

xo.listener.on('beforeTransform?stylesheet.href=cotizador.xslt', function() {
    let tipocotizacion = this.selectFirst("//cotizaciones/@tipo_cotizacion")
    if (xo.site.searchParams.has("tipo") && !tipocotizacion.value) tipocotizacion.value = xo.site.searchParams.get("tipo");
})

async function exportHTML({ mappings = {} }, file_name) {
    debugger
    /*
    if (!source_node) return
    for (let el of source_node.querySelectorAll('pre,tr,td,th')) {
        let computedStyle = window.getComputedStyle(el)
        el.style.background = computedStyle.getPropertyValue("background");
        el.style.backgroundColor = computedStyle.getPropertyValue("background-color");
        el.style.fontFamily = computedStyle.getPropertyValue("font-family");
        el.style.fontSize = computedStyle.getPropertyValue("font-size");
        el.style.color = computedStyle.getPropertyValue("color");
    }
    let cloned_node = source_node.cloneNode(true);
    [...cloned_node.querySelectorAll('.non_printable,input,select,textarea')].forEach(el => el.remove());
    for (img of cloned_node.querySelectorAll('img')) {
        //img.setAttribute("width", img.clientWidth);
        //img.setAttribute("height", img.clientHeight);
        img.src = img.src.toString()
    }*/
    let document_format = await xover.fetch(`templates/${file_name}.htm`, { headers: { "accept": "text/html; charset=iso-8859-1" } });
    document_format = document_format.body.cloneNode(true);

    let doc = new DOMParser().parseFromString(document_format.toString(), 'text/html');
    doc.documentElement.setAttributeNS(xo.spaces["xmlns"], "xmlns:xsl", xo.spaces["xsl"]);
    doc.selectNodes(`//comment()`).forEach(el => {
        let comment_node = xover.xml.createNode(`<xsl:comment><xsl:text/><![CDATA[${el.textContent}]]><xsl:text/></xsl:comment>`);
        el.replace(comment_node)
    });
    for (let el of doc.querySelectorAll('img,link')) {
        //img.setAttribute("width", img.clientWidth);
        //img.setAttribute("height", img.clientHeight);
        if (el instanceof HTMLImageElement) {
            el.src = new URL(`templates/${el.getAttribute("src")}`, window.location).toString()
        } else if (el instanceof HTMLLinkElement) {
            el.href = new URL(`templates/${el.getAttribute("href")}`, window.location).toString()
            let current_target = el.getAttribute("target");
            if (current_target) {
                el.target = new URL(`templates/${current_target}`, window.location).toString()
            }
        }
        //new URL(img.src, ).href
    }

    //let templates = {}
    //let max_rows = 0;
    let placeholders = doc.select('//text()[contains(.,"{{")]').map(text => [text.parentNode.closest('tr,div > p'), text]);
    placeholders.forEach(([, text]) => text.value = text.value.replace(/{{([^\}]+)}}/ig, (match, key) => {
        if (key.indexOf('<') === 0) { // when <span class="SpellE">monto_total</span>
            key = xo.xml.createNode(key).textContent;
        }
        return `{{${key}}}`
    }));
    let containers = [... new Set(placeholders.map(([el]) => el.closest('table,div')))];
    for (let container of containers) {
        let mappings_copy = Object.assign({}, mappings);
        let items = placeholders.filter(([el]) => el.closest('table,div') === container);
        let list_position = 0;
        let rows = [... new Set(items.map(([el]) => el.closest('tr,div > p')))];
        while (rows.length) {
            for (let row of rows) {
                let r = rows.indexOf(row);

                //let [row, text] = item;
                let matches = row.select('.//text()[contains(.,"{{")]').map(text => text.value.replace(/{{([^\}]+)}}/ig, (match, key) => {
                    return mappings_copy[key] instanceof Array ? mappings_copy[key].length && '<duplicate/>' || '<remove/>' : '<continue/>';
                }));
                let target_row = row;
                if (matches.find(match => match.indexOf('<duplicate/>') != -1)) {
                    target_row = row.duplicate();
                    target_row.setAttribute("position", list_position++);
                } else if (matches.find(match => match.indexOf('<remove/>') != -1)) {
                    rows.splice(r, 1);
                    row.remove();
                    target_row = null;
                } else {
                    rows.splice(r, 1);
                }
                target_row && target_row.select('.//text()[contains(.,"{{")]').forEach(text => {
                    text.parentNode.innerHTML = text.value.replace(/{{([^\}]+)}}/ig, (match, key) => {
                        let container = text.parentNode.closest('tr,div > p');
                        container.classList.add('field_' + key)
                        let match_node = mappings_copy[key];
                        let item = match_node instanceof Array && match_node.shift() || match_node || "";
                        return `${item}`
                    })
                });
                console.log(target_row)
            }
        }
        let trList = [...container.querySelectorAll(`*[position]`)];
        [... new Set(trList.map(el => [...el.classList].filter(class_name => class_name.indexOf('field') == 0).join(',')))].forEach(class_name => {
            let list = [...container.querySelectorAll(`.${class_name}[position]`)];
            let last_item = (list[list.length - 1] || {}).nextElementSibling;
            const sortedTrList = list.sort((a, b) => {
                const orderA = parseInt(a.getAttribute('position'));
                const orderB = parseInt(b.getAttribute('position'));
                return orderA - orderB;
            });

            sortedTrList.forEach(tr => {
                tr.parentNode.insertBefore(tr, last_item);
            });
        })

        //for (let tr of table.querySelectorAll('tr')) {
        //    let style = el.getAttributeNode("style");
        //    let row_number = style && style.getPropertyValue("mso-yfti-irow") || undefined;
        //    if (row_number !== undefined) {
        //        let placeholders = [...el.toString().matchAll(/{{([^\}]+)}}/ig)];
        //        //placeholders.forEach(([match, key]) => {
        //        //    if (key.indexOf('<') === 0) { // when <span class="SpellE">monto_total</span>
        //        //        key = xo.xml.createNode(key).textContent;
        //        //    }
        //        let there_is_precedent = el.previousElementSibling && el.previousElementSibling.parentElement === el.parentElement
        //            && [...el.previousElementSibling.toString().matchAll(/{{([^\}]+)}}/ig)].map(([match]) => match).join('') === placeholders.map(([match]) => match).join('');
        //        let there_is_following = el.nextElementSibling && el.nextElementSibling.parentElement === el.parentElement
        //            && [...el.nextElementSibling.toString().matchAll(/{{([^\}]+)}}/ig)].map(([match]) => match).join('') === placeholders.map(([match]) => match).join('');
        //        if (placeholders.length && (
        //            there_is_precedent ||
        //            there_is_following
        //        )) {
        //            //templates[placeholders.map(([match]) => match).join('')] = templates[placeholders.map(([match]) => match).join('')] || []
        //            let new_el = el.toString();
        //            new_el = new_el.replace(/{{([^\}]+)}}/ig, (match, key) => {
        //                if (key.indexOf('<') === 0) { // when <span class="SpellE">monto_total</span>
        //                    key = xo.xml.createNode(key).textContent;
        //                }
        //                if (mappings[key] instanceof Array) {
        //                    //max_rows = !there_is_precedent ? 0 : max_rows;
        //                    max_rows = max_rows < mappings[key].length ? mappings[key].length : max_rows;
        //                    mappings[key].length
        //                }
        //                return match

        //            })
        //            if (max_rows > 2) {
        //                for (let i = 0; i < max_rows - 2; ++i) {
        //                    el.duplicate();
        //                }
        //            } else {
        //                for (let i = 2 - max_rows; i > 0; --i) {
        //                    el.parentElement && el.remove();
        //                }
        //            }
        //            //templates[placeholders.map(([match]) => match).join('')].push(el)
        //        }
        //        continue
        //        //let match_node = mappings[key] && mappings[key][row_number] || 'dummy';
        //        //return match
        //        //});
        //    }
        //}
    }

    doc.select(`//xsl:comment[contains(.,"<o:")]//text()`).forEach(text => text.value = text.value.replace(/<(o:\w+)(.*)\1>/ig, (match => {
        let node = xover.xml.createNode(match);
        if (mappings.hasOwnProperty(node.localName)) {
            let match_node = mappings[node.localName];
            if (match_node instanceof Array) {
                let node = match_node[0];
                node.textContent = node && node.value || "";
            } else if (match_node instanceof Attr) {
                node.textContent = match_node.value || "";
            } if (typeof (match_node) == 'string') {
                node.textContent = match_node
            }
            return node.toString()
        } else {
            return match
        }
    })))

    let result = new XMLSerializer().serializeToString(doc);
    let keys = [];

    //    let last_tr
    //    result = result.toString().replace(/<(tr)[\S\s]+?{{[^\}]+}}[\S\s]+?<\/\1>/ig, match => {
    //        let node = xover.xml.tryParse(match);
    //        if (node instanceof Node) {
    //            last_tr = node;
    //            //if (node.documentElement.$('@style[contains(.,"mso-yfti-irow:")]')) {
    //            //    return "";
    //            //} else {
    //            return node.toString()
    //            //}
    //        } else {
    //            return match
    //        }
    //    })

    result = result.replace(/(url\("|src="|href="|target=")(?!http:\/\/)/ig, (match => {
        return match + new URL('templates/', window.location).toString()
    }));

    let stylesheet = xover.xml.createDocument(`
        <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
          <xsl:output method="html" indent="no" omit-xml-declaration="yes"/>
          ${keys.join('')}
        <xsl:template match="*|@*|text()" mode="container" priority="-1"/>
        <xsl:template match="*|@*" mode="resources-path" priority="-1"/>
        <xsl:template match="/">
            ${result.toString()}
          </xsl:template>
        </xsl:stylesheet>
        `)

    let new_document = xo.stores.active.document.transform(stylesheet);
    sourceHTML = new_document.toString();
    let source = 'data:application/vnd.ms-word;charset=utf-8,\uFEFF' + encodeURIComponent(sourceHTML);
    let fileDownload = document.createElement("a");
    document.body.appendChild(fileDownload);
    fileDownload.href = source;
    fileDownload.download = `${file_name || 'document'}_${new Date().toISOString()}.doc`;
    fileDownload.click();
    document.body.removeChild(fileDownload);
}

xo.listener.on('change::@fallas_sistema_refrigeracion', async function ({ value, element, attribute}) {
    if (value == null) {
        element.setAttribute(attribute.nodeName, "")
    }
});

cotizacion = {}

const money = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
});

const attr_format = {
    "suma_asegurada": money.format
}

const file_name_by_type = {
    "vida": "formato_proteccion_integral"
    , "maquinaria": "seguro_maquinaria"
    , "transporte_bienes": "seguro_transporte_bienes"
}

cotizacion.verFormato = async function () {
    let getValue = function (attr) {
        if (attr.nodeName in attr_format) {
            return attr_format[attr.nodeName].call(attr, attr)
        } else {
            return (attr.ownerDocument.single(`/*/*[name()="${attr.nodeName}"]/row[@id="${attr.value}"]/@desc`) || attr).value
        }
    }
    let scope = this instanceof Node ? this : xover.stores.active;
    let attributes = scope.select(`//cotizaciones/@*|//cotizacion[@type=../@tipo_cotizacion]//@*`);
    debugger
    //let cotizaciones = scope.single(`//cotizaciones`)
    //let detalles = cotizaciones.single(`cotizacion[@type=../@tipo_cotizacion]`);
    /*let mappings = Object.fromEntries([...cotizaciones.attributes, ...detalles.attributes].filter(attr => !attr.namespaceURI).map(attr => [attr.nodeName, getValue(attr)]));*/
    mappings = Object.fromEntries([...attributes].filter(attr => !attr.namespaceURI).map(attr => [attr.nodeName, getValue(attr)]));
    //console.log(mappings)
    debugger;
    /*
    let ciudad = scope.$("@meta:FK_Cotizacion_Destinos");
    let alcances = scope.$$(`px:Association/px:Entity[@Schema="Ventas" and @Name="AlcancesCotizacion"]/data:rows/xo:r`).filter(row => !(row.getAttribute("state:delete"))).map(row => row.getAttribute("meta:FK_AlcancesCotizacion_Alcance"));
    let limites = scope.$$(`px:Association/px:Entity[@Schema="Ventas" and @Name="LimitesSuministroCotizacion"]/data:rows/xo:r`).filter(row => !(row.getAttribute("state:delete"))).map(row => row.getAttribute("meta:FK_LimitesSuministroCotizacion_LimitesSuministro"));
    let requerimientos = scope.$$(`px:Association/px:Entity[@Schema="Ventas" and @Name="RequerimientosCotizacion"]/data:rows/xo:r[@state:checked]`).filter(row => !(row.getAttribute("state:delete"))).map(row => row.getAttribute("meta:FK_RequerimientosCotizacion_Requerimiento"));
    let detalles = scope.$$(`px:Association/px:Entity[@Schema="Ventas" and @Name="CotizacionDetalle"]/data:rows/xo:r`);
    let conceptos = detalles.map(row => `<p class="MsoNormal" style="margin-top:8pt;margin-right:2.4pt;margin-bottom:0pt;margin-left:2.4pt;">Servicio: ${row.getAttribute("meta:FK_CotizacionDetalle_Clasificacion").toUpperCase()}.</p><ul class="MsoListParagraphCxSpMiddle" style="margin-top:2.4pt;margin-right:2.4pt;
margin-bottom:10pt;margin-left:2.4pt;mso-add-space:auto;text-indent:-18.0pt;"><li>Equipo: ${row.get("meta:FK_CotizacionDetalle_Equipo")}</li><li>Tensión: ${row.get("meta:FK_CotizacionDetalle_NivelTension")}.</li><li>Prueba: ${row.get("meta:FK_CotizacionDetalle_CatalogoGeneral")} ${(row.get("DescripcionPrueba") || '').replace(/\n/g, '<br/>')}</li></ul>`);
    let cantidades = detalles.map(row => row.getAttribute(`Cantidad`));
    let viaticos = scope.$$(`px:Association[@Name='FK_EquipoRentaCotizacion_Cotizacion' or @Name='FK_CostosViaticoCotizacion_Cotizacion']/px:Entity/data:rows/xo:r`);
    let gastos = scope.$$(`px:Association[@Name='FK_EspecialistaCotizacion_Cotizacion']/px:Entity/data:rows/xo:r`).filter(row => !(row.getAttribute("state:delete"))).filter(row => +row.getAttribute("PrecioTotal"));

    let precios_lista = detalles.map(detalle => detalle.get(`PrecioLista`)).map(costo => +costo.value * costo.parentNode.getAttribute("Cantidad"));
    let monto_lista_total = precios_lista.reduce((suma, costo) => costo + suma, 0);
    let mappings_lista = {
        numero_cotizacion: scope.$("@Folio")
        , proyecto: scope.$("@Asunto")
        , contacto: scope.$("@meta:FK_Cotizacion_Cliente")
        , leyenda_ciudad: ciudad && ` en la ciudad de ${ciudad}`
        , no_item: Array.from(conceptos.map((row, ix) => ix + 1))
        , alcance: Array.from(alcances.length ? alcances : ["No definidos"])
        , limite: Array.from(limites.length ? limites : ["No definidos"])
        , requerimiento: Array.from(requerimientos.length ? requerimientos : ["No definidos"])
        , concepto: Array.from(conceptos)
        , cant: Array.from(cantidades)
        , monto: precios_lista.map(costo => money.format(costo))
        , monto_gastos: []
        , monto_total: money.format(monto_lista_total)
        , total_letra: numberToPesos(monto_lista_total).toUpperCase()
        , moneda: scope.$('@Moneda'), fecha: new Date().toLongDateString()
    };*/

    await exportHTML({
        mappings: mappings
    }, file_name_by_type[mappings.tipo_cotizacion]);
    //return;

    //let precios_ajustados = detalles.map(detalle => detalle.get(`CostoTotal`)).filter(attr => !gastos.find(gasto => gasto == attr.parentNode)).map(costo => +costo.value);
    //let monto_total = precios_ajustados.reduce((suma, costo) => costo + suma, 0);

    //if (!precios_ajustados.every((value, index) => value === precios_lista[index])) {
    //    let mappings = {
    //        numero_cotizacion: scope.$("@Folio")
    //        , proyecto: scope.$("@Asunto")
    //        , contacto: scope.$("@meta:FK_Cotizacion_Cliente")
    //        , leyenda_ciudad: ciudad && ` en la ciudad de ${ciudad}`
    //        , no_item: Array.from(conceptos.map((row, ix) => ix + 1))
    //        , alcance: Array.from(alcances.length ? alcances : ["No definidos"])
    //        , limite: Array.from(limites.length ? limites : ["No definidos"])
    //        , requerimiento: Array.from(requerimientos.length ? requerimientos : ["No definidos"])
    //        , concepto: Array.from(conceptos)
    //        , cant: Array.from(cantidades)
    //        , monto: precios_ajustados.map(costo => money.format(costo))
    //        , monto_gastos: []
    //        , monto_total: money.format(monto_total)
    //        , total_letra: numberToPesos(monto_total).toUpperCase()
    //        , moneda: scope.$('@Moneda'), fecha: new Date().toLongDateString()
    //    };

    //    await exportHTML({
    //        mappings: mappings
    //    }, 'cotizacion_precio_ajustado');
    //}

    //let total_viaticos = viaticos.map(row => +row.getAttribute("PrecioTotal")).reduce((suma, precio) => +precio + suma, 0);
    //if (total_viaticos) {
    //    conceptos.push(`<p class="MsoNormal" style="margin-top:8pt;margin-right:2.4pt;margin-bottom:0pt;margin-left:2.4pt;">Viáticos</p>`);
    //    cantidades.push(1);
    //    precios_ajustados.push(total_viaticos);
    //}

    //let precios_ajustados_gastos = gastos.map(gasto => gasto.getAttribute(`PrecioTotal`)).map(costo => +costo);
    //let monto_total_gastos = precios_ajustados_gastos.reduce((suma, costo) => costo + suma, monto_total);
    //formatConceptoGasto = function (nodoGasto) {
    //    return `${nodoGasto.matches(`@meta:FK_CostosViaticoCotizacion_CostosViatico`) ? 'Viáticos Tipo ' : ''}${nodoGasto}. ${[...nodoGasto.select("../@CantidadPersonas").map(personas => `${personas.value} personas`), ...nodoGasto.select("../@NumeroDias").map(dias => `${dias.value} días`)].join(', ')}`.trimEnd()
    //}
    //gastos = gastos.map(row => formatConceptoGasto(row.get("meta:FK_CostosViaticoCotizacion_CostosViatico") || row.get("meta:FK_EquipoRentaCotizacion_EquipoRenta") || row.get("meta:FK_EspecialistaCotizacion_Especialista")));
    //if (precios_ajustados_gastos.length) {
    //    let mappings = {
    //        numero_cotizacion: scope.$("@Folio")
    //        , proyecto: scope.$("@Asunto")
    //        , contacto: scope.$("@meta:FK_Cotizacion_Cliente")
    //        , leyenda_ciudad: ciudad && ` en la ciudad de ${ciudad}`
    //        , no_item: Array.from(conceptos.map((row, ix) => ix + 1))
    //        , alcance: Array.from(alcances.length ? alcances : ["No definidos"])
    //        , limite: Array.from(limites.length ? limites : ["No definidos"])
    //        , requerimiento: Array.from(requerimientos.length ? requerimientos : ["No definidos"])
    //        , concepto: Array.from(conceptos)
    //        , cant: Array.from(cantidades)
    //        , monto: precios_ajustados.map(costo => money.format(costo))
    //        , monto_total: money.format(monto_total_gastos)
    //        , total_letra: numberToPesos(monto_total_gastos).toUpperCase()
    //        , gastos: Array.from(gastos.length ? gastos : ["No definidos"])
    //        , monto_gastos: precios_ajustados_gastos.map(costo => money.format(costo))
    //        , moneda: scope.$('@Moneda'), fecha: new Date().toLongDateString()
    //    };

    //    await exportHTML({
    //        mappings: mappings
    //    }, 'cotizacion_precio_ajustado_viaticos');
    //}
}

xover.listener.on('print', function () {
    let target = this instanceof Node && !(this instanceof Document) && this || document.querySelector('main > article') || document.querySelector('main') || document.body;
    //let iframes = document.querySelector('main iframe');

    //if (iframes) {
    //    for (let f = 0; f < iframes.length; ++f) {
    //        let iframe = iframes[f];
    //        if (iframe.classList.contains("non-printable")) {
    //            continue;
    //        }
    //        iframe.contentWindow.focus();
    //        iframe.contentWindow.print();
    //        f = iframes.length;
    //    }
    //} else {
    let content = target.cloneNode(true);
    content.style.width = "100%";
    content.style.height = "100%";
    content.style.overflow = 'visible'
    //document.body.replaceWith(content);
    //window.print()
    //document.body.replaceWith(document_copy);



    function copyStyles(sourceDoc, targetDoc) {
        Array.from(sourceDoc.styleSheets).forEach(styleSheet => {
            let rules;
            try {
                rules = styleSheet.cssRules;
            } catch (e) {
                return; // Cross-origin stylesheet
            }
            if (rules) {
                const newStyleEl = targetDoc.createElement('style');
                Array.from(rules).forEach(rule => {
                    newStyleEl.appendChild(targetDoc.createTextNode(rule.cssText));
                });
                targetDoc.head.appendChild(newStyleEl);
            }
        });
    }

    let printWindow = window.open('', '', 'width=1000,height=800');

    // Write the content to the new window
    printWindow.document.write('<html><head><title>Print Content</title>');
    /*printWindow.document.write('<style>body { display: none; } #' + divId + ' { display: block; }</style>');*/
    printWindow.document.write('</head><body>');
    printWindow.document.write('</body></html>');
    printWindow.document.body.appendChild(content)
    printWindow.document.body.style.padding = '20px';
    /*printWindow.document.body.style.border = '1px solid #000';*/

    // Close the document to ensure all content is written
    printWindow.document.close();

    copyStyles(document, printWindow.document);

    // Wait for the content to load and then print
    printWindow.onload = function () {
        printWindow.focus(); // Required for some browsers
        printWindow.print();
        printWindow.close();
    };


    //    const blob = new Blob([content], { type: 'text/html' });
    //    const blobUrl = URL.createObjectURL(blob);
    //    const iframe = document.createElement('iframe');
    //    iframe.src = blobUrl;
    //    //iframe.style.position = 'absolute';
    //    //iframe.style.top = '0';
    //    //iframe.style.left = '0';
    //    iframe.style.width = '100vh';
    //    iframe.style.height = '100vw';
    //    iframe.style.border = 'none';
    //    iframe.onload = function () {
    //        [...iframe.contentDocument.querySelectorAll("[src]")].forEach(img => img.src = xover.URL(img.src).toString());
    //        const iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
    //        copyStyles(document, iframeDoc);

    //        iframeDoc.documentElement.style.overflow = 'visible';
    //        iframeDoc.body.style.overflow = 'visible';
    //        iframe.style.width = "100%"
    //        iframe.style.height = "100%"
    //        iframeDoc.querySelector(`main`).style.width = "100%"
    //        iframeDoc.querySelector(`main`).style.height = "100%"

    //        const height = iframeDoc.documentElement.scrollHeight;
    //        const width = iframeDoc.documentElement.scrollWidth;

    //        iframe.style.height = height + 'px';
    //        iframe.style.width = width + 'px';

    //        setTimeout(() => {
    //            iframe.contentWindow.focus();
    //            iframe.contentWindow.print();
    //        }, 500);
    //    }
    //    dialog = xover.dom.createDialog(iframe);
    //    [...dialog.querySelectorAll('dialog > * > menu')].remove()
    //    dialog.style.height = "100vh"
    //    dialog.style.width = "100vw"
    //    dialog.style.overflow = 'visible'
    event.preventDefault();
    //}
})