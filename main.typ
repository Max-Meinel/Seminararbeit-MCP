#import "vendor/supercharged-dhbw/lib.typ": *
#import "vendor/supercharged-dhbw/declaration-of-authorship.typ": declaration-of-authorship
#import "acronyms.typ": acronyms
#import "glossary.typ": glossary
#import "@preview/muchpdf:0.1.2": muchpdf

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
    Large Language Models entwickeln sich zu autonomen Agenten, die für ihre
    Aufgaben Zugriff auf externe Werkzeuge und Datenquellen benötigen. Mit dem
    Model Context Protocol (MCP) veröffentlichte Anthropic im November 2024 einen
    offenen Standard, der diese Anbindung vereinheitlicht und sich seither
    branchenweit etabliert. Die vorliegende Arbeit untersucht die Forschungsfrage,
    welche Angriffsvektoren das MCP aufweist und inwieweit sich diese mitigieren
    lassen. Dazu werden zunächst die Grundlagen von Sprachmodellen, Agenten und
    Werkzeugintegration sowie die Architektur und die sicherheitsrelevanten
    Designentscheidungen des Protokolls dargestellt. Auf Basis der aktuellen
    Sicherheitsforschung werden anschließend vier Angriffsvektoren
    systematisiert: Indirect Prompt Injection über Inhalte, die Werkzeuge in den
    Modellkontext laden, Tool Poisoning über präparierte Werkzeug-Metadaten
    einschließlich der Varianten Rug Pull und Cross-Server Shadowing, die
    Manipulation der Werkzeugauswahl durch optimierte Tool-Beschreibungen sowie
    der Missbrauch von Tool Chaining in Verbindung mit Sandbox Escape und
    Credential Theft. Empirische Studien belegen die Wirksamkeit dieser Angriffe
    gegen reale MCP-Server und verbreitete Modelle. Als gemeinsame Ursachen
    werden zwei Designentscheidungen identifiziert: Hosts vertrauen
    unverifizierten Server-Metadaten, und das Sprachmodell verarbeitet Daten und
    Anweisungen im selben Kontext. Verfügbare Gegenmaßnahmen wie die Validierung
    von Werkzeugbeschreibungen, Sandboxing und restriktive Autorisierung nach
    Zero-Trust-Prinzipien verkleinern Angriffsfläche und Schadenspotenzial,
    beseitigen die zugrunde liegende Verwundbarkeit jedoch nicht. Ein sicherer
    Einsatz des MCP erfordert daher gegenwärtig, Server als nicht
    vertrauenswürdige Drittkomponenten zu behandeln; auf Protokollebene bleiben
    verbindliche Vertrauensmechanismen wie signierte Manifeste und ein
    verifiziertes Serververzeichnis offene Entwicklungsfelder.
  ],
  show-code-snippets: true,
  show-confidentiality-statement: false,
  show-declaration-of-authorship: false,
  show-list-of-figures: false,
  show-list-of-tables: false,
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

#v(2em)
*Wortanzahl:* 3167 Wörter (Fließtext der Kapitel 1–5, ohne Verzeichnisse und Abstract)

#muchpdf(read("assets/Formular Hilfsmittelangabe KI_V5 schreibgeschützt.pdf", encoding: none), width: 100%)
