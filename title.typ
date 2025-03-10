#set align(center)
#set text(size: 12pt, hyphenate: false)

#image("viko-logo.jpg")

#text(weight: "bold")[
VILNIAUS KOLEGIJA

ELEKTRONIKOS IR INFORMATIKOS FAKULTETAS

Informacinių sistemų katedra
]
#v(20mm) // vertikalus tarpas

#text(size: 16pt, weight: "bold")[
ORGANIZACIJOS IS FUNKCINIAI REIKALAVIMAI
]

Praktinis darbas

#v(10mm)

#text(weight: "bold")[
INFORMACINĖS SISTEMOS (IS24 grupė)
]

#let today = datetime.today()
#v(35mm)

// Jei Dėstytojas, o ne dėstytoja neužmirškite prirašyti 's'!
#table(
    columns: (1fr, 3fr, 3fr, 3fr),
    stroke: none,
    align: left,
    [], [STUDENTAI], [], [AUGUSTINAS JAZGEVIČIUS],
    [], [], [#today.display()], [],
    [], [DĖSTYTOJA], [], [doc. dr. Tatjana LIOGIENĖ],
    [], [], [], [],
)

#align(bottom)[
Vilnius \
#today.year()
]

#pagebreak()
