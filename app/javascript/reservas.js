const width = 600
const height = 400
const color_free = '#126AD2'
const color_reservado = '#9A0000'
const color_selected = '#7ec462'
document.addEventListener('DOMContentLoaded', function ()
{
const svg = d3.select("#svg_sala")
    .append("svg")
    .attr("class", "plot")
    .attr("width", width)
    .attr("height", height)

const asientos_text = d3.select("#asientos_text")
const asientos_field = d3.select("#reservation_seats")

/*Legend */
svg.append("rect")
    .attr("x",150)
    .attr("y", 370)
    .attr("width", 10)
    .attr("height", 10)
    .attr("fill", color_free)
svg.append("text")
    .attr("x", 163)
    .attr("y", 379)
    .attr("font-size", 10)
    .attr("fill", "black")
    .attr("font-weight", "bold")
    .attr("pointer-events", "none")
    .text("Asiento Libre")
svg.append("rect")
    .attr("x",230)
    .attr("y", 370)
    .attr("width", 10)
    .attr("height", 10)
    .attr("fill", color_reservado)
svg.append("text")
    .attr("x", 243)
    .attr("y", 379)
    .attr("font-size", 10)
    .attr("fill", "black")
    .attr("font-weight", "bold")
    .attr("pointer-events", "none")
    .text("Asiento No Disponible")
svg.append("rect")
    .attr("x",360)
    .attr("y", 370)
    .attr("width", 10)
    .attr("height", 10)
    .attr("fill", color_selected)
svg.append("text")
    .attr("x", 374)
    .attr("y", 379)
    .attr("font-size", 10)
    .attr("fill", "black")
    .attr("font-weight", "bold")
    .attr("pointer-events", "none")
    .text("Asiento Seleccionado")

/*Pantalla */
svg.append("rect")
    .attr("x",50)
    .attr("y", 330)
    .attr("width", 500)
    .attr("height", 30)
    .attr("fill", "#F6E3BA")
svg.append("text")
    .attr("x", width/2)
    .attr("y", 350)
    .attr("font-size", 15)
    .attr("fill", "black")
    .attr("font-weight", "bold")
    .attr("text-anchor", "middle")
    .attr("pointer-events", "none")
    .text("PANTALLA")

let letter_scale = {0: 'A', 1: 'B', 2: 'C', 3: 'D'}
let color_scale = {true: color_reservado, false: color_free}
let selected = []

function construir_identificador(i){
    return `${letter_scale[Math.floor(i/12)]}-${(i%12+1)}`
}
const clicked = (d, i) => {
    if (d){
        return
    }
    const id = construir_identificador(i)
    const check = selected.find(element => element === id)
    if (check == null) {
        selected.push(id)
        svg.select(`[id="asiento_${i}"]`)
            .attr("class", "asiento selected")
            .attr("fill", color_selected)
    } else {
        selected.splice(selected.findIndex(element => element === id), 1)
        svg.select(`[id="asiento_${i}"]`)
            .attr("class", "asiento")
            .attr("fill", color_free)

    }
    asientos_text.text(selected.join(', '))
    asientos_field.attr('value', selected.join(', '))
}
let asientos_selection = svg.selectAll(".asiento")
.data(asientos)
.enter()
asientos_selection.append("path")
    .attr("id", (_,i) => `asiento_${i}`)
    .attr('d','M1539 4250 c-232 -36 -416 -198 -486 -430 -15 -49 -17 -147 -20 -916\n' +
        'l-4 -860 -33 -12 c-18 -7 -35 -12 -39 -12 -4 0 -7 54 -7 120 l0 120 -150 0\n' +
        'c-136 0 -150 2 -150 18 0 9 9 84 20 166 26 190 26 184 -7 189 -20 3 -15 4 15\n' +
        '6 l43 1 -7 38 c-3 20 -10 41 -14 46 -5 4 -47 11 -94 13 l-86 6 0 113 c0 90 4\n' +
        '122 20 159 27 63 27 97 -1 93 -15 -2 -28 -20 -45 -58 -20 -48 -23 -71 -24\n' +
        '-181 l0 -126 -79 -5 c-44 -3 -87 -10 -95 -18 -9 -7 -16 -28 -16 -46 0 -33 1\n' +
        '-34 43 -36 38 -1 39 -2 9 -5 -32 -4 -33 -6 -28 -41 3 -20 13 -91 21 -157 8\n' +
        '-66 17 -132 20 -147 l4 -28 -99 0 c-96 0 -101 -1 -132 -29 l-33 -29 -3 -116\n' +
        'c-5 -150 2 -197 35 -230 l26 -26 238 0 239 0 0 -430 0 -430 65 0 65 0 0 -87\n' +
        'c1 -135 45 -213 155 -271 l50 -27 303 -3 302 -3 0 -160 0 -159 710 0 710 0 0\n' +
        '160 0 160 285 0 c316 0 342 4 424 69 53 42 101 138 101 203 l0 48 60 0 60 0 0\n' +
        '465 0 465 244 0 243 0 26 26 c33 33 40 80 35 230 l-3 116 -33 29 -32 29 -400\n' +
        '0 -400 0 0 -205 0 -206 -42 -19 -43 -19 -5 992 c-6 1081 -2 1015 -66 1138 -71\n' +
        '136 -181 229 -334 283 l-85 31 -710 2 c-390 0 -735 -3 -766 -7z m1951 -2785\n' +
        'l0 -35 -1225 0 -1225 0 0 35 0 35 1225 0 1225 0 0 -35z')
    .attr('transform',(_,i)=> `translate(${90+10*(i%12)+30*(i%12)},${80+30*Math.floor(i/12)+30*(Math.floor(i/12))}) rotate(180) scale(0.007,0.007)`)
    .attr("stroke", "black")
    .attr("fill", (d)=> color_scale[d])
    .attr("class", "asiento")
    .on("click", clicked)
asientos_selection.append("text")
    .attr("x",(_,i)=> 75+10*(i%12)+30*(i%12))
    .attr("y",(_,i)=> 95+30*Math.floor(i/12)+30*(Math.floor(i/12)))
    .attr("font-size", 15)
    .attr("fill", "black")
    .attr("font-weight", "bold")
    .attr("text-anchor", "middle")
    .attr("pointer-events", "none")
    .text((_, i)=>construir_identificador(i))
}, { once: true });