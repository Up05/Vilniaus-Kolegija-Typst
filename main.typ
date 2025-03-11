#import("rules.typ"): rules
#show: rules

// Antraštinis lapas
#include("title.typ")

#outline( title: [ Turinys ] )
#outline( title: [ Paveikslų sąrašas ], target: figure.where(kind: image) )
#outline( title: [ Lentelių sąrašas ],  target: figure.where(kind: table) )

#pagebreak()

= ĮVADAS


#h(1.27cm) Šio darbo tikslas yra suformuluoti funkcinius reikalavimus Wikimedia Enterprise organizacijos informaciniai sistemai.

#block[Uždaviniai:]
#v(-1em)
+ Aprašyti organizacijos veiklą.
+ Grafiškai pavaizduoti organizacijos veiklos modelį.
+ Įvardinti pagrindines organizacijos veiklos funkcijas, sudaryti aukščiausio lygmens DFD.
+ Panagrinėti pasirinktą veiklos sritį, sudaryti pirmo ir, jei reiks, antro lygmens DFD.
+ Atskleisti problemas esančias nagrinėjamoje veiklos srityje.
+ Sudaryti bent trijų IS naudotojų sąrašą.
+ Nubraižyti UML funkcijų diagramą ir detalizuoti kiekvieną galimą veiksmą.

= VEIKLOS ANALIZĖ

== Wikimedia Foundation aprašymas

#h(1.27cm) Bus nagrinėjama ne pelno siekianti organizacija Wikimedia Foundations, kuri prižiūri ir palaiko Vikipediją, Wikimedia Commons nemokamų iliustracijų rinkinį, Wiktionary žodyną ir daugelį kitų viešos ir nemokamos informacijos šaltinių. Be to, Wikimedia Foundations kuria ir teikia resursus savo bendruomenei ir bendruomenės projektams. O pelno gauna, pagrinde, per kitų įmonių ir individų rėmimą.

== Grafinis organizacijos veiklos modelis

#figure(
    image("dfd--.png", width: 70%),
    caption: [ Aukščiausio lygio DFD ]
)

Wikimedia Foundations turi tris pagrindines klientų grupes, pirma jų būti kita programinė įranga, kuri naudoja Vikipedijos ar kitų produktų API. Kitos dvi naudotojų grupės yra puslapių lankytojai, autoriai ir bendruomenės nariai. 

== Pagrindinės organizacijos veiklos funkcijos

#figure(
    image("dfd-0.png", width: 80%),
    caption: [ Nulinio lygio DFD ]
)

#figure(
    table(
        columns: (1fr, 1fr), // fractional unit 
        table.header([ *Proceso pavadinimas* ], [ *Proceso aprašymas* ]),
        [ Finansai ir administracija ], [ Procesas, valdantis finansus ir biurokratiją ],
        [ Wikimedia Enterprise ], [ Procesas, palankantis ir tobulinantis Wikimedia API ],
        [ Augimas ], [ Procesas, auginantis bendruomenę ir rementis jos projektus ],
        [ Produktai ir technologijos ], [ Procesas, kuris teika infrastruktūrą vikių puslapiams ],
        [ Teisė ], [ Procesas, konsultuojantis kitus teisės klausimais ],
    ),
    caption: [ Nulinio lygio DFD procesai ]
)

== Pasirinkta nagrinėti veiklos sritis


#figure(
    image("dfd-1.png", width: 70%),
    caption: [ Pirmo lygio DFD ]
)

#figure(
    table(
        columns: (1fr, 1fr), // fractional unit 
        table.header([ *Proceso pavadinimas* ], [ *Proceso aprašymas* ]),
        [ Paslaugų diegimas ], [ Šis skyrius kuria naujinimus informaciniai sistemai pagal administracijos pastabas. ],
        [ Informacinė sistema ], [ Priima ir atsako į naudotojų užklausas. ],
        [ Administracija ], [ Tvarko ir prižiūri Informacinę sistemą, teikia pasiūlymus paslaugų diegimui. ],
    ),
    caption: [ Pirmo lygio DFD procesai ]
)

== Probleminė sritis

#figure(
    image("bpmn-0.png", width: 100%),
    caption: [ BPMN diagrama parodanti kaip vyksta organizacijos veikla ]
)

Wikimedia Foundation turi patikrinti ar IP adresas yra leidžiamas, po to reikia kreiptis į pagrindinę duomenų bazę  ar prašoma informacija nėra konfidenciali, tada patikrinama ar norimma perskaityti, ar pakeisti duomenis. Jei prašoma perskaityti viešus duomenis, tai jie surenkami ir išsiųnčiami klientui. Jei duomenys yra privatūs arba bus kaip nors redaguojami, reikalaujama prisijungti, iš duomenų bazės gaunami duomenys, jie patikrinami ir tada bendrai procesuojamas prašymas.

== Veiklos analizės išvados

+ Patikrinus ar prašoma keisti duomenis anksčiau nei ar jie yra konfidencialūs, galima dažnai išvengti vieno kreipimo į duomenų bazę, nes, iš praktikos, žinome kad didžioji dalis kreipimusi yra perskaitytii viešus straipsnius. Taigi, reikia atlikti keitimo patikrą prieš konfidencialumo.
+ Įdiegus praeitą pasiūlymą, prašymo tipo patikrinimo procesas, galėtų tapti Prašymų priėmimo dalimi, nes prašymo tipo patikrinimas yra labai mažas veiksmas ir, manau, neapsimoka jo laikyti procesu.
+ Teisių lygis galėtų būti siunčiamas ir toliau, taip išvengiant teisių patikrinimo proceso ir dar vieno kreipimosi į duomenų bazę, taigi, būtų geriau išimti Teisių patikrinimo procesą ir tiesiog prisegti naudotojo teisių lygį prie toliau keliaujančių duomenų.

#pagebreak()

= FUNKCINIAI REIKALAVIMAI

== IS naudotojai

+ Neprisijungęs naudotojas - šio tipo naudotojas gali perskaityti straipsnius, ir matyti jų pakeitimų istoriją, pakeisti kelis nustatymus kaip kalbą ir stilių, gauti visų straipsnių ir žodžių sąrašus ir galimybę prisijungti.
+ Autorizuotas naudotojas - gali daryti viską ką gali neprisijungęs naudotojas, pakeisti straipsnių turinį ir dalyvauti diskusijose.
+ Wikimedia API naudotojas - su Wikimedijos REST API gali padaryti viską tą patį kaip autorizuotas naudotojas (jei turi autorizacijos žetoną), išskyrus pakeisti asmeninius nustatymus ir prisijungti. Be to, gauti tik dalį turinio ir gauti signalą kai nutinka pasirinktas įvykis (pavyzdžiui straipsnio pakeistimas)

== IS funkcinių reikalavimų sąrašas

Neprisijungę naudotojai:
    + Gali perskaityti viešai pateiktą informaciją
    + Matyti straipsnių pakeitimo istoriją
    + Pakeisti asmeninius nustatymus
    + Gauti straipsnių ir žodžių reikšmių sąrašus
    + Turėti galimybę prisijungti
Prisijungę naudotojai:
    + Turi galėti perskaityti viešai pateiktą informaciją
    + Matyti straipsnių pakeitimo istoriją
    + Pakeisti asmeninius nustatymus
    + Gauti straipsnių ir žodžių reikšmių sąrašus
    + Turėti galimybę atsijungti ir pakeisti prisijungimo duomenis
    + Pakeisti straipsnių turinį
    + Gauti privačią informaciją
    + Dalyvauti diskusijose
Wikimedia API naudotojai:
    + Turi galėti perskaityti viešai pateiktą informaciją
    + Matyti straipsnių pakeitimo istoriją
    + Gauti straipsnių ir žodžių reikšmių sąrašus
    + Turėti galimybę atsijungti ir pakeisti prisijungimo duomenis
    + Pakeisti straipsnių turinį
    + Gauti dalį turinio
    + Prenumeruoti įvykius

== IS funkcijų diagrama

#figure(
    image("UML.png", width: 80%),
    caption: [ Funkcinių reikalavimų UML diagrama ]
)

#v(1.27cm) Viršuje pateiktoje diagramoje yra parodyti trys sistemos naudotojai. Pirmas jų yra neprisijungęs naudotojas, tokį statusą gauna visi per Interneto naršyklę atėję, autorizavimo sesijai nepriklausantys naudotojai. Tokie naudotojai neturi daug teisių, jie gali pakeisti jų asmeninę informaciją, nors serveriai neturi kaip sinchronizuoti nustatymus per sesijas, be to gali peržiūrėti viešą informaciją, kaip straipsnius ir jų istoriją. Antrai kategorijai priklauso prisijungę naudotojai, jie gali daryti beveik viską, ką gali daryti neprisijungią naudotojai, bet jų veiksmai yra surišti su jų profiliu, jie gali pridėti, ištrinti ir pakeisti didžiąją dalį informacijos, pamatyti savo asmeninius duomenys ir daugiau. Be to, yra ir būdas Wikimedia Enterprise informacija naudotis kitoms informacinėms/automatizuotoms sistemoms: Wikimedia Enterprise API. Tokie naudotojai gali gauti informaciją ir dalis, ir iš viso, prie HTTP prašymo prisegus savo autentifikavimo žetoną, gali ir pakeisti, ir prenumeruoti norimus įvykius, taip gauti pranešimus apie juos iš serverio.

#let uml_script(name: content, user: content, desc: content, pre: content, event: content, post: content) = { 
    block( 
        width: 100%, stroke: 0.5pt + black, inset: 5pt, 
        [
            *PANAUDOS ATVEJIS:* #name #linebreak()
            *Vartotojas/aktorius:* #user #linebreak()
            *Aprašas:* #desc #linebreak()
            #if pre != none [ *Prieš-sąlyga:* #pre #linebreak() ]
            #if pre != none [ *Sužadinimo sąlyga:* #event #linebreak() ]
            #if pre != none [ *Po-sąlyga:* #post ]

        ]
    ) 
}

#uml_script(
    name: [ Prisijungti ],
    user: [ Neprisijungęs naudotojas, prisijungęs naudotojas ],
    desc: [ Naudotojas turi sugebėti prisijungti ir registruotis ],
    pre:  none,
    event: [ Prisijungimo duomenų įvedimas ],
    post: [ Naudotojas tampa arba tik prisijungusiu, arba kitu prisijungsiu naudotoju ]
)

#uml_script(
    name: [ Pakeisti asmeninius nustatymus ],
    user: [ Neprisijungęs naudotojas, prisijungęs naudotojas ],
    desc: [ Nustatymų kaip tamsusis režimas, straipsnio kalba, tik HTML puslapiai ir kitų pakeitimas ],
    pre:  none,
    event: [ Naudotojo pasirinkimas ],
    post: [ Naudotojas gauna kitokį arba kitaip atrodantį, veikianti tinklaraštį ]
)

#uml_script(
    name: [ Peržiūrėti privačią informaciją ],
    user: [ Prisijungęs naudotojas ],
    desc: [ Prisijungęs naudotojas gali pamatyti savo e. paštą, nustatymus ir kitą jam aktualią informaciją ],
    pre:  none,
    event: [ Nuėjimas į šios informacijos laikymo vietas ],
    post: none
)

#uml_script(
    name: [ Redaguoti viešą informaciją ],
    user: [ Prisijungęs naudotojas, Wikimedia API naudotojas ],
    desc: [ Pavyzdžiui, straipsnių arba žodyno turinio redagavimas. Naudotojas tam turi būti prisijungęs dėl blogų veikėjų. ],
    pre:  [ Naudotojo teisių patikrinimas ],
    event: [ Pakeisto straipsnio pateikimas ],
    post: [ Informacija pakeičiama visiems ]
)

#uml_script(
    name: [ Dalyvauti diskusijose ],
    user: [ Prisijungęs naudotojas ],
    desc: [ Kiekvienas straipsnis turi jam priskirtą diskusiją, kurioje dalyvauti gali tik prisijungę asmenys ],
    pre:  none,
    event: [ Komentaro pateikimas ],
    post: [ Visi mato pateiktą komentaro ]
)

#uml_script(
    name: [ Gauti dalį turinio ],
    user: [ Wikimedia API naudotojas ],
    desc: [ Wikimedia API naudotojas gali iš straipsnio pasiimti tik medijos elementus (kaip paveikslus, vaizdo, garso įrašus ir t.t.) ],
    pre:  none,
    event: [ REST API prašymas ],
    post: [ HTTP atsakymas su elementu arba 404 statusu ]
)

#uml_script(
    name: [ Prenumeruoti įvykius ],
    user: [ Wikimedia API naudotojas ],
    desc: [ Kai įvyksta pasirinktas įvykis (pvz.: straipsnio redagavimas), Wikimedijos serveris kreipsis į API naudotojo serverį ir praneš, kad įvykis įvyko ],
    pre:  [ Įvykis ],
    event: [ HTTP prašymas ],
    post: none
)


#uml_script(
    name: [ Perskaityti viešą informaciją ],
    user: [ Neprisijungęs naudotojas, prisijungęs naudotojas, Wikimedia API naudotojas ],
    desc: [ Visi turi priegą prie beveik visų Wikipedijos straipsnių, sąvokų ir kitų produktų ],
    pre:  none,
    event: [ Apsilankymas vienoje iš Wikimedia Foundation svetainių ],
    post: [ Turinio gavimas ]
)

#uml_script(
    name: [ Peržiūrėti straipsnių pakeitimo įstoriją ],
    user: [ Neprisijungęs naudotojas, prisijungęs naudotojas, Wikimedia API naudotojas ],
    desc: [ Straipsniai turi pririštą pakeitimų istoriją, tam, kad vienas asmuo negalėtų tiesiog ištrinti dalies straipsnio. Visi gali ją pamatyti. ],
    pre:  none,
    event: [ Nuėjimas į straipsnio įstoriją ],
    post: none
)

#uml_script(
    name: [ Peržiūrėti straipsnių sąrašus ],
    user: [ Neprisijungęs naudotojas, prisijungęs naudotojas, Wikimedia API naudotojas ],
    desc: [ Bet kas gali pamatyti filtruotus, rušiuotus ar kuruojamus straipsnių sąrašus ],
    pre:  none,
    event: [ Apsilankyti viename straipsnių sąrašų ],
    post: none
)

#pagebreak()

= Išvados

+ Aprašius organizacijos veiklą, galima pamatyti, kad organizacijos misija yra palaikyti viešos informacijos šaltinius internete, nes išskyrūs tai, Wikimedia Foundation dar tik palaiko bendruomenę.
+ Grafiškai aprašius organizacijos modelį, galima paskirstyti klientus į dvi kategorijas: žmonės ir programinė įranga. Programinei įrangai priklauso Wikimedia Enterprise API naudotojai, o žmonėms Vikių puslapių lankytojus ir kūrėjus, savanorius.
+ Nubraižius nulinio lygio duomenų srautų diagramą, jau matosi, kad Vikių palaikymas sudaro tik dvi organizacijos dalis, dar yra Finansai ir administracija, teisė ir augimas.
+ Išnagrinėjus pirmo lygio DFD, pasimato cikliškas Wikimedia Enterprise skyriaus vidus. Čia Pauslaugų diegimas Informacinėje sistemoje diegia atnaujinimus, IS automatiškai daro suvestines, kurias gauna Administracija, kuri tada Paslaugų diegimui teikia pastabas.
+ Sudarus dabartinės Wikimedia Enterprise būsenos BPMN diagramą, matome, kad procesai kreipiasi į duomenų bazes daug daugiau nei reikia, tiesiog apkeitūs patikrinimo proceesus vietomis galima būtų išvengti 50% užklausų ir galutinis rezultatas nepasikeistų.
+ Sudarius naudotojų sąrašą, galima įsitikinti, kad tikrai organizacija turi du naudotojų tipus: programinė įranga ir žmonės.
+ Nubraižius UML diagrama, galima teigti kad yra trys veiksmai bendri visiems naudotojams: straipsnių sąrašo, istorijos ir pačios informacijos peržiūrėjimas, nes visi kiti yra bendri tik vienam arba dviems naudotojams, o pavyzdžiui, API naudotojai neturi galimybės prisijungti, jiems reikia pridėti autentifikacijos žetoną prie užklausos antraščių.


#pagebreak()

#align(center)[ #text(size: 14pt, weight: "bold")[ LITERATŪROS SĄRAŠAS ] ]

+ Wikimedia Stategic Planning. (2011). _Wikimedia movement/orgizational structure._ \
  https://strategy.wikimedia.org/wiki/Wikimedia_movement/Organizational_structure
+ Wikimedia Strategic Planning. (2024). _Wikimedia Enterprise._ \
  https://meta.wikimedia.org/wiki/Wikimedia_Enterprise
+ Wikimedia Meta-wiki. (2024). _Wikimedia Foundation._ \
  https://meta.wikimedia.org/wiki/Wikimedia_Foundation
+ Wikimedia API Portal. (n.d.). _Wikimedia Foundation._ \
  https://api.wikimedia.org/wiki/Core_REST_API
+ Liogienė, T. (n.d.). _Informacijos sistemos ir jų sauga_ \
  https://vma2023.viko.lt/course/view.php?id=726

// ===== ŠALTINIAI =====
// #pagebreak()

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

// Todo: fix to not make this show up in the TOC
// #heading(numbering: none, "Literatūros šąrašas")
// + Pirmas šaltinis
// + Antras šaltinis
