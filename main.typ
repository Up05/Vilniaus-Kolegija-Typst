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
    + Gali gauti straipsnių sąrašus
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

    

#h(1.27cm) UML Diagramoje yra 3 konkretūs aktoriai ir vienas abstraktus -- Naudotojas, jis gali vien tik gauti viešą informaciją. Būtų galima sukurti ir daugiau abstrakčių naudotojų, kurie apimtų dviejų ir vieno aktorių veiksmus, tačiau tai tik padarytų situaciją sudėtingesne ir diagramą sunkesne pakeisti. Be to, straipsniu pakeitimų gavimas reikalauja ir tų straipsnių turinio (bent dalies). 

Kiti trys naudotojai gali atlikti įvairius veiksmus. Kadangi Prisijungęs naudotojas ir Wikimedia API naudotojas yra atskiros klasės, daugelis veiksmų nereikalauja daug prieš-sąlygų. Tačiau veiksmai susiję su straipsnio turinio gavimu turi patikrinti ar straipsnis iš tikro egzistuoja.

#figure( image("uml-to-be.png"), caption: [ Būsimų Wikimedia Enterprise panaudos atvejų diagrama ] )

#pagebreak()

= Funkcinių reikalavimų ir panaudos atvejų matrica

#let the_matrix() = [
#show table.cell.where(y: 1): it => {
    return rotate(90deg, reflow: true)[#pad(top: -2.5em, x: 0.5em, align(left + top)[#it.body])]
}
#table(
    columns: (auto,) + 12 * (3em,),
    rows: ( 1.5em, 10em, 1.5em, ),
    align: center + horizon,

    table.cell(rowspan: 2, [ ]), table.cell(align: center, colspan: 12, [ Panaudos atvejai ]),
    [ Gauti straipsnio turinį ], [ Gauti pakeitimus ], [ Gauti straipsnių sąrašą ], [ Prenumeruoti įvykius ], [ Gauti dalį turinio ], [ Autentifikuotis ], 
    [ Dalyvauti diskusijose ], [ Redaguoti viešą informaciją ], [ Peržiūrėti privačią informaciją ], 
    [ Pakeisti asmeninius nustatymus ], [ Pakeisti prisijungimą ], [ Prisijungti ], 
    [ R 1.1. ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ],
    [ R 1.2. ], [   ], [ X ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], 
    [ R 1.3. ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 1.4. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], 
    [ R 1.5. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], 
    [ R 2.1. ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 2.2. ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], 
    [ R 2.3. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], 
    [ R 2.4. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], 
    [ R 2.5. ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 2.6. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], 
    [ R 2.7. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], 
    [ R 3.1. ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.2. ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.3. ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.4. ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.5. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.6. ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], [   ], [   ], [   ], 
    [ R 3.7. ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [   ], [ X ], [   ], [   ], 
)
]
#the_matrix()
Iš panaudos atvejų matricos matosi, kad visi reikalavimai yra padengti.

#pagebreak()

= Scenarijai

#let scenarijus(name, desc, actor, main, precond, branches, extra) = {
    show table.cell.where(x: 0): strong

    let increment(a) = { return a + 1 }

    state("sID").update(increment)
    table(
        columns: (auto, 1fr), stroke: (luma(50), 1pt),
        ..(
            ([Pavadinimas],             [#name]),
            ([ID],                      [UC\_#context(state("sID").get())]),
            ([Trumpas aprašymas],       [#desc]),
            ([Naudotojas],              [#actor]),
            ([Pagrindinis scenarijus],  [#main]),
            ([Prieš-sąlyga],            [#precond]),
            ([Alternatyvūs scenarijai], [#branches]),
            ([Papildoma informacija],   [#extra])
        ).filter(row => row.at(1) != []).flatten()
    )

}

#scenarijus(
    "Gauti straipsnių sąrašus", 
    "Naudotojas gali gauti straipsnių sąrašą pagal jo pasirinktus filtrus, kuris arčiausiai atitinka jo paiešką, arba pagal Levenšteino atstumą, arba tiklsiai dalį.", 
    "Naudotojas",
    [ + Naudotojas ateiną į kuruotą arba pagrindinį paieškos puslapį
      + Naudotojas pasirenka straipsnį 
      + Naudotojas pasirenka vieną iš gautų straipsnių
      + Naudotojas gauna straipsnio turinį
    ], [],
    [ 2.a. Naudotojas pasirenka norimus filtrus \
      2.b. Naudotojas įrašo tekstą į paieškos dėžutę \
    ], []
)

#scenarijus(
    "Gauti straipsnių pakeitimus", 
    "Naudotojas gali gauti dalį straipsnių turinio kuri buvo pakeista.", 
    "Naudotojas",
    [ + Naudotojas ateina į straipsnio istorijos tinklalapį
      + Naudotojas pasirenka laiko arba versijų rėžius
      + Naudotojas gauna pakeistas straipsnio dalis
    ], [ Straipsnis turi egzistuoti ], [], []
)

#scenarijus(
    "Gauti straipsnio turinį", 
    "Naudotojas gali gauti straipsnio turinį",
    "Naudotojas",
    [ + Naudotojas ateiną į straipsnio tinklalapį
      + Naudotojas gauna straipsnio turinį
    ], [ Straipsnis turi egzistuoti], [], []
)

#scenarijus(
    "Prenumeruoti įvykius", 
    "Wikimedia API naudotojas gali gauti pranešimus/HTTPS prašymus kai nutinka tam tikras įvykis",
    "Wikimedia API naudotojas",
    [ + Klientas paprašo, kad jam būtų atsiųstas prašymas kai nutinka koks nors įvykis
      + Nutinka aktualus įvykis
      + Klientas gauna pranešimą apie įvykį ir jo detales
    ], [ Straipsnis turi egzistuoti], [ 1.a. Įvykio nėra \ 1.b. Viskas yra atšaukiama ], 
    [ Įvykį sudaro jo tipas ir sumos tipas su jo detalėmis ]
)

#scenarijus(
    "Gauti dalį turinio", 
    "Wikimedia API naudotojas paprašo ir gauna tik dalį straipsnio turinio",
    "Wikimedia API naudotojas",
    [ + Klientas atsiunčia prašymą su straipsnio ID ir norimo (arba nenorimo) turinio filtru
      + Klientui nusiunčiamas atrinktas turinys
    ], [ Straipsnis turi egzistuoti ], [], 
    [ Filtrą sudaro rinkikliai kaip antraščių sąrašas ir Regex. Antraštės ir poantraštės veikia kaip katalogai operacinėje sistemoje. ]
)

#scenarijus(
    "Redaguoti straipsnius", 
    "Klientas gali redaguoti straipsnį",
    "Wikimedia API naudotojas, Prisijungęs naudotojas",
    [ + Klientas atsiunčia prašymą su straipsnio ID ir norimais pakeitimais
      + Patvirtinama, kad naudotas gali redaguoti šį straipsnį
      + Straipsnio pakeitimai išsaugomi į istoriją
      + Išsiunčiami įvykio pranešimai ir laiškai straipsnio autoriams
      + Dabartinė straipsnio versija pakeičiama į naują.
    ], [ Straipsnis turi egzistuoti], [ 2.a. Naudotojui neužtenka teisių redaguoti \ 2.b. Pranešama, kad redaguoti negali ], 
    []
)

#scenarijus(
    "Dalyvauti diskusijose", 
    "Klientas gali dalyvauti diskusijose",
    "Prisijungęs naudotojas",
    [ + Naudotojas ateina į straipsnį
      + Naudotojas ateina į straipsnio diskusiją
      + Naudotojas parašo savo žinutę ir ją išsiunčia
      + Kiti diskusijoje dalyvaujantys asmenys gauna tekstą ir pranešimą laiške
    ], [], [], []
)

#scenarijus(
    "Peržiūrėti privačią informaciją", 
    "Klientas gali pamatyti savo informaciją, kaip prisijungimo vardus ir elektroninį paštą ir daugiau",
    "Prisijungęs naudotojas",
    [ + Naudotojas ateina į savo profilį
      + Naudotojas gauna informaciją ten
    ], [], [], []
)

#scenarijus(
    "Pakeisti asmeninius nustatymus", 
    "Klientas gali pakeisti savo nustatymus",
    "Prisijungęs naudotojas, Neprisijungęs naudotojas",
    [ + Klientas nueina į savo nustatymus
      + Klientas pakeičia vieną iš nustatymų
      + Puslapis atsinaujina pagal naujas taisykles
    ], [], [], []
)

#scenarijus(
    "Pakeisti prisijungimą", 
    "Klientas gali pakeisti savo nustatymus",
    "Prisijungęs naudotojas",
    [ + Klientas nueina į savo profilį
      + Klientas paspaudžia "Pakeisti profilį"
      + Klientas įveda prisijungimo duomenys
      + Dabartinis kliento profilis ir seanso sausainis yra pakeičiami
    ], [], [ 3.a. Prisijungimo duomenys yra neteisingi tris kartus 3.b. Klientas tampa neprisijungusiu naudotoju  ], []
)

#scenarijus(
    "Prisijungti", 
    "Neprisijungęs naudotojas gali prisijungti ir tapti Prisijungusiu naudotoju",
    "Neprisijungęs naudotojas",
    [ + Klientas nueina į prisijungimo arba registracijos puslapį
      + Klientas įveda prisijungimo duomenys
      + Naudotojas tampa prisijungusiu naudotoju ir gauna seanso sausainį 
    ], [], [ 3.a. Prisijungimo duomenys yra neteisingi tris kartus 3.b. Klientas lieka neprisijungusiu naudotoju ], []
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
