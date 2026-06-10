#import "../vendor/supercharged-dhbw/lib.typ": *
#import "@preview/treet:1.0.0": *
#import "@preview/tdtr:0.5.2": *
#import "@preview/dtree:0.1.0": dtree
#import "@preview/lilaq:0.5.0" as lq



= Problem- und Anforderungsanalyse <anforderungsanalyse>
Dieses Kapitel bildet die ersten beiden Phasen des #gls("DSR")-Prozesses nach Peffers et al. @Peffers_et_al_2008_DSRM. Die erste Phase (Problemidentifikation und Motivation) identifiziert und konkretisiert das Navigationsproblem in #gls("SAP CAP")-Projekten. Die zweite Phase (Zieldefinition) definiert Designziele und Anforderungen an die zu entwickelnde #gls("VS Code")-#gls("Extension"). Zunächst wird die strukturelle Organisation typischer #gls("CAP")-Repositories analysiert und die Verteilung servicebezogener Artefakte untersucht. Darauf aufbauend werden navigationsbezogene Herausforderungen abgeleitet, aus denen Designziele sowie funktionale und nicht-funktionale Anforderungen formuliert werden. Abschließend wird die Arbeit inhaltlich abgegrenzt.

== Problemkontext und Analyse von CAP-Repositories

Die folgenden Abschnitte analysieren die strukturellen Charakteristika von #gls("CAP")-Projekten und identifizieren daraus resultierende Navigationsherausforderungen. Zunächst wird die standardisierte Projektstruktur untersucht, anschließend die Verteilung servicebezogener Artefakte analysiert.

#pagebreak()

=== Typische Struktur von CAP-Projekten
#gls("SAP CAP") gibt eine strenge Projektstruktur vor, die das Prinzip der #gls("Separation of Concerns") umsetzt und damit die Wartbarkeit skalierender Projekte unterstützt #cite(<cap-bookshop-soc>, supplement: [Sec. Separation of Concerns]). Ein typisches #gls("CAP")-Projekt folgt der in #ref(<bookshop_file_structure>) dargestellten Struktur.

#figure(
  supplement: [Abbildung],
  caption: [Exemplarische Struktur eines SAP CAP-Projekts (vereinfacht) #cite(<bookshop>).],
)[
  #align(left)[
    #dtree(```text
    example-cap-project
     db
      schema.cds
      data
       seed.csv
     srv
      catalog-service.cds
      catalog-service.js
      handlers
       validation.js
      auth
       roles.cds
     app
      fiori-app
       manifest.json
     test
      catalog-service.test.js
     config
      cds.env
     package.json
    ```)]
]<bookshop_file_structure>


#heading(outlined: false, numbering: none, level: 4)[example-cap-project/]
Das Rootverzeichnis bildet die Basis des Projekts und bündelt alle fachlichen, technischen und konfigurativen Artefakte nach dem Prinzip der Separation of Concerns.

#heading(outlined: false, numbering: none, level: 4)[db/]
Dieses Verzeichnis enthält das fachliche Domänenmodell. Hier werden Entities und ihre Beziehungen in #gls("CDS") definiert, die die Persistenz- und Datenstrukturebene repräsentieren.

#heading(outlined: false, numbering: none, level: 4)[srv/]
Dieses Verzeichnis beinhaltet Service-Definitionen und Geschäftslogik. Der Service exponiert ausgewählte Teile des Domänenmodells und verknüpft deklarative Modellierung mit imperativer Implementierung.

#heading(outlined: false, numbering: none, level: 4)[app/]
Dieses Verzeichnis enthält optionale Frontend-Anwendungen, die die definierten Services konsumieren und die Präsentationsebene repräsentieren.

#heading(outlined: false, numbering: none, level: 4)[test/]
Dieses Verzeichnis beinhaltet Testfälle zur Validierung der Service-Logik und unterstützt damit Qualitätssicherung und Wartbarkeit.

#heading(outlined: false, numbering: none, level: 4)[config/]
Dieses Verzeichnis enthält umgebungsspezifische Konfigurationen zur Steuerung von Laufzeit- und Deployment-Parametern.

#heading(outlined: false, numbering: none, level: 4)[package.json]
Diese Datei definiert Projektmetadaten, Abhängigkeiten sowie Skripte für Build, Start und Tests.

#pagebreak()

=== Verteilung servicebezogener Artefakte
Ein #gls("CAP")-Service besteht nicht aus einem einzelnen Artefakt, sondern setzt sich aus mehreren funktionalen Bereichen zusammen, die unterschiedlichen Verantwortlichkeiten zugeordnet sind. Diese Fragmentierung erfolgt entlang technischer und fachlicher Concerns, wobei die Zuordnung zwischen den Artefakten über das Projekt verteilt ist.

#let model-color = rgb("#1f4e79")
#let service-color = rgb("#1f7a4e")
#let impl-color = rgb("#b35a00")
#let security-color = rgb("#6a3d9a")

#figure(
  supplement: [Abbildung],
  caption: [Konzeptionelle Fragmentierung eines CAP-Services (vereinfacht).],
)[
  #tidy-tree-graph(
    draw-node: (
      (stroke: none, shape: circle),
      tidy-tree-draws.absolute-draw-node.with(unit: 10.5em)
    ),
    draw-edge: (marks: "-"),
  )[
    - #text(size: 14pt)[CAP-Service]
      - #text(size: 12pt, fill: model-color)[Modeling (CDS)] #node-attr(rotate: -135deg)
      - #text(size: 12pt, fill: service-color)[API-Schnittstelle] #node-attr(rotate: -45deg)
      - #text(size: 12pt, fill: impl-color)[Implementierung] #node-attr(rotate: 45deg)
      - #text(size: 12pt, fill: security-color)[Security] #node-attr(rotate: 135deg)
  ]
]<service_conceptualization>

#ref(<service_conceptualization>) verdeutlicht, dass ein #gls("CAP")-Service nicht als monolithisches Artefakt vorliegt, sondern sich über mehrere konzeptionelle Ebenen erstreckt. Modell- und Service-Definition sind konzeptionell getrennt, wobei die Service-Schnittstelle nicht zwingend das vollständige Domänenmodell abbildet. Das Laufzeitverhalten ist nicht im Modell selbst definiert, sondern in separaten Implementierungen ausgelagert. Sicherheitsrelevante Regeln werden als Annotationen außerhalb der Kernlogik verortet. Dadurch sind fachliche und technische Aspekte strukturell entkoppelt #cite(<cap-focus-on-domain>, supplement: [Sec. Focus on Domain]).

#figure(
  supplement: [Tabelle],
  caption: [Zentrale Artefakte eines CAP-Services (basierend auf #cite(<cap-domain>, supplement: [Sec. Domain Modeling]); Authorization Annotations: #cite(<cap-security-authorization>, supplement: [Sec. Role-Based Access Control]))],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, auto, 1.4fr),
    inset: (x: 10pt, y: 6pt),
    align: (left, left, left),
    stroke: 0.3pt + black,
    [*Typ*], [*Ebene*], [*Beispiele*],
    [Entity], [Modeling (CDS)], [Books, Authors],
    [Type], [Modeling (CDS)], [UUID, String, Decimal],
    [Association], [Modeling (CDS)], [to Author, to Items],
    [Aspect], [Modeling (CDS)], [Reusable model extensions],
    [Service], [API-Schnittstelle], [CatalogService],
    [Projection], [API-Schnittstelle], [Books as projection on …],
    [Action / Function], [API-Schnittstelle], [submitOrder(), topSelling()],
    [Event Handler], [Implementierung], [before / on / after],
    [Authorization Annotations], [Security], [\@restrict, \@requires],
  )
]<service_artifacts_table>

#ref(<service_artifacts_table>) konkretisiert die in der #ref(<service_conceptualization>) dargestellten Ebenen durch die zentralen Artefakt-Typen des #gls("CAP")-Modells. Ein vollständiges Serviceverständnis erfordert die Betrachtung mehrerer Artefakt-Kategorien, deren Beziehungen über Referenzen hergestellt werden. Eine zentrale, aggregierte Repräsentation eines Services existiert nicht auf Artefaktebene. Änderungen an einem Service können daher mehrere Ebenen gleichzeitig betreffen, da sich die Service-Identität erst aus dem Zusammenspiel aller Ebenen ergibt. Diese Architektur folgt den Prinzipien von #gls("Domain-Driven Design") #cite(<Ozkan_et_al_2000_DDD>, supplement: [Sec. 1.1]) und #gls("Separation of Concerns") #cite(<cap-domain>, supplement: [Sec. Separation of Concerns]) #cite(<cap-focus-on-domain>, supplement: [Sec. Focus on Domain]).

== Identifizierte Herausforderungen bei der Navigation
Aus der analysierten Projektstruktur und Artefaktverteilung ergeben sich mehrere Herausforderungen für die Navigation in #gls("CAP")-Projekten. Die folgenden Abschnitte beschreiben diese Herausforderungen und quantifizieren deren Auswirkungen anhand repräsentativer Entwicklungsszenarien.

=== Verteilte Artefakte und implizite Abhängigkeiten
Ein #gls("CAP")-Service erstreckt sich über mehrere konzeptionelle Ebenen, wobei Modell, Schnittstelle, Implementierung und Sicherheitsregeln physisch getrennt sind. Die Beziehungen zwischen diesen Artefakten sind nicht visuell auf einen Blick erkennbar. Projections referenzieren Entities, Event Handlers referenzieren Service-Operationen, und Sicherheitsannotationen beeinflussen das Verhalten ohne zentrale Sichtbarkeit. Kein einzelnes Artefakt enthält die vollständige Service-Definition.

Diese Problematik entspricht dem von Tarr et al. beschriebenen Phänomen der "Tyrannei der dominanten Dekomposition" #cite(<Tarr_et_al_2000_MDSC>, supplement: [p. 809]): Software wird typischerweise entlang einer primären Dimension strukturiert. Im Fall von #gls("CAP")-Projekten nach Ordnern und Dateien entsprechend technischer Verantwortlichkeiten. Andere wichtige Dimensionen, wie die servicezentrierte fachliche Sicht, werden dadurch über das Projekt verteilt und sind nicht mehr unmittelbar sichtbar #cite(<cap-domain>).

=== Erhöhter Navigationsaufwand und fehlende Service-Übersicht
Mit zunehmender Weiterentwicklung eines Softwaresystems steigt dessen strukturelle Komplexität. Lehman beschreibt dieses Phänomen im Gesetz der zunehmenden Komplexität, wonach die Komplexität eines Systems mit fortlaufenden Änderungen wächst, sofern keine Maßnahmen zur Reduktion dieser Komplexität ergriffen werden #cite(<Lehman_1980_Software_Evolution>, supplement: [p. 1068]). Zur Analyse eines Services sind mehrere Dateiwechsel erforderlich, etwa zwischen Datenbankmodell, Implementierung und Sicherheitsregeln. Da keine aggregierte Sicht auf alle servicebezogenen Artefakte existiert, muss die Struktur eines Services rekonstruiert werden. Diese Kontextwechsel erhöhen die #gls("Kognitive Belastung"), da Menschen nur über eine begrenzte kognitive Verarbeitungskapazität verfügen und mehrere Informationen gleichzeitig berücksichtigen müssen #cite(<Sweller_1988_Cognitive_Load>, supplement: [p. 261]).

=== Quantifizierung anhand konkreter Szenarien

Die beschriebenen Navigationsprobleme lassen sich anhand typischer Entwicklungsaufgaben im Bookshop-Beispielprojekt #cite(<bookshop>) konkretisieren. Vier repräsentative Szenarien wurden durch manuelle Analyse untersucht, um den erforderlichen Navigationsaufwand zu quantifizieren.

Das Szenario mit dem höchsten Navigationsaufwand ist "Service verstehen". Es erfordert zehn Navigationsschritte über drei Dateien und zeigt die Herausforderung exemplarisch. Ein Entwickler soll sich einen Überblick über den CatalogService verschaffen und dessen Struktur nachvollziehen. #ref(<nav_service_verstehen>) dokumentiert die erforderlichen Navigationsschritte. Der Entwickler muss zunächst in der Service-Definition Import-Statement, Namespace, Projections und Actions analysieren. Da Projections auf das Datenmodell verweisen, ist ein Wechsel zur Datenbank-Schema-Datei erforderlich, wo die Entity `Books` sowie die referenzierten Entities `Authors` und `Genres` verstanden werden müssen. Abschließend muss die Handler-Implementierung mit Event Handlers analysiert werden. Dieser Workflow erfordert insgesamt drei Dateien und zehn separate Navigationsschritte zwischen verschiedenen Artefakten.

#figure(
  supplement: [Tabelle],
  caption: [Szenario "Service verstehen" im Bookshop-Projekt],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, 1fr, auto, 2fr),
    inset: (x: 10pt, y: 6pt),
    align: (center, left, center, left),
    stroke: 0.5pt + black,
    [*\#*], [*Datei*], [*Zeile*], [*Aktion*],
    [1], [`srv/cat-service.cds`], [1], [Import-Statement und Namespace identifizieren],
    [2], [`srv/cat-service.cds`], [3], [Service-Definition `CatalogService` analysieren],
    [3], [`srv/cat-service.cds`], [6--9], [Projection `ListOfBooks` verstehen],
    [4], [`srv/cat-service.cds`], [12--16], [Projection `Books` verstehen],
    [5], [`srv/cat-service.cds`], [19], [Action `submitOrder` identifizieren],
    [6], [`db/schema.cds`], [4--13], [Entity `Books` mit Associations verstehen],
    [7], [`db/schema.cds`], [15--23], [Referenzierte Entity `Authors` analysieren],
    [8], [`db/schema.cds`], [26--29], [Referenzierte Entity `Genres` analysieren],
    [9], [`srv/cat-service.js`], [3--6], [Handler-Klasse und Entity-Referenzen],
    [10], [`srv/cat-service.js`], [9--23], [Event Handlers (`after`, `on`) analysieren],
  )
]<nav_service_verstehen>

Die weiteren Szenarien "Feld hinzufügen", "Auth anpassen" und "Handler debuggen" zeigen vergleichbare Navigationsmuster und sind im #link(<bookshop-navigationsschritte>)[#text(fill: black)[Anhang]] detailliert dokumentiert. #ref(<navigation_complexity_chart>) fasst die Navigationskomplexität aller vier Szenarien zusammen.

#figure(
  supplement: [Abbildung],
  caption: [Navigationskomplexität typischer Entwicklungsaufgaben im Bookshop-Projekt],
  lq.diagram(
    width: 12cm,
    height: 6cm,
    legend: (position: right),
    yaxis: (
      subticks: none,
      ticks: (
        (0, "Handler debuggen"),
        (1, "Auth anpassen"),
        (2, "Feld hinzufügen"),
        (3, "Service verstehen"),
      ),
    ),
    xaxis: (lim: (0, 12), subticks: none),
    xlabel: [Anzahl],
    // Navigationsschritte (grün)
    lq.hbar(
      (4, 4, 6, 10),
      (0, 1, 2, 3),
      width: 0.35,
      offset: 0.22,
      fill: rgb("#10b981"),
      label: [Navigationsschritte],
    ),
    // Dateien (blau)
    lq.hbar(
      (3, 3, 6, 3),
      (0, 1, 2, 3),
      width: 0.35,
      offset: -0.22,
      fill: rgb("#3b82f6"),
      label: [Dateien],
    ),
    // Labels Dateien
    lq.place(3, -0.22, align: left, pad(left: 0.3em)[3]),
    lq.place(3, 0.78, align: left, pad(left: 0.3em)[3]),
    lq.place(6, 1.78, align: left, pad(left: 0.3em)[6]),
    lq.place(3, 2.78, align: left, pad(left: 0.3em)[3]),
    // Labels Navigationsschritte
    lq.place(4, 0.22, align: left, pad(left: 0.3em)[4]),
    lq.place(4, 1.22, align: left, pad(left: 0.3em)[4]),
    lq.place(6, 2.22, align: left, pad(left: 0.3em)[6]),
    lq.place(10, 3.22, align: left, pad(left: 0.3em)[10]),
  )
)<navigation_complexity_chart>

=== Bestehende Ansätze zur Navigation in Entwicklungsumgebungen

Moderne Entwicklungsumgebungen bieten verschiedene Navigationsmechanismen. #gls("VS Code") stellt grundlegende Funktionen wie die #gls("Outline-Ansicht") #cite(<vscode-outline>, supplement: [Sec. Outline View]) und #gls("Go-to-Definition") #cite(<vscode-goto>, supplement: [Sec. Go to Definition]) bereit. Die SAP #gls("CDS") Language Support #gls("Extension") #cite(<cds-lsp>) erweitert dies um #gls("CDS")-spezifische Features wie Syntaxhervorhebung und Autovervollständigung.

Trotz dieser Funktionen zeigt die Forschung grundlegende Probleme. Ko et al. identifizieren, dass Entwickler häufig Schwierigkeiten haben, relevante Informationen über Code, Design und Programmausführung aus verschiedenen Artefakten zusammenzuführen #cite(<Ko_et_al_2007_Information_Needs>, supplement: [p. 347]). LaToza et al. zeigen zudem, dass Entwickler stark auf implizites Code-Wissen angewiesen sind, welches nicht in Werkzeugen oder Dokumentation externalisiert ist #cite(<LaToza_et_al_2006_Mental_Models>, supplement: [p. 492]).

Die zentrale Limitation besteht darin, dass diese Werkzeuge überwiegend datei- und symbolzentriert operieren. Eine servicezentrierte Aggregation über mehrere Dateien und Ebenen hinweg wird nicht unterstützt.

== Ableitung der Designziele
Aus den identifizierten Navigationsproblemen werden nun zentrale Designziele abgeleitet. Diese beschreiben lösungsneutral, welche Eigenschaften eine geeignete Lösung aufweisen muss. Die Designziele bilden die Grundlage für die anschließende Definition funktionaler und nicht-funktionaler Anforderungen.

#heading(outlined: false, numbering: none, level: 3)[Aggregierte Service-Sicht]
Alle Artefakte eines Services müssen gebündelt dargestellt werden. Die Lösung muss eine einheitliche Einstiegsperspektive auf einen Service bieten, in der Modell, Schnittstelle, Implementierung und Sicherheitsaspekte gemeinsam sichtbar sind. Die Service-Identität muss ohne manuelle Rekonstruktion erfassbar sein.

#heading(outlined: false, numbering: none, level: 3)[Reduktion von Navigations- und Kontextwechseln]
Die Anzahl notwendiger Dateiwechsel muss minimiert werden. Deklarative und imperative Artefakte müssen kontextnah zugänglich sein. Relevante Artefakte müssen schnell auffindbar sein. Kognitive Kontextwechsel zwischen den Ebenen müssen reduziert werden.

#heading(outlined: false, numbering: none, level: 3)[Explizite Darstellung von Abhängigkeiten]
Beziehungen zwischen allen Arten von Entitäten müssen sichtbar gemacht werden. Verknüpfungen zwischen Service-Definition und Implementierung müssen nachvollziehbar sein. Sicherheitsrelevante Annotationen müssen eindeutig zuordbar sein. Referenzen müssen transparent werden.

#heading(outlined: false, numbering: none, level: 3)[Servicezentrierte Navigation]
Die Navigation muss sich an den fachlichen Services orientieren. Die technische Ordnerstruktur darf nicht primärer Navigationsanker sein. Der Service muss als logische Einheit im Mittelpunkt stehen.

== Funktionale Anforderungen
Aus den zuvor formulierten Designzielen lassen sich konkrete funktionale Anforderungen an die zu entwickelnde #gls("VS Code")-#gls("Extension") ableiten. Während die Designziele die gewünschten Eigenschaften der Lösung auf konzeptioneller Ebene beschreiben, spezifizieren die folgenden Anforderungen die Funktionen, die das Artefakt zur Unterstützung der Navigation in #gls("CAP")-Projekten bereitstellen muss.

#heading(outlined: false, numbering: none, level: 4)[FA1 Identifikation von CAP-Services]
Die #gls("Extension") muss #gls("CAP")-Services innerhalb eines Projekts automatisch identifizieren und alle Services anzeigen.

#heading(outlined: false, numbering: none, level: 4)[FA2 Aggregierte Serviceübersicht]
Die #gls("Extension") muss eine aggregierte Darstellung aller zu einem Service gehörenden Artefakte bereitstellen.

#heading(outlined: false, numbering: none, level: 4)[FA3 Navigation zu Artefakten]
Die #gls("Extension") muss eine direkte Navigation von der Serviceübersicht zu den entsprechenden Artefakten im Quellcode ermöglichen.

#heading(outlined: false, numbering: none, level: 4)[FA4 Darstellung von Artefaktbeziehungen]
Die #gls("Extension") muss Beziehungen und Hierarchien zwischen servicebezogenen Artefakten sichtbar machen.

== Nicht-funktionale Anforderungen
Neben den funktionalen Anforderungen ergeben sich aus dem Nutzungskontext innerhalb der Entwicklungsumgebung zusätzliche nicht-funktionale Anforderungen. Diese beschreiben qualitative Eigenschaften und Rahmenbedingungen, die bei der Umsetzung der #gls("Extension") berücksichtigt werden müssen.

#heading(outlined: false, numbering: none, level: 4)[NFA1 Integration in Visual Studio Code]
Die Lösung muss als #gls("Extension") für die Entwicklungsumgebung #gls("VS Code") implementiert werden und sich in deren Erweiterungsmechanismus #cite(<extension>) integrieren.

#heading(outlined: false, numbering: none, level: 4)[NFA2 Kompatibilität mit CAP-Projektstrukturen]
Die #gls("Extension") muss mit der typischen Struktur von #gls("SAP CAP")-Projekten kompatibel sein und relevante Artefakte in den vorgesehenen Verzeichnissen erkennen können.

#heading(outlined: false, numbering: none, level: 4)[NFA3 Performante Analyse von Projekten]
Die #gls("Extension") muss #gls("CAP")-Projekte effizient analysieren. Das initiale Laden des Modells beim Projektöffnen muss innerhalb von 10 Sekunden abgeschlossen sein, um die Aufmerksamkeit des Entwicklers zu halten. Alle nachfolgenden Navigationsoperationen müssen in unter 1 Sekunde erfolgen, um den Gedankenfluss nicht zu unterbrechen #cite(<Nielsen_1993_Usability_Engineering>, supplement: [p. 135]).

#heading(outlined: false, numbering: none, level: 4)[NFA4 Aktualität der Artefaktübersicht]
Änderungen an relevanten Projektartefakten müssen automatisch erkannt werden, sodass die dargestellte Serviceübersicht den aktuellen Projektzustand widerspiegelt.

== Abgrenzung der Arbeit
Die vorliegende Arbeit fokussiert auf die Unterstützung der Navigation in #gls("CAP")-Projekten durch eine #gls("VS Code")-#gls("Extension"). Daraus ergeben sich bewusste Einschränkungen des Untersuchungs- und Lösungsumfangs.

Ziel der #gls("Extension") ist die Verbesserung der Navigation zwischen servicebezogenen Artefakten. Funktionen zur automatischen Codegenerierung oder Refaktorierung sind explizit nicht Bestandteil der Lösung.

Die Evaluation erfolgt anhand ausgewählter #gls("CAP")-Projekte. Eine umfassende Nutzerstudie mit #gls("CAP")-Entwicklern ist nicht Bestandteil der Arbeit.