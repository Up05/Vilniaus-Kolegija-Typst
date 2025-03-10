// Čia yra visi dokumento nustatymai ir formatavimas
// #let rules(argumentai) = { ... }  yra funkcija
// ji yra reikalinga, nes failai turi savo "scope" ir stilius neišlipa iš jų
// į kitus failus. f() paima 'it', pakeičia jį pagal 'set' ir 'show' ir galų gale nupiešia

#let rules(it) = {
  
    // ===== Lapas ===== 
    set page(
        margin: ( top: 2cm, bottom: 2cm, right: 1cm, left: 3cm ),
        footer: context [
            #set align(center)
            #set text(10pt)
            #if counter(page).get().first() > 1 [
                #counter(page).display()
            ]
        ]
    )

    // ===== Pastraipos ===== 
    set par(
        // Deja, kol kas, pirma pastraipa atitraukiama nuo kairės
        first-line-indent: 1.27cm, 
        spacing: 1.5em,
        justify: true
    )

    // ===== Skyriai ===== 
    set heading(
        numbering: "1.",
    )
    show heading.where(level: 1): it => [
        #set align(center)
        #set text(14pt, weight: "bold")
        #set block(spacing: 20pt)
        #block(upper(it))  
    ]
    show heading.where(level: 2): it => [
        #set align(center)
        #set text(14pt, weight: "bold")
        #set block(spacing: 20pt)
        #block(it)  
    ]
    show heading.where(level: 3): it => [
        #set align(center)
        #set text(12pt, weight: "bold")
        #set block(above: 24pt, below: 18pt)
        #block(it)  
    ]

    // ===== Tekstas ===== 
    set text(
        lang: "lt",
    // http://www.identifont.com/differences?first=Times+New+Roman&second=Liberation+Serif&q=Go
        font: "Libertinus Serif", // Times New Roman alternatyva 
        size: 12pt,
    )
    
    // ===== Pavadinimai ===== 
    set figure(
        supplement: none,
        gap: 0pt,
        placement: none,
        numbering: "1."
    )
    show figure: set block(breakable: true)
    show figure.where(kind: image): it => [
        #it.body
        #v(-1em)  // 🠳 man reikia savo skaitliuko, nes turinyje: '1. ?', o kitur '1 pav.'
        #counter(figure.where(kind: image)).get().first() pav. #box[#it.caption]
    ] 
    show figure.where(kind: table): it => [
        #counter(figure.where(kind: image)).get().first() lentelė. #box[#it.caption]
        #v(-1em)
        #it.body
    ] 

    // ===== Turinys ===== 
    // show outline.entry.where(level: 1): it => [ #text(weight: "bold")[#upper(it)] ]
    show outline.entry.where(level: 2): it => { text(weight: "bold")[#it] }
    show outline.entry.where(level: 3): it => { text(weight: "bold")[#it] }

    show outline.entry.where(level: 1): it => [ 
        #if it.element.func() == heading [
            #text(weight: "bold")[#upper(it)]
        ] else [
            #text(weight: "bold")[#it]
        ]
    ]

    set table(align: left)

    it
}
