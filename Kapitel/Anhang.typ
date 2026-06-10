// Anhang - wird über appendix-Parameter in main.typ eingebunden

#import "../vendor/supercharged-dhbw/lib.typ": *
#import "@preview/muchpdf:0.1.2": muchpdf

#heading(level: 2, numbering: none, outlined: false)[Testumgebung]

Die Performance-Messungen in Kapitel~7 wurden unter folgenden Bedingungen durchgeführt:

#figure(
  supplement: [Tabelle],
  caption: [Testumgebung für Performance-Messungen],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, 1fr),
    inset: (x: 10pt, y: 6pt),
    align: (left, left),
    stroke: 0.3pt + black,
    [*Komponente*], [*Spezifikation*],
    [Hardware], [MacBook Air M2 (2022), 8 GB RAM],
    [Betriebssystem], [macOS Sequoia 15.3.0 (Darwin arm64 25.3.0)],
    [VS Code], [Version 1.110.0 (Universal)],
    [Node.js], [Version 22.22.0],
    [Electron], [Version 39.6.0],
    [Chromium], [Version 142.0.7444.265],
  )
]<testumgebung_table>

#pagebreak()

#heading(level: 2, numbering: none, outlined: false)[Anhang A: LSP workspace/symbol Response-Struktur]

Die folgende Abbildung zeigt die Response-Struktur des `workspace/symbol` Requests mit dem `/gax`-Flag für die Domain-Model-Entity `Travels` aus `db/schema.cds`.

#figure(
  kind: raw,
  supplement: [Quellcode],
  caption: [LSP-Response für ein Symbol aus der `/gax` Query],
  box(
    fill: rgb("#1e1e1e"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #set text(font: "DejaVu Sans Mono", size: 9pt, fill: rgb("#d4d4d4"))
    #set align(left)
    #let key = rgb("#9CDCFE")
    #let str = rgb("#CE9178")
    #let num = rgb("#B5CEA8")

    \{\
    #h(1em)#text(fill: key)["name"]: #text(fill: str)["Travels"],\
    #h(1em)#text(fill: key)["kind"]: #text(fill: num)[5],\
    #h(1em)#text(fill: key)["location"]: \{\
    #h(2em)#text(fill: key)["uri"]: #text(fill: str)["file:\//workspace/db/schema.cds"],\
    #h(2em)#text(fill: key)["range"]: \{\
    #h(3em)#text(fill: key)["start"]: \{ #text(fill: key)["line"]: #text(fill: num)[12], #text(fill: key)["character"]: #text(fill: num)[7] \},\
    #h(3em)#text(fill: key)["end"]: \{ #text(fill: key)["line"]: #text(fill: num)[12], #text(fill: key)["character"]: #text(fill: num)[14] \}\
    #h(2em)\}\
    #h(1em)\},\
    #h(1em)#text(fill: key)["containerName"]: #text(fill: str)["sap.capire.travels"],\
    #h(1em)#text(fill: key)["data"]: \{\
    #h(2em)#text(fill: key)["flags"]: #text(fill: num)[131072]\
    #h(1em)\}\
    \}
  ]
)<lsp_symbol_response_anhang>

#pagebreak()

#heading(level: 2, numbering: none, outlined: false)[Anhang B: Flag-Spezifikation für servicezentrierte Navigation]

Die folgende Tabelle dokumentiert die Flags, die im `flags`-Feld der LSP-Response kodiert sind. Die Flags werden als Bitmasken implementiert und ermöglichen die Kategorisierung und Filterung von Symbolen.

Jedes Flag entspricht einer Zweierpotenz (Bit-Position). Der numerische Wert wird durch Potenzierung berechnet. Bei kombinierten Flags werden die Werte addiert:

- *Einzelnes Flag*: DOMAIN_MODEL ist an Bit-Position 17 definiert. Der Wert berechnet sich als $2^17 = 131072$.
- *Kombinierte Flags*: Wenn ein Symbol sowohl ASSOCIATION (Bit 12) als auch DEFINITION (Bit 0) hat, werden die Werte addiert: $2^12 + 2^0 = 4096 + 1 = 4097$.

#figure(
  supplement: [Tabelle],
  caption: [Flags für servicezentrierte Navigation],
)[
  #set text(size: 8.5pt)
  #table(
    columns: (auto, auto, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (left, center, left),
    stroke: 0.3pt + black,
    [*Flag*], [*Bit*], [*Bedeutung*],
    [DEFINITION], [0], [Kennzeichnet eine Definition (nicht nur Referenz)],
    [REFERENCE], [1], [Kennzeichnet eine Referenz auf ein Symbol],
    [ANNOTATION], [2], [Markiert Annotationen],
    [EXPLICIT_NAMESPACE], [3], [Explizit deklarierter Namespace],
    [IMPLICIT_NAMESPACE], [4], [Implizit abgeleiteter Namespace],
    [TRANSLATION_STRING], [5], [Übersetzungsschlüssel für i18n],
    [USING_PATH], [6], [Import-Pfad in `using`-Statement],
    [EXTEND], [7], [Element aus `extend`-Statement],
    [ASPECT], [8], [Markiert Aspects],
    [TEXTS], [9], [Lokalisierte Texte],
    [HAS_AUTOEXPOSED_ENTITIES], [10], [Service hat automatisch exponierte Entities],
    [ANNOTATION_MODELER_XREF], [11], [Cross-Referenz für Annotation Modeler],
    [ASSOCIATION], [12], [Association-Beziehung zwischen Entities],
    [COMPOSITION], [13], [Composition-Beziehung zwischen Entities],
    [FEDERATED], [14], [Federated Entity aus externem Service],
    [CODE_LIST], [15], [Code-Liste für Value-Help],
    [EXTERNAL_SERVICE], [16], [Externer Service (Remote API)],
    [DOMAIN_MODEL], [17], [Entity im Datenbank-Schema ohne Service-Zugehörigkeit],
    [AUTOEXPOSED_ENTITY], [18], [Automatisch exponierte Entity],
    [ACTION], [19], [Action (modifiziert Daten)],
    [VIEW], [20], [Projektion statt persistente Entity],
    [ANNOTATED_IDENTIFIER], [21], [Identifier mit Annotations],
  )
]<flag_spezifikation_table>

#pagebreak()

#heading(level: 2, numbering: none, outlined: false)[Anhang C: Explorative Entwickler-Rückmeldungen]

Im Rahmen der Evaluation wurden explorative Rückmeldungen von zwei CAP-Entwicklern eingeholt.

#figure(
  supplement: [Tabelle],
  caption: [Übersicht der explorativen Entwickler-Rückmeldungen],
)[
  #set text(size: 8.5pt)
  #table(
    columns: (auto, 1.2fr, 1.2fr),
    inset: (x: 6pt, y: 5pt),
    align: (left, left, left),
    stroke: 0.3pt + black,
    [*Kriterium*], [*Teilnehmer 1*], [*Teilnehmer 2*],

    [CAP-Erfahrung], [>5 Jahre], [1-2 Jahre],
    [Testprojekt], [bookshop Sample], [Produktives Projekt (131 Entities)],
    [Gewählte Aufgabe], [Finde alle Entities von CatalogService], [Handler-Implementierung zu Service finden],
    table.hline(),
    [Benutzerfreundlichkeit], [5/5], [5/5],
    [Navigationsaufwand-Reduktion], [3/5], [4/5],
    [Beziehungsdarstellung], [5/5], [5/5],
    [Nutzungsabsicht], [5/5], [4/5],
    table.hline(),
    [Positiv], [TreeView-Übersicht funktioniert], [• TreeView-Übersicht und Suche funktionieren gut\
                                                     • Direkte Navigation zur Definition],
    [Probleme], [• Kein Icon in Extension Bar\
                 • Icons im README fehlen\
                 • Buttons wirken zu dominant], [• Suche schwer zu finden\
                                                  • Nach Refresh Zustand nicht erhalten\
                                                  • `extend`-Statements erscheinen doppelt\
                                                  • Java Action-Implementierung nicht gefunden],
    [Verbesserungsvorschläge], [Buttons in Titelbar integrieren], [• Sortierung nach Name (bei >100 Entities)\
                                                        • Annotations über `annotate` anzeigen\
                                                        • Felder auch für Domain-Model anzeigen\
                                                        • Namespace-Gruppierung],
  )
]<feedback_table>

#pagebreak()

#heading(level: 2, numbering: none, outlined: false)[Begründung der Nutzwertanalyse]

Die folgende Tabelle dokumentiert die Begründung der Punktvergabe für die in Kapitel 5 durchgeführte Nutzwertanalyse der drei Integrationsstrategien.

#figure(
  supplement: [Tabelle],
  caption: [Detaillierte Begründung der Punktvergabe in der Nutzwertanalyse],
)[
  #set text(size: 8pt)
  #table(
    columns: (auto, auto, auto, 2.5fr),
    inset: (x: 6pt, y: 5pt),
    align: (left, left, center, left),
    stroke: 0.5pt + black,
    [*Kriterium*], [*Strategie*], [*Punkte*], [*Begründung*],
    table.cell(rowspan: 3)[K1: Semantische Genauigkeit], [Repository], [2], [Eigenes Parsing ohne Nutzung des CAP-Compilers; Risiko semantischer Fehlinterpretationen],
    [CSN], [5], [Nutzt kompiliertes CAP-Modell; semantisch korrekte Interpretation garantiert],
    [Language Server], [5], [Nutzt CAP-Compiler; semantische Analyse durch SAP-Tooling],
    table.cell(rowspan: 3)[K2: Positionsinformationen], [Repository], [3], [Positionen aus eigenem Parsing verfügbar, aber aufwändige Implementierung],
    [CSN], [1], [CSN enthält keine Quellcode-Positionen (Zeile/Spalte)],
    [Language Server], [5], [Location-API liefert präzise Positionen],
    table.cell(rowspan: 3)[K3: VS Code Integration], [Repository], [2], [Keine native Integration; eigene Adapter erforderlich],
    [CSN], [3], [JSON-Daten müssen transformiert werden],
    [Language Server], [5], [Native LSP-Schnittstellen direkt nutzbar],
    table.cell(rowspan: 3)[K4: Implementierungsaufwand], [Repository], [2], [Hoher Aufwand: eigener Parser erforderlich],
    [CSN], [4], [Geringer Aufwand: JSON-Parsing],
    [Language Server], [3], [Mittlerer Aufwand: LSP-Client-Integration],
    table.cell(rowspan: 3)[K5: Wartbarkeit], [Repository], [2], [Parser muss bei Sprachänderungen angepasst werden],
    [CSN], [3], [CSN-Schema kann sich ändern],
    [Language Server], [4], [LSP ist stabiler Standard],
    table.cell(rowspan: 3)[K6: Unabhängigkeit], [Repository], [5], [Keine externen Abhängigkeiten],
    [CSN], [2], [Abhängigkeit vom CAP-Compiler],
    [Language Server], [2], [Abhängigkeit vom Language Server],
  )
]<nutzwertanalyse_begruendung_table>

#pagebreak()

#heading(level: 2, numbering: none, outlined: false)[Detaillierte Navigationsschritte für Bookshop-Szenarien]
#label("bookshop-navigationsschritte")

Die folgenden Tabellen dokumentieren die detaillierten Navigationsschritte für drei weitere Entwicklungsszenarien im Bookshop-Projekt. Das Szenario "Service verstehen" ist in Kapitel 4 dargestellt.

#figure(
  supplement: [Tabelle],
  caption: [Szenario "Feld hinzufügen" -- 6 Dateien, 6 Navigationsschritte],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, 1fr, auto, 2fr),
    inset: (x: 10pt, y: 6pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Aktion*],
    [1], [`db/schema.cds`], [4--13], [Entity `Books` finden, Feld hinzufügen],
    [2], [`srv/cat-service.cds`], [6--16], [Projektionen `ListOfBooks` und `Books` anpassen],
    [3], [`srv/admin-service.cds`], [5], [AdminService Projection prüfen],
    [4], [`srv/admin-constraints.cds`], [4--18], [Validierungs-Constraints prüfen],
    [5], [`srv/cat-service.js`], [9--23], [CatalogService Handler prüfen],
    [6], [`srv/admin-service.js`], [4--5], [AdminService Handler prüfen],
  )
]<nav_feld_hinzufuegen>

#figure(
  supplement: [Tabelle],
  caption: [Szenario "Auth anpassen" -- 3 Dateien, 4 Navigationsschritte],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, 1fr, auto, 2fr),
    inset: (x: 10pt, y: 6pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Aktion*],
    [1], [`srv/cat-service.cds`], [3], [Service-Definition identifizieren],
    [2], [`srv/cat-service.cds`], [18--19], [`@requires`-Annotation und betroffene Action],
    [3], [`db/schema.cds`], [4--29], [Exponierte Daten auf Sensibilität prüfen],
    [4], [`srv/cat-service.js`], [14--23], [Handler auf Auth-abhängige Logik prüfen],
  )
]<nav_auth_anpassen>

#figure(
  supplement: [Tabelle],
  caption: [Szenario "Handler debuggen" -- 3 Dateien, 4 Navigationsschritte],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, 1fr, auto, 2fr),
    inset: (x: 10pt, y: 6pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Aktion*],
    [1], [`srv/cat-service.js`], [14], [`submitOrder`-Handler finden],
    [2], [`srv/cat-service.js`], [15--22], [Handler-Logik analysieren],
    [3], [`srv/cat-service.cds`], [19], [Action-Definition und Parameter prüfen],
    [4], [`db/schema.cds`], [4--13], [Entity `Books` mit `stock`-Feld verstehen],
  )
]<nav_handler_debuggen>

#pagebreak()

#heading(level: 2, numbering: none, outlined: false)[Navigationsabläufe in CAP-Projekten]
#label("navigationsablaeufe-anhang")

Die folgenden Tabellen dokumentieren die Navigationsschritte für typische Entwicklungsszenarien in verschiedenen CAP-Projekten. Für jedes Szenario werden die Abläufe ohne und mit Extension gegenübergestellt, um die Reduktion des Navigationsaufwands zu quantifizieren.

#heading(level: 3, numbering: none, outlined: false)[Szenario 1: Service verstehen]

*Aufgabe:* Ein Entwickler soll sich einen Überblick über einen Service verschaffen und dessen exponierte Entities, Operationen und Struktur verstehen.

#heading(level: 3, numbering: none, outlined: false)[xtravels (TravelService)]

#figure(
  supplement: [Tabelle],
  caption: [Navigationsablauf "Service verstehen" (xtravels) – Vergleich],
)[
  #set text(size: 9pt)

  #text(weight: "bold", size: 10pt)[Ohne Extension]
  #v(0.3em)
  #table(
    columns: (auto, 1.5fr, auto, 2fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Zweck*],
    [1a], [`srv/travel-service.cds`], [5--22], [Datei im Explorer öffnen],
    [1b], [`srv/travel-service.cds`], [5--22], [Zur Service-Definition navigieren],
    [1c], [`srv/travel-service.cds`], [--], [Zurück zur vorherigen Datei],
    [2a], [`srv/travel-exports.cds`], [5--24], [Datei im Explorer öffnen],
    [2b], [`srv/travel-exports.cds`], [5--24], [Export-Funktionen navigieren],
    [2c], [`srv/travel-exports.cds`], [--], [Zurück zur vorherigen Datei],
    [3a], [`db/schema.cds`], [8--60], [Datei im Explorer öffnen],
    [3b], [`db/schema.cds`], [8--60], [Domain-Entities navigieren],
    [3c], [`db/schema.cds`], [--], [Zurück zur vorherigen Datei],
    [4a], [`srv/travel-service.js`], [3--12], [Datei im Explorer öffnen],
    [4b], [`srv/travel-service.js`], [3--12], [Handler-Klasse navigieren],
    [4c], [`srv/travel-service.js`], [--], [Zurück zur vorherigen Datei],
  )

  #v(1em)

  #text(weight: "bold", size: 10pt)[Mit Extension]
  #v(0.3em)
  #table(
    columns: (auto, 2fr, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, left),
    stroke: 0.5pt + black,
    [*\#*], [*Aktion*], [*Ergebnis*],
    [1], [Klick: TravelService], [Service-Definition öffnet sich],
    [2], [Klick: Entities (7)], [Alle exponierten Entities sichtbar],
    [3], [Klick: Travels → Actions (5)], [Alle Actions sichtbar],
  )
]

#heading(level: 3, numbering: none, outlined: false)[bookshop (CatalogService)]

#figure(
  supplement: [Tabelle],
  caption: [Navigationsablauf "Service verstehen" (bookshop) – Vergleich],
)[
  #set text(size: 9pt)

  #text(weight: "bold", size: 10pt)[Ohne Extension]
  #v(0.3em)
  #table(
    columns: (auto, 1.5fr, auto, 2fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Zweck*],
    [1a], [`srv/cat-service.cds`], [3--20], [Datei im Explorer öffnen],
    [1b], [`srv/cat-service.cds`], [3--20], [Zur Service-Definition navigieren],
    [1c], [`srv/cat-service.cds`], [--], [Zurück zur vorherigen Datei],
    [2a], [`db/schema.cds`], [4--29], [Datei im Explorer öffnen],
    [2b], [`db/schema.cds`], [4--29], [Domain-Entities navigieren],
    [2c], [`db/schema.cds`], [--], [Zurück zur vorherigen Datei],
    [3a], [`srv/cat-service.js`], [3--27], [Datei im Explorer öffnen],
    [3b], [`srv/cat-service.js`], [3--27], [Handler-Implementierung navigieren],
    [3c], [`srv/cat-service.js`], [--], [Zurück zur vorherigen Datei],
  )

  #v(1em)

  #text(weight: "bold", size: 10pt)[Mit Extension]
  #v(0.3em)
  #table(
    columns: (auto, 2fr, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, left),
    stroke: 0.5pt + black,
    [*\#*], [*Aktion*], [*Ergebnis*],
    [1], [Klick: CatalogService], [Service-Definition öffnet sich],
    [2], [Klick: Entities (2)], [ListOfBooks und Books sichtbar],
  )
]

#heading(level: 3, numbering: none, outlined: false)[ctsm-develop (StudyOverviewService)]

#figure(
  supplement: [Tabelle],
  caption: [Navigationsablauf "Service verstehen" (ctsm-develop) – Vergleich],
)[
  #set text(size: 9pt)

  #text(weight: "bold", size: 10pt)[Ohne Extension]
  #v(0.3em)
  #table(
    columns: (auto, 1.5fr, auto, 2fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Zweck*],
    [1a], [`srv/models/studyoverview-service.cds`], [11--186], [Datei im Explorer öffnen],
    [1b], [`srv/models/studyoverview-service.cds`], [11--186], [Zur Service-Definition navigieren],
    [1c], [`srv/models/studyoverview-service.cds`], [--], [Zurück zur vorherigen Datei],
    [2a], [`db/models/Forecast/...`], [--], [Ordner im Explorer öffnen],
    [2b], [`db/models/Forecast/...`], [--], [Domain-Entities in Unterordnern suchen],
    [2c], [`db/models/Forecast/...`], [--], [Zurück zur vorherigen Datei],
    [3a], [`srv/impl/studyoverview-service.js`], [1--60], [Datei im Explorer öffnen],
    [3b], [`srv/impl/studyoverview-service.js`], [1--60], [Handler-Implementierung navigieren],
    [3c], [`srv/impl/studyoverview-service.js`], [--], [Zurück zur vorherigen Datei],
    [4a], [`srv/models/external/*.csn`], [--], [Ordner im Explorer öffnen],
    [4b], [`srv/models/external/*.csn`], [--], [Externe Service-Referenzen navigieren],
    [4c], [`srv/models/external/*.csn`], [--], [Zurück zur vorherigen Datei],
  )

  #v(1em)

  #text(weight: "bold", size: 10pt)[Mit Extension]
  #v(0.3em)
  #table(
    columns: (auto, 2fr, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, left),
    stroke: 0.5pt + black,
    [*\#*], [*Aktion*], [*Ergebnis*],
    [1], [Klick: StudyOverviewService], [Service-Definition öffnet sich],
    [2], [Klick: Entities (19)], [Alle exponierten Entities sichtbar],
  )
]

#pagebreak()

#heading(level: 3, numbering: none, outlined: false)[Szenario 2: Action lokalisieren]

*Aufgabe:* Ein Entwickler soll eine bestimmte Action finden, ihre Definition verstehen und die Handler-Implementierung lokalisieren.

#heading(level: 3, numbering: none, outlined: false)[xtravels (acceptTravel)]

#figure(
  supplement: [Tabelle],
  caption: [Navigationsablauf "Action lokalisieren" (xtravels) – Vergleich],
)[
  #set text(size: 9pt)

  #text(weight: "bold", size: 10pt)[Ohne Extension]
  #v(0.3em)
  #table(
    columns: (auto, 1.5fr, auto, 2fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Zweck*],
    [1a], [`srv/travel-service.cds`], [9], [Datei im Explorer öffnen],
    [1b], [`srv/travel-service.cds`], [9], [Action-Definition navigieren],
    [1c], [`srv/travel-service.cds`], [--], [Zurück zur vorherigen Datei],
    [2a], [`srv/travel-service.js`], [142--161], [Datei im Explorer öffnen],
    [2b], [`srv/travel-service.js`], [142--161], [Handler-Methode navigieren],
    [2c], [`srv/travel-service.js`], [--], [Zurück zur vorherigen Datei],
    [3a], [`db/schema.cds`], [52--60], [Datei im Explorer öffnen],
    [3b], [`db/schema.cds`], [52--60], [TravelStatus-Entity navigieren],
    [3c], [`db/schema.cds`], [--], [Zurück zur vorherigen Datei],
  )

  #v(1em)

  #text(weight: "bold", size: 10pt)[Mit Extension]
  #v(0.3em)
  #table(
    columns: (auto, 2fr, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, left),
    stroke: 0.5pt + black,
    [*\#*], [*Aktion*], [*Ergebnis*],
    [1], [Suchfeld: "acceptTravel"], [Tree filtert auf Action],
    [2], [Klick: acceptTravel()], [Datei öffnet sich an Zeile 9],
  )
]

#heading(level: 3, numbering: none, outlined: false)[bookshop (submitOrder)]

#figure(
  supplement: [Tabelle],
  caption: [Navigationsablauf "Action lokalisieren" (bookshop) – Vergleich],
)[
  #set text(size: 9pt)

  #text(weight: "bold", size: 10pt)[Ohne Extension]
  #v(0.3em)
  #table(
    columns: (auto, 1.5fr, auto, 2fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Zweck*],
    [1a], [`srv/cat-service.cds`], [19], [Datei im Explorer öffnen],
    [1b], [`srv/cat-service.cds`], [19], [Action-Definition navigieren],
    [1c], [`srv/cat-service.cds`], [--], [Zurück zur vorherigen Datei],
    [2a], [`srv/cat-service.js`], [14--23], [Datei im Explorer öffnen],
    [2b], [`srv/cat-service.js`], [14--23], [Handler-Methode navigieren],
    [2c], [`srv/cat-service.js`], [--], [Zurück zur vorherigen Datei],
  )

  #v(1em)

  #text(weight: "bold", size: 10pt)[Mit Extension]
  #v(0.3em)
  #table(
    columns: (auto, 2fr, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, left),
    stroke: 0.5pt + black,
    [*\#*], [*Aktion*], [*Ergebnis*],
    [1], [Suchfeld: "submitOrder"], [Tree filtert auf Action],
    [2], [Klick: submitOrder()], [Datei öffnet sich an Zeile 19],
  )
]

#heading(level: 3, numbering: none, outlined: false)[ctsm-develop (Entity Projection lokalisieren)]

#figure(
  supplement: [Tabelle],
  caption: [Navigationsablauf "Entity lokalisieren" (ctsm-develop) – Vergleich],
)[
  #set text(size: 9pt)

  #text(weight: "bold", size: 10pt)[Ohne Extension]
  #v(0.3em)
  #table(
    columns: (auto, 1.5fr, auto, 2fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Zweck*],
    [1a], [`srv/models/studyoverview-service.cds`], [12], [Datei im Explorer öffnen],
    [1b], [`srv/models/studyoverview-service.cds`], [12], [Entity-Definition navigieren],
    [1c], [`srv/models/studyoverview-service.cds`], [--], [Zurück zur vorherigen Datei],
    [2a], [`db/models/...`], [--], [Ordner im Explorer öffnen],
    [2b], [`db/models/...`], [--], [Suche nach zugrunde liegender Entity],
    [2c], [`db/models/...`], [--], [Zurück zur vorherigen Datei],
    [3a], [`srv/impl/studyoverview-service.js`], [--], [Datei im Explorer öffnen],
    [3b], [`srv/impl/studyoverview-service.js`], [--], [Suche nach Handler-Logik],
    [3c], [`srv/impl/studyoverview-service.js`], [--], [Zurück zur vorherigen Datei],
  )

  #v(1em)

  #text(weight: "bold", size: 10pt)[Mit Extension]
  #v(0.3em)
  #table(
    columns: (auto, 2fr, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, left),
    stroke: 0.5pt + black,
    [*\#*], [*Aktion*], [*Ergebnis*],
    [1], [Suchfeld: "StudyOverviewFilterBar"], [Tree filtert auf Entity],
    [2], [Klick: StudyOverviewFilterBar], [Datei öffnet sich an Zeile 12],
  )
]

#pagebreak()

#heading(level: 3, numbering: none, outlined: false)[Szenario 3: Exponierte Entities identifizieren]

*Aufgabe:* Ein Entwickler soll prüfen, welche Entities über die API exponiert sind, um Authorization-Regeln zu verstehen oder anzupassen.

#heading(level: 3, numbering: none, outlined: false)[xtravels (TravelService)]

#figure(
  supplement: [Tabelle],
  caption: [Navigationsablauf "Exponierte Entities identifizieren" (xtravels) – Vergleich],
)[
  #set text(size: 9pt)

  #text(weight: "bold", size: 10pt)[Ohne Extension]
  #v(0.3em)
  #table(
    columns: (auto, 1.5fr, auto, 2fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Zweck*],
    [1a], [Projektweite Suche], [--], [Suche nach `@restrict` starten],
    [1b], [Projektweite Suche], [--], [Ergebnisliste durchsehen],
    [1c], [Projektweite Suche], [--], [Zurück zur vorherigen Datei],
    [2a], [`srv/travel-access-control.cds`], [3--8], [Datei im Explorer öffnen],
    [2b], [`srv/travel-access-control.cds`], [3--8], [`@restrict`-Annotation navigieren],
    [2c], [`srv/travel-access-control.cds`], [--], [Zurück zur vorherigen Datei],
    [3a], [`srv/travel-service.cds`], [7--20], [Datei im Explorer öffnen],
    [3b], [`srv/travel-service.cds`], [7--20], [Betroffene Entities navigieren],
    [3c], [`srv/travel-service.cds`], [--], [Zurück zur vorherigen Datei],
  )

  #v(1em)

  #text(weight: "bold", size: 10pt)[Mit Extension]
  #v(0.3em)
  #table(
    columns: (auto, 2fr, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, left),
    stroke: 0.5pt + black,
    [*\#*], [*Aktion*], [*Ergebnis*],
    [1], [Klick: TravelService → Entities], [Exponierte Entities sichtbar],
    [2], [Vergleich mit Domain Model], [Trennung Service vs. Domain erkennbar],
  )
]

#heading(level: 3, numbering: none, outlined: false)[bookshop (CatalogService)]

#figure(
  supplement: [Tabelle],
  caption: [Navigationsablauf "Exponierte Entities identifizieren" (bookshop) – Vergleich],
)[
  #set text(size: 9pt)

  #text(weight: "bold", size: 10pt)[Ohne Extension]
  #v(0.3em)
  #table(
    columns: (auto, 1.5fr, auto, 2fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Zweck*],
    [1a], [`srv/cat-service.cds`], [6--16], [Datei im Explorer öffnen],
    [1b], [`srv/cat-service.cds`], [6--16], [Exponierte Entities navigieren],
    [1c], [`srv/cat-service.cds`], [--], [Zurück zur vorherigen Datei],
    [2a], [`db/schema.cds`], [4--29], [Datei im Explorer öffnen],
    [2b], [`db/schema.cds`], [4--29], [Domain-Model zum Vergleich navigieren],
    [2c], [`db/schema.cds`], [--], [Zurück zur vorherigen Datei],
  )

  #v(1em)

  #text(weight: "bold", size: 10pt)[Mit Extension]
  #v(0.3em)
  #table(
    columns: (auto, 2fr, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, left),
    stroke: 0.5pt + black,
    [*\#*], [*Aktion*], [*Ergebnis*],
    [1], [Klick: CatalogService → Entities], [ListOfBooks und Books sichtbar],
  )
]

#heading(level: 3, numbering: none, outlined: false)[ctsm-develop (StudyOverviewService)]

#figure(
  supplement: [Tabelle],
  caption: [Navigationsablauf "Exponierte Entities identifizieren" (ctsm-develop) – Vergleich],
)[
  #set text(size: 9pt)

  #text(weight: "bold", size: 10pt)[Ohne Extension]
  #v(0.3em)
  #table(
    columns: (auto, 1.5fr, auto, 2fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Zweck*],
    [1a], [`srv/models/studyoverview-service.cds`], [11--186], [Datei im Explorer öffnen],
    [1b], [`srv/models/studyoverview-service.cds`], [11--186], [19 exponierte Entities navigieren],
    [1c], [`srv/models/studyoverview-service.cds`], [--], [Zurück zur vorherigen Datei],
    [2a], [`db/models/...`], [--], [Ordner im Explorer öffnen],
    [2b], [`db/models/...`], [--], [Domain-Model in verteilten Ordnern suchen],
    [2c], [`db/models/...`], [--], [Zurück zur vorherigen Datei],
    [3a], [Manuelle Analyse], [--], [Service vs. Domain manuell vergleichen],
    [3b], [Manuelle Analyse], [--], [Zuordnung dokumentieren],
    [3c], [Manuelle Analyse], [--], [Zurück zur Ausgangsdatei],
  )

  #v(1em)

  #text(weight: "bold", size: 10pt)[Mit Extension]
  #v(0.3em)
  #table(
    columns: (auto, 2fr, 2.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (center, left, left),
    stroke: 0.5pt + black,
    [*\#*], [*Aktion*], [*Ergebnis*],
    [1], [Klick: StudyOverviewService → Entities], [19 exponierte Entities auf einen Blick],
  )
]

#muchpdf(read("../assets/Formular Hilfsmittelangabe KI_V5.pdf", encoding: none))
