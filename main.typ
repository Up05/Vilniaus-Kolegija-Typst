#import("rules.typ"): rules
#show: rules

// Antraštinis lapas
#include("title.typ")

#outline( title: [ Turinys ] )
#outline( title: [ Paveikslų sąrašas ], target: figure.where(kind: image) )
#outline( title: [ Lentelių sąrašas ],  target: figure.where(kind: table) )

#pagebreak()

= Įvadas


Tikslas: #linebreak()
Parengti būsimos Wikimedia Foundation informacinės sistemos reikalavimų specifikaciją.

#h(-1.27cm) Uždaviniai:
+ Aprašyti problemas surastas nubrėžus Wikimedia Foundation esamos situacijos BPMN diagramą.
+ Pateikti pasiūlymus problemoms išspręsti.


#pagebreak()


= Wikimedia Enterprise procesų veiklos problemos

#h(1.27cm) Diagramoje yra pavaizduota Wikimedia Enterprise (vieno Wikimedia Foundation skyrių) 
esama informacinės sistemos veikla.
Serveris gavęs HTTPS prašymą pirmiausia filtruoja jį pagal Ugniasienę. 
Tada nuspręndžia ar reikia autentifikacijos ir, jei nereikia, iš karto surenka ir išsiunčia viešai pasiekiamą
informaciją, o jei reikia ir gauti prisijungimo duomenys yra teisingi, toliau vykdo prašymą.

#figure( image("bpmn-as-is.png"), caption: [ Esamų Wikimedia Enterprise veiklos procesų diagrama ] )

#h(1.27cm) Procesas šiuo metu veikia gerai, tačiau nėra trijų labai svarbių dalių:  naudotojų asmeninių nustatymų, straipsnių istorijų ir vietos diskutuoti apie straipsnius ir jų pakeitimus.
Asmeniniai nustatymai gali leisti naudotojams pakeisti puslapio dizainą, šrifto dydį, ir daugeliu kitų būdų derinti programinę įrangą pagal savo porinkius. Straipsnių istorijos padeda lengvai ir greit atgauti blogais kėslais ištrintus arba sugadintus straipsnius. Be to, aiškiai parodo mažus, kitais atvejais, sunkiai aptinkamus pakeitimus. O diskusijos yra pagrinde skirtos ginčitinai informacijai aprašyti. Tai gali būti ne tik nuomonės, kurios, galbūt, ir neturėtų būti Wikipedijos straipsniose, bet ir neįrodytus autobiografinius duomenys, naujai atsiradusią informaciją ir t.t.  

#pagebreak()
= Problemų sprendimų pasiūlymai

#h(1.27cm) Schemoje yra matomi du nauji procesai: Nustatymų redagavimas ir Straipsnių istorijos sekimas. Trečiasis naujas procesas -- diskusijos priklauso Autentifikuotų prašymų vykdymo subprocesams. 

#figure( image("bpmn-to-be.png"), caption: [ Būsimų Wikimedia Enterprise veiklos procesų diagrama ] )

Nustatymų redagavimas eina dar prieš autentifikavimo sistemą ir kitas turinio keitimo ar peržiūros sistemas, nes
tai yra naudotojo seanso dalis, taip ir neprisijungę naudotojai gali keisti savo nustatymus, tik tiek, kad
prisijungusiems naudotojams nustatymai galės būti sinchronizuojami ir automatiškai pritaikomi nepriklausant nuo 
kompiuterio. 

Straipsnių istorija palaiko straipsnių duomenų bazę, įrašo į ją naujai pakeistus straipsnius ir, jei reikia gauna straipsnius Autentifikuotų prašymų vykdymui. 

#pagebreak()

= IS naudotojai

+ Neprisijungęs naudotojas - šio tipo naudotojas gali perskaityti straipsnius, ir matyti jų pakeitimų istoriją, pakeisti kelis nustatymus kaip kalbą ir stilių, gauti visų straipsnių ir žodžių sąrašus ir galimybę prisijungti.
+ Autorizuotas naudotojas - gali daryti viską ką gali neprisijungęs naudotojas, pakeisti straipsnių turinį ir dalyvauti diskusijose.
+ Wikimedia API naudotojas - su Wikimedijos REST API gali padaryti viską tą patį kaip autorizuotas naudotojas (jei turi autorizacijos žetoną), išskyrus pakeisti asmeninius nustatymus ir prisijungti. Be to, gauti tik dalį turinio ir gauti signalą kai nutinka pasirinktas įvykis (pavyzdžiui straipsnio pakeistimas)

= IS funkcinių reikalavimų sąrašas

+ Neprisijungę naudotojai:
    + Gali perskaityti viešai pateiktą informaciją
    + Mato straipsnių pakeitimo istoriją
    + Pakeisti asmeninius nustatymus
    + Gali prisijungti

+ Prisijungę naudotojai:
    + Gali perskaityti viešai pateiktą informaciją
    + Mato straipsnių pakeitimo istoriją
    + Pakeisti asmeninius nustatymus
    + Turėti galimybę atsijungti ir pakeisti prisijungimo duomenis
    + Pakeisti straipsnių turinį
    + Gauti privačią informaciją
    + Dalyvauti diskusijose

+ Wikimedia API naudotojai:
    + Turi galėti perskaityti viešai pateiktą informaciją
    + Prenumeruoti įvykius
    + Gauti dalį turinio
    + Autentifikuotis
    + Matyti straipsnių pakeitimo istoriją
    + Pakeisti straipsnių turinį


#figure( image("uml-to-be.png"), caption: [ Būsimų Wikimedia Enterprise panaudos atvejų diagrama ] )

#pagebreak()

= Funkcinių reikalavimų ir panaudos atvejų matrica

#show table.cell.where(y: 1): it => {
    return rotate(-80deg, reflow: true)[#pad(top: 0.5em, x: 0.5em, it.body)]
}
#table(
    columns: (auto,) + 10 * (3.5em,),
    rows: ( 1.5em, 10em, 1.5em, ),
    align: center + horizon,

    table.cell(rowspan: 2, [ ]), table.cell(align: center, colspan: 10, [ Panaudos atvejai ]),
    [ Gauti viešą informaciją ], [ Prenumeruoti įvykius ], [ Gauti dalį turinio ], [ Autentifikuotis ], 
    [ Dalyvauti diskusijose ], [ Redaguoti viešą informaciją ], [ Peržiūrėti privačią informaciją ], 
    [ Pakeisti asmeninius nustatymus ], [ Pakeisti prisijungimą ], [ Prisijungti ], 
    [ R 1.1. ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ],
    [ R 1.2. ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], 
    [ R 1.3. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], 
    [ R 1.4. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], 
    [ R 2.1. ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 2.2. ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], 
    [ R 2.3. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], 
    [ R 2.4. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], 
    [ R 2.5. ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 2.6. ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], 
    [ R 2.7. ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], 
    [ R 3.1. ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.2. ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.3. ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.4. ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.5. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.6. ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.7. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], 


)


#pagebreak()

// #h(length) funkcija - (čia pirmos) pastraipos atitraukimas nuo kairės, deja, kol kas, labai sudėtinga padaryti tai automatiškai.
#h(1.27cm) #lorem(50)

#figure(
    image("example.png"),
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
