#import("rules.typ"): rules
#show: rules

// Antraštinis lapas
#include("title.typ")

#outline( title: [ Turinys ] )
#outline( title: [ Paveikslų sąrašas ], target: figure.where(kind: image) )
#outline( title: [ Lentelių sąrašas ],  target: figure.where(kind: table) )

= Įvadas

#h(1.27cm) Šio darbo tikslas yra parengti būsimos Wikimedia Foundation informacinės sistemos reikalavimų specifikaciją.

Uždaviniai:
#set enum(indent: 1.27cm)
+ Aprašyti nustatytas problemas ir pateikti probleminės situacijos BPMN diagramą
+ Pateikti pasiūlymus išspręsti problemas sudarant „To be“ BPMN diagramą
+ Pateikti sistemos naudotojų sąrašą
+ Sudaryti funkcinių reikalavimų sąrašą
+ Nubraižyti panaudos atvejų diagramą
+ Pateikti funkcinių reikalavimų ir panaudos atvejų matricą
+ Aprašyti panaudos atvejus scenarijais
+ Pavaizduoti panaudos atvejų veiklos diagramas
+ Sudaryti nefunkcinius reikalavimus
+ Pasirinkti prototipavimo įrankį
+ Sukurti Wikimedia Enterprise prototipą
#set enum(indent: 0cm)

= Wikimedia Enterprise procesų veiklos problemos

#h(1.27cm) Diagramoje yra pavaizduota Wikimedia Enterprise (vieno Wikimedia Foundation skyrių) 
esama informacinės sistemos veikla.
Serveris gavęs HTTPS prašymą pirmiausia filtruoja jį pagal Ugniasienę. 
Tada nuspręndžia ar reikia autentifikacijos ir, jei nereikia, iš karto surenka ir išsiunčia viešai pasiekiamą
informaciją, o jei reikia ir gauti prisijungimo duomenys yra teisingi, toliau vykdo prašymą.

#figure( image("bpmn-as-is.png"), caption: [ Esamų Wikimedia Enterprise veiklos procesų diagrama ] )

Procesas šiuo metu veikia gerai, tačiau nėra trijų labai svarbių dalių:  naudotojų asmeninių nustatymų, straipsnių istorijų ir vietos diskutuoti apie straipsnius ir jų pakeitimus.
Asmeniniai nustatymai gali leisti naudotojams pakeisti puslapio dizainą, šrifto dydį, ir daugeliu kitų būdų derinti programinę įrangą pagal savo porinkius. Straipsnių istorijos padeda lengvai ir greit atgauti blogais kėslais ištrintus arba sugadintus straipsnius. Be to, aiškiai parodo mažus, kitais atvejais, sunkiai aptinkamus pakeitimus. O diskusijos yra pagrinde skirtos ginčitinai informacijai aprašyti. Tai gali būti ne tik nuomonės, kurios, galbūt, ir neturėtų būti Wikipedijos straipsniose, bet ir neįrodytus autobiografinius duomenys, naujai atsiradusią informaciją ir t.t.  

= Problemų sprendimų pasiūlymai

#h(1.27cm) Schemoje yra matomi du nauji procesai: Nustatymų redagavimas ir Straipsnių istorijos sekimas. Trečiasis naujas procesas -- diskusijos priklauso Autentifikuotų prašymų vykdymo subprocesams. 

#figure( image("bpmn-to-be.png"), caption: [ Būsimų Wikimedia Enterprise veiklos procesų diagrama ] )

Nustatymų redagavimas eina dar prieš autentifikavimo sistemą ir kitas turinio keitimo ar peržiūros sistemas, nes
tai yra naudotojo seanso dalis, taip ir neprisijungę naudotojai gali keisti savo nustatymus, tik tiek, kad
prisijungusiems naudotojams nustatymai galės būti sinchronizuojami ir automatiškai pritaikomi nepriklausant nuo 
kompiuterio. 

Straipsnių istorija palaiko straipsnių duomenų bazę, įrašo į ją naujai pakeistus straipsnius ir, jei reikia gauna straipsnius Autentifikuotų prašymų vykdymui. 

= IS naudotojai

+ Neprisijungęs naudotojas - šio tipo naudotojas gali perskaityti straipsnius, ir matyti jų pakeitimų istoriją, pakeisti kelis nustatymus kaip kalbą ir stilių, gauti visų straipsnių ir žodžių sąrašus ir galimybę prisijungti.
+ Autorizuotas naudotojas - gali daryti viską ką gali neprisijungęs naudotojas, pakeisti straipsnių turinį ir dalyvauti diskusijose.
+ Wikimedia API naudotojas - su Wikimedijos REST API gali padaryti viską tą patį kaip autorizuotas naudotojas (jei turi autorizacijos žetoną), išskyrus pakeisti asmeninius nustatymus ir prisijungti. Be to, gauti tik dalį turinio ir gauti signalą kai nutinka pasirinktas įvykis (pavyzdžiui straipsnio pakeistimas)
+ _Naudotojas_ - yra abstraktus aktorius, kuris apima: neprisijungusį naudotoją, autorizuotą naudotoją ir Wikimedia API naudotoją

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

// {{{
/*
#h(1.27cm) UML Diagramoje yra 3 konkretūs aktoriai ir vienas abstraktus -- Naudotojas, jis gali vien tik gauti viešą informaciją. Būtų galima sukurti ir daugiau abstrakčių naudotojų, kurie apimtų dviejų ir vieno aktorių veiksmus, tačiau tai tik padarytų situaciją sudėtingesne ir diagramą sunkesne pakeisti. Be to, straipsniu pakeitimų gavimas reikalauja ir tų straipsnių turinio (bent dalies). 

Kiti trys naudotojai gali atlikti įvairius veiksmus. Kadangi Prisijungęs naudotojas ir Wikimedia API naudotojas yra atskiros klasės, daugelis veiksmų nereikalauja daug prieš-sąlygų. Tačiau veiksmai susiję su straipsnio turinio gavimu turi patikrinti ar straipsnis iš tikro egzistuoja.

#figure( image("uml-to-be.png"), caption: [ Būsimų Wikimedia Enterprise panaudos atvejų diagrama ] )

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
#figure(
the_matrix(),
caption: [Reikalavimų ir panaudos atvejų sukryžminimo matrica]
)
Iš panaudos atvejų matricos galima pamatyti, jog visi reikalavimai yra padengti.

= Scenarijai

#let scenarijus(name, desc, actor, main, precond, branches, extra) = {
    show table.cell.where(x: 0): strong

    let increment(a) = { return a + 1 }

    state("sID").update(increment)
    figure(
        table(
            columns: (auto, 1fr), stroke: (luma(50), 1pt),
            ..(
                ([Pavadinimas],             [#name]),
                ([ID],                      [UC\_#context(state("sID").get())]),
                ([Trumpas aprašymas],       [#desc]),
                ([Naudotojas],              [#actor]),
                ([Prieš-sąlyga],            [#precond]),
                ([Pagrindinis scenarijus],  [#main]),
                ([Alternatyvūs scenarijai], [#branches]),
                ([Papildoma informacija],   [#extra])
            ).filter(row => row.at(1) != []).flatten()
        ),
        caption: [ Panaudos atvejo „#name“ scenarijus ]
    )

    context(
        figure( 
            image(("diagrama-", str(state("sID").at(here())), ".png").join(""), width: 80%), 
            caption: [ Panaudos atvejo „#name“ veiklos diagrama ] 
        )
    )
    pagebreak(weak: true)
}

#scenarijus(
    "Gauti straipsnių sąrašus", 
    "Naudotojas gali gauti straipsnių sąrašą pagal jo pasirinktus filtrus, kuris arčiausiai atitinka jo paiešką, t.y. arba pagal Levenšteino atstumą, arba tiksliai.", 
    "Naudotojas",
    [ + Naudotojas ateiną į kuruotą arba pagrindinį paieškos puslapį
      + IS pateikia straipsnių sąrašą ir paieškos komponentus
      + Naudotojas pasirenka vieną iš gautų straipsnių
      + IS naudotojui pateikia straipsnio turinį
    ], [],
    [ 2.a.1. Naudotojas pasirenka norimus filtrus \
      2.a.2. Naudotojas įrašo tekstą į paieškos dėžutę \
      2.a.3. IS pateikia naują straipsnių sąrašą
    ], []
)


#scenarijus(
    "Gauti straipsnių pakeitimus", 
    "Naudotojas gali gauti dalį straipsnių turinio kuri buvo pakeista.", 
    "Naudotojas",
    [ + Naudotojas ateina į straipsnio istorijos tinklalapį
      + IS pateikia straipsnio istoriją ir formą įvesti norimų versijų rėžius
      + Naudotojas pasirenka laiko arba versijų rėžius
      + *UC_3 Gauti straipsnio turinį* 
      + IS naudotojui pateikia straipsnio pakeitimus
    ], [ Straipsnis turi egzistuoti ], [], []
)

#scenarijus(
    "Gauti straipsnio turinį", 
    "Naudotojas gali gauti straipsnio turinį",
    "Naudotojas",
    [ + Naudotojas ateiną į straipsnio tinklalapį
      + IS naudotojui pateikia straipsnio turinį
    ], [ Straipsnis turi egzistuoti], [], []
)

#scenarijus(
    "Prenumeruoti įvykius", 
    "Wikimedia API naudotojas gali gauti pranešimus/HTTPS prašymus kai nutinka tam tikras įvykis",
    "Wikimedia API naudotojas",
    [ + Naudotojas paprašo būti praneštam kai nutinka tam tikras įvykis
      + IS naudotojui nusiunčia pranešimą apie įvykį ir jo detales
      + IS finalizuoja įvykio rezultatus
    ], [ Straipsnis turi egzistuoti], [ 1.a.1. Įvykio nėra \ 1.a.2. Viskas yra atšaukiama ], 
    [ Įvykį sudaro jo tipas ir sumos tipas su jo detalėmis ]
)

#scenarijus(
    "Gauti dalį turinio", 
    "Wikimedia API naudotojas paprašo ir gauna tik dalį straipsnio turinio",
    "Wikimedia API naudotojas",
    [ + Naudotojas atsiunčia prašymą su straipsnio ID ir norimo (arba nenorimo) turinio filtrais
      + IS naudotojui atsiunčia atrinktas turinio dalis
    ], [ Straipsnis turi egzistuoti ], [], 
    [ Filtrą sudaro rinkikliai, kaip: antraščių sąrašas ir Regex. ]
)

#scenarijus(
    "Redaguoti straipsnius", 
    "Klientas gali redaguoti straipsnį",
    "Wikimedia API naudotojas, Prisijungęs naudotojas",
    [ +  Naudotojas atsiunčia prašymą su straipsnio ID ir norimais pakeitimais
      +  IS Patvirtina, kad naudotas gali redaguoti šį straipsnį
      +  IS išsaugo straipsnio pakeitimus į istoriją
      +  IS Išsiunčia įvykio pranešimus ir laiškus straipsnio autoriams
      +  IS pakeičia dabartinę straipsnio versija į naują.
    ], [ Straipsnis turi egzistuoti], [ 2.a. IS naudotojui praneša, kad redaguoti negalima ], 
    []
)

#scenarijus(
    "Dalyvauti diskusijose", 
    "Klientas gali dalyvauti diskusijose",
    "Prisijungęs naudotojas",
    [ + Naudotojas ateina į straipsnio diskusijos puslapį
      + IS naudotojui pateikia ten esančias žinutes
      + Naudotojas parašo savo žinutę ir ją išsiunčia
      + IS perduoda naudotojo žinutę kitiems naudotojams
    ], [], [], []
)

#scenarijus(
    "Peržiūrėti privačią informaciją", 
    "Klientas gali pamatyti savo informaciją, kaip prisijungimo vardus ir elektroninį paštą ir daugiau",
    "Prisijungęs naudotojas",
    [ + Naudotojas nueina į savo profilį
      + IS naudotoju pateikia jo privačią informaciją
    ], [], [], []
)

#scenarijus(
    "Pakeisti asmeninius nustatymus", 
    "Klientas gali pakeisti savo nustatymus",
    "Prisijungęs naudotojas, Neprisijungęs naudotojas",
    [ + Naudotojas nueina į savo nustatymus
      + IS naudotoju pateikia jo parinktis 
      + Naudotojas pakeičia vieną iš nustatymų
      + IS naudotojui pateikia atnaujintą puslapis ir išsaugo atnaujintus nustatymus 
    ], [], [], []
)

#scenarijus(
    "Pakeisti prisijungimą", 
    "Klientas gali pakeisti savo nustatymus",
    "Prisijungęs naudotojas",
    [ + Naudotojas nueina į „Pakeisti profilį“ puslapį
      + IS pateikia prisijungimo ekraną
      + Naudotojas įveda prisijungimo duomenys
      + IS pakeičia dabartinį kliento profilį ir seanso sausainį
    ], [], [ 
      3.a.1. Prisijungimo duomenys yra neteisingi tris kartus \ 
      3.a.2. Klientas tampa neprisijungusiu naudotoju  
    ], []
)

#scenarijus(
    "Prisijungti", 
    "Neprisijungęs naudotojas gali prisijungti ir tapti Prisijungusiu naudotoju",
    "Neprisijungęs naudotojas",
    [ + Naudotojas nueina į prisijungimo puslapį
      + IS pateikia prisijungimo ekraną
      + Naudotojas tampa prisijungusiu naudotoju ir gauna seanso sausainį 
    ], [], [ 
      3.a.1. Prisijungimo duomenys yra neteisingi tris kartus #linebreak()
      3.a.2. Klientas lieka neprisijungusiu naudotoju 
    ], []
)


*/
// }}}

= Nefunkciniai reikalavimai

+ IS turi veikti 99,999% laiko, išskyrus pirmuosius dviejus metus
+ IS turi išsiųsti straipsnius per mažiau nei 200 milisekundžių
+ HTML elementų identifikatoriai ir klasės negali būti pakeistos be labai geros priežasties
+ IS turi naudoti standartinį REST API stilių
+ Duomenų bazėje saugomi autentifikacijos duomenys turi būti šifruojami

= Prototipavimo įrankių palyginimas

#let Yes = [$checkmark$]
#let No  = [$crossmark$]
#figure(
table(
    columns: 5,
    [],                          [Axure],  [HTML],  [QML],  [Figma],
    [Nemokama],                  No,       Yes,     Yes,    Yes,
    [Yra Pacman DB],             No,       Yes,     Yes,    No,
    [Pagrįsta tekstu],           No,       Yes,     Yes,    No,
    [Tinka puslapiams],          Yes,      Yes,     Yes,    Yes,
    [Gera Neovim integracija],   No,       Yes,     No,     No,
),
caption: [Prototipavimo įrankių palyginimas]
)

#h(1.27cm) Sudaręs lentelę ir pabandęs įrankius aš pasirinkau HTML. Vienintelis atitinkta visus kriterijus. Aš naudoju HTML, CSS ir JS jau penkeris metus. Neovim ir interneto naršyklė (kurią, deja, turiu įjungęs bet kokiu atveju) naudoja mažiausiai sistemos resursų. HTML ir JavaScript leidžia padaryti daug interaktyvesnius ir tikslesnius, originalesnius grafinės sąsajos komponentus. Ir dar, aš dabar darau interneto svetainę, HTML yra paprasčiausias problemos sprendimas, viskas kitas gali tik pridėti sudėtingumo. Dėl kitų įrankių, Axure neveikia Linux sistemoje, kadangi aš, šiuo metu, turiu tik prastą, labai lėtą Windows virtualią mašiną. QML mažiausiai tinka daryti puslapiams iš mano paminėtų programų, tai yra skirta paprastoms programoms. O Figma yra labai lėta Web aplikacija be kodo.

= Išvados

+ Nubraižius „as-is“ BPMN diagramą, buvo nustatyta, kad sistemai trūksta trijų svarbių funkcijų: naudotojų asmeninių nustatymo redagavimo, straipsnių istorijų išsaugojimo ir forumo diskusijoms apie straipsnių pakeitimus.
+ Atsižvelgus į trūkumus ir nubraižius „to-be“ BPMN diagramą, yra siūloma pridėti asmeninius nustatymus, straipsnių istorijas ir straipsnių forumus.
+ Buvo nustatyta, kad sistema naudosis neprisijungę naudotojai, autorizuoti naudotojai ir Wikimedia Enterprise API naudotojai (kitos IS).
+ Sudarius funkcinių reikalavimų sąrašą, buvo pastebėta, kad yra 11 skirtingų funkcinių reikalavimų
+ Sudarius panaudos atvejų diagramą, buvo pastebėta, kad visi trys naudotojai gali gauti straipsnių sąrašus, straipsnių pakeitimus ir jų turinį
+ Sudarius panaudos atvejų matricą galima pamatyti, jog visi reikalavimai yra padengti.
+ Patikslinus panaudos atvejus scenarijais buvo pastebėta, kad kadangi prisijungęs ir neprisijungęs naudotojai buvo atskirti, daugelis panaudos atvejų nereikalauja išsišakojimų.
+ Pabaigus nubraižyti veiklos diagramas kiekvienam panaudos atvejui, scenarijų validumas buvo patvirtintas.

