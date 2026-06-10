#import "vendor/supercharged-dhbw/lib.typ": *
#import "acronyms.typ": acronyms
#import "glossary.typ": glossary
#import "Kapitel/Abstract.typ" as abstract
#import "Kapitel/Einleitung.typ" as einleitung
#import "Kapitel/Grundlagen.typ" as grundlagen
#import "Kapitel/Methodik.typ" as methodik
#import "Kapitel/Anforderungsanalyse.typ" as anforderungsanalyse
#import "Kapitel/Integrationsstrategien.typ" as integrationsstrategien
#import "Kapitel/Implementierung.typ" as implementierung
#import "Kapitel/Evaluation.typ" as evaluation
#import "Kapitel/Diskussion_und_Fazit.typ" as diskussion_und_fazit

#show: supercharged-dhbw.with(
  title: "Konzeption und Evaluation eines domänenbasierten Explorers als VS-Code Extension für SAP CAP Anwendungen",
  authors: (
    (name: "Max Christian Meinel", student-id: "7864687", course: "WWI23SEB", course-of-studies: "Wirtschaftsinformatik Software Engineering", company: (
      (name: "SAP SE", post-code: "69190", city: "Walldorf")
    )),
  ),
  // displays the acronyms defined in the acronyms dictionary
  at-university: false, // if true the company name on the title page and the confidentiality statement are hidden
  bibliography: bibliography("sources.bib", style: "ieee"),
  date: datetime.today(),
   // displays the glossary terms defined in the glossary dictionary
  language: "de", // en, de
  supervisor: (company: "Christian Fuchs", university: "Ulrich Wolf"),
  university: "Dualen Hochschule Baden-Württemberg",
  university-location: "Mannheim",
  university-short: "DHBW",
  department: "CAP Tools & MTX",
  head_of_study_program: "Prof. Dr. Henning Pagnia",
  //completion_period: (datetime(day: 16, month: 2, year: 2026), datetime(day: 8, month: 5, year: 2026)),
  //submission_date: datetime(day: 11, month: 5, year: 2026),
  logo-right: image("assets/sap.png"),
  type-of-thesis: "Bachelorarbeit",
  abstract: include abstract,
  appendix: include "Kapitel/Anhang.typ",
  show-abstract: true,
  show-code-snippets: true,
  show-confidentiality-statement: false,
  show-declaration-of-authorship: true,
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-table-of-contents: true,
  show-acronyms: false,
  //acronyms: acronyms,
  glossary: glossary,
  // for more options check the package documentation (https://typst.app/universe/package/supercharged-dhbw)
)

#set heading(supplement: [Kapitel])
#show heading.where(level: 3): set heading(outlined: false)

// Kleinere Schrift für Figure Captions
#show figure.caption: set text(size: 9.5pt)

#include einleitung

#include grundlagen

#include methodik

#include anforderungsanalyse

#include integrationsstrategien

#include implementierung

#include evaluation

#include diskussion_und_fazit