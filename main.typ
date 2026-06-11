#import "vendor/supercharged-dhbw/lib.typ": *
#import "vendor/supercharged-dhbw/declaration-of-authorship.typ": declaration-of-authorship
#import "acronyms.typ": acronyms
#import "glossary.typ": glossary

#let thesis-title = "Model Context Protocol: Architektur, aktueller Stand und IT-sicherheitliche Herausforderungen"
#let thesis-authors = (
  (name: "Max Christian Meinel", student-id: "7864687", course: "WWI23SEB", course-of-studies: "Wirtschaftsinformatik Software Engineering", company: (
    (name: "SAP SE", post-code: "69190", city: "Walldorf")
  )),
)
#let thesis-date = datetime.today()

#show: supercharged-dhbw.with(
  title: thesis-title,
  authors: thesis-authors,
  at-university: false,
  // Bibliografie wird unten manuell gerendert, damit die ehrenwörtliche
  // Erklärung dahinter stehen kann (Template platziert sie sonst vorne).
  date: thesis-date,
  language: "de",
  supervisor: (university: "Michael Eichberg"),
  university: "Dualen Hochschule Baden-Württemberg",
  university-location: "Mannheim",
  university-short: "DHBW",
  head_of_study_program: "Prof. Dr. Henning Pagnia",
  logo-right: image("assets/sap.png"),
  type-of-thesis: "Seminararbeit",
  show-abstract: true,
  abstract: [
    // Platzhalter — am Ende der Arbeit ausformulieren (ca. 150–250 Wörter):
    // Kontext, Forschungsfrage, Vorgehen, zentrale Ergebnisse, Fazit.
    Diese Arbeit untersucht das Model Context Protocol (MCP) hinsichtlich seiner
    Architektur, seines aktuellen Stands und seiner IT-sicherheitlichen
    Herausforderungen. _(Platzhalter, wird nach Fertigstellung der Kapitel ersetzt.)_
  ],
  show-code-snippets: true,
  show-confidentiality-statement: false,
  show-declaration-of-authorship: false,
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-table-of-contents: true,
  show-acronyms: true,
  acronyms: acronyms,
  glossary: glossary,
)

#set heading(supplement: [Kapitel])
#show figure.caption: set text(size: 9.5pt)

#include "Kapitel/01_Einleitung.typ"
#include "Kapitel/02_Grundlagen.typ"
#include "Kapitel/03_MCP.typ"
#include "Kapitel/04_Sicherheit.typ"
#include "Kapitel/05_Fazit.typ"

#bibliography("sources.bib", title: "Literaturverzeichnis", style: "ieee")

#declaration-of-authorship(
  thesis-authors,
  thesis-title,
  none,
  thesis-date,
  "de",
  false,
  false,
  none,
  "[day].[month].[year]",
)
