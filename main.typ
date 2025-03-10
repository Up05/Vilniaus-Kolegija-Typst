#import("rules.typ"): rules
#show: rules

// Antraštinis lapas
#include("title.typ")

#outline( title: [ Turinys ] )
#outline( title: [ Paveikslų sąrašas ], target: figure.where(kind: image) )
#outline( title: [ Lentelių sąrašas ],  target: figure.where(kind: table) )


= Skyrius
== Poskyris

// #h(length) funkcija - (čia pirmos) pastraipos atitraukimas nuo kairės, deja, kol kas, labai sudėtinga padaryti tai automatiškai.
#h(1.27cm) #lorem(50)

#figure(
    image("nuotrauka.png"),
    caption: [ Bet kokia nuotrauka ]
)

#figure(
    table(
        columns: (1fr, 1fr, 1fr), // fractional unit 
        table.header( [Moneta], [S], [H] ),
        [s], [sS], [sH],
        [h], [hS], [hH],
        [h], [hS], [hH],
        [h], [hS], [hH],
        [h], [hS], [hH],
        [h], [hS], [hH],
        [h], [hS], [hH],
        [h], [hS], [hH],
        [h], [hS], [hH],
        [h], [hS], [hH],
        [h], [hS], [hH],
        [h], [hS], [hH],
    ),
    caption: [ Galimi monetos metimo rezultatai (S -- skaičius, H -- herbas) ]
)


// ===== ŠALTINIAI =====
#pagebreak()

// Kadangi Vilniaus kolegija nenaudoja APA stiliaus ir aš tingiu parašyti savo CSL
// šaltinių sąrašą ir citavimą reiks parašyti jums patiems.
// Patarčiau tiesiog nukopijuoti šios bibliografijos rezultatą ir perdaryti su Typst.
//                               🠳
// #bibliography(
//     "literature.yml", 
//     title: [ Literatūros šąrašas ], 
//     style: "apa", 
//     full: true // Rodo visą sąrašą, ar šaltinis cituotas ar ne ("false" rodytų mažiau)
// )

#heading(numbering: none, "Literatūros šąrašas")
+ Pirmas šaltinis
+ Antras šaltinis
