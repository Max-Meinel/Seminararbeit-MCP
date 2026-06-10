#import "vendor/supercharged-dhbw/lib.typ": *
#import "acronyms.typ": acronyms
#import "glossary.typ": glossary

#show: supercharged-dhbw.with(
  title: "Model Context Protocol: Architektur, aktueller Stand und IT-sicherheitliche Herausforderungen",
  authors: (
    (name: "Max Christian Meinel", student-id: "7864687", course: "WWI23SEB", course-of-studies: "Wirtschaftsinformatik Software Engineering", company: (
      (name: "SAP SE", post-code: "69190", city: "Walldorf")
    )),
  ),
  at-university: false,
  bibliography: bibliography("sources.bib", style: "ieee"),
  date: datetime.today(),
  language: "de",
  supervisor: (university: "Michael Eichberg"),
  university: "Dualen Hochschule Baden-Württemberg",
  university-location: "Mannheim",
  university-short: "DHBW",
  head_of_study_program: "Prof. Dr. Henning Pagnia",
  logo-right: image("assets/sap.png"),
  type-of-thesis: "Seminararbeit",
  show-abstract: false,
  show-code-snippets: true,
  show-confidentiality-statement: false,
  show-declaration-of-authorship: true,
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-table-of-contents: true,
  show-acronyms: false,
  //acronyms: acronyms,
  glossary: glossary,
)

#set heading(supplement: [Kapitel])
#show heading.where(level: 3): set heading(outlined: false)
#show figure.caption: set text(size: 9.5pt)

#include "Kapitel/01_Einleitung.typ"
#include "Kapitel/02_Grundlagen.typ"
#include "Kapitel/03_MCP.typ"
#include "Kapitel/04_Sicherheit.typ"
#include "Kapitel/05_Fazit.typ"
