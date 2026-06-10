#import "../vendor/supercharged-dhbw/lib.typ": *
#import "@preview/aa-draw:0.1.0": aasvg
#import "@preview/dtree:0.1.0": dtree

= Implementierung des Prototyps <implementierung>
Im folgenden Kapitel wird ein #gls("Prototyp") basierend auf der #gls("Language Server")-basierten Strategie implementiert. Der Fokus liegt auf einer aggregierten Service-Übersicht zur Navigation sowie einer Suchfunktion mit Filteroptionen.

== Architekturkonzept und Designentscheidungen

Die #gls("Extension") folgt einer Mehrschichtigen Architektur zur Trennung von Datenabfrage, Business Logic und #gls("UI")-Präsentation #cite(<Clements_et_al_2000_Layered_Architecture>, supplement: [Sec. 2]). Die folgenden Abschnitte beschreiben den strukturellen Aufbau und zentrale Designentscheidungen.

=== Architektur

@architektur_diagramm zeigt die Komponentenstruktur. Das Modul `extension.ts` orchestriert vier Hauptkomponenten. Der `cdsClient` beschafft Daten vom #gls("CDS") #gls("Language Server"), der `Controller` verwaltet Zustand und koordiniert die Business Logic, der `TreeProvider` rendert die #gls("UI"), und der `SearchProvider` stellt die Suchoberfläche bereit.

Der Domain Layer (`treeBuilder`, `search`, `filter`) enthält die Business Logic für Datentransformation und Filterung. Diese Schicht hat keine #gls("VS Code") Abhängigkeiten und ist isoliert testbar. Der Datenfluss verläuft vom #gls("Language Server") über den Controller (mit Domain-Modulen) zum TreeProvider. User Input fließt vom SearchProvider zurück zum Controller.

#figure(
  supplement: [Abbildung],
  caption: [Komponentenstruktur und Datenfluss der VS Code Extension],
  aasvg(
"
+---------------------------------------------------------------------------------+
|                              VS Code Extension Host                             |
+----------------------------------------+----------------------------------------+
                                         |
                                         |
+----------------------------------------+----------------------------------------+
|                                        v                                        |
|                            +-----------------------+                            |
|                            |     extension.ts      |                            |
|                            |      (Bootstrap)      |                            |
|                            +-----------+-----------+                            |
|                                        |                                        |
|          +-------------------+---------+---------+-------------------+          |
|          |                   |                   |                   |          |
|          v                   v                   v                   v          |
|  +---------------+   +---------------+   +---------------+   +---------------+  |
|  |   cdsClient   |   |  TreeProvider |   |   Controller  |   |SearchProvider |  |
|  | (Data Source) |   |     (View)    |   |    (State)    |   | (View/Input)  |  |
|  +-------+-------+   +-------+-------+   +-------+-------+   +-------+-------+  |
|          |                   |                   |                   |          |
|          |                   |                   v                   v          |
|          |                   |           +--------------+    +---------------+  |
|          |                   |           |   domain/    |    |   Webview     |  |
|          |                   |           | • treeBuilder|    | (HTML/JS UI)  |  |
|          |                   |           | • search     |    +---------------+  |
|          |                   |           | • filter     |                       |
|          |                   |           +--------------+                       |
|          |                   |                                                  |
+----------+-------------------+--------------------------------------------------+
           |                   |
           v                   v
   +--------------+    +--------------+
   | CDS Language |    |    VS Code   |
   |    Server    |    | TreeView API |
   |   [EXTERN]   |    |   [EXTERN]   |
   +--------------+    +--------------+
"
)
)<architektur_diagramm>

=== Technologie-Stack

Die #gls("Extension") wurde in #gls("TypeScript") implementiert, was Typsicherheit zur Compile-Zeit und vollständige #gls("IDE")-Unterstützung bietet. Das Suchpanel wurde als Webview mit nativem #gls("HTML"), #gls("CSS") und #gls("JavaScript") realisiert, da #gls("VS Code")'s native #gls("UI")-Komponenten für die komplexen Anforderungen (Suchfeld, Filterchips, Optionen) zu limitiert sind. Die Webview sendet `SearchMessage`-Events (`queryChanged`, `submit`, `clear`) an die #gls("Extension"), die diese in `FilterSpec`-Objekte umwandelt und an den Controller weiterleitet. Auf Frontend-Frameworks wurde verzichtet, um Bundle-Overhead zu vermeiden. Der Build-Prozess wird über #gls("npm") @npm-docs gesteuert, die #gls("Extension") als #gls("VSIX")-Datei ausgeliefert.

== Integration mit CDS Language Server

Die #gls("Extension") nutzt den #gls("CDS") #gls("Language Server") als zentrale Datenquelle für Service-Strukturinformationen. Dieser Abschnitt beschreibt die Kommunikation über das #gls("LSP") und die Verarbeitung der empfangenen Symboldaten.

=== Kommunikation über Language Server Protocol

Die #gls("Extension") nutzt den `workspace/symbol` Request des #gls("LSP") als zentrale Datenquelle. Die Grundlagen des #gls("LSP") wurden in #ref(<grundlagen>) erläutert. Der Request akzeptiert einen optionalen Query-Parameter, mit dem das Ergebnis gefiltert und erweitert werden kann. Die #gls("Extension") verwendet die Query `/gax`, wobei jeder Buchstabe eine spezifische Option aktiviert. `g` inkludiert Abhängigkeiten aus `node_modules`, `a` inkludiert automatisch im Service bereitgestellte Entities und `x` kennzeichnet Explorer-Queries.

Das `x`-Flag wurde im Rahmen dieser Arbeit speziell für die #gls("Extension") entwickelt und vom #gls("Language Server")-Team der Abteilung implementiert @cds-lsp-release-9-9-0. Dieser Beitrag zum #gls("CDS") #gls("Language Server") ermöglicht die servicezentrierte Navigation überhaupt erst, da die Standard-#gls("LSP")-Response diese Kategorisierung nicht bereitstellt. Der #gls("Language Server") reichert die Response um essenzielle Metadaten an: die Kennzeichnung von Domain-Model-Entities, Flags für automatisch bereitgestellte Entities sowie Hierarchie-Informationen zur Unterscheidung von Service-Projections und Datenbank-Entities. Ohne diese Erweiterung müsste die #gls("Extension") auf die in #ref(<integrationsstrategien>) abgelehnte Repository-basierte Strategie zurückfallen. Die #gls("Extension") ist als internes SAP-Projekt verfügbar @vscode-cds-explorer.

=== Normalisierung der Symboldaten <normalisierung-symboldaten>

Die Response des `workspace/symbol` Requests liefert für jedes Symbol Metadaten im #gls("LSP")-Format. Die detaillierte Response-Struktur ist in Anhang A dokumentiert. Die #gls("Extension") normalisiert diese Rohdaten zu einem einheitlichen `Symbol` Interface, das die Felder `name`, `kind`, `containerName`, `fileUri`, `range` und `flags` enthält. Die numerischen Werte werden über Konstanten interpretiert, etwa Typ 5 wird zu ENTITY.

Das zentrale Merkmal dieser Response ist das `flags`-Feld, das nur durch das `x`-Flag in der `/gax` Query aktiviert wird. Dieses Flag wurde speziell für die #gls("Extension") entwickelt, um die Response um essenzielle Metadaten zur servicezentrierten Navigation anzureichern. Die Flags sind als Integer kodiert, wobei jedes Bit eine spezifische Information repräsentiert. Dies ermöglicht die effiziente Kombination mehrerer Eigenschaften in einem einzigen Zahlenwert. Die Flags kodieren Metadaten zur Kategorisierung von Symbolen, beispielsweise DOMAIN_MODEL für Entities im Datenbank-Schema, EXTERNAL_SERVICE für externe Services, AUTOEXPOSED_ENTITY für automatisch im Service bereitgestellte Entities sowie VIEW zur Unterscheidung von Projections und persistenten Entities. Darüber hinaus liefern die Flags weitere für die #gls("Extension") relevante Informationen wie ASSOCIATION und COMPOSITION zur Kennzeichnung von Beziehungstypen, ASPECT für wiederverwendbare Modellfragmente sowie EXTEND zur Identifikation erweiterter Definitionen. Die vollständige Flag-Spezifikation mit allen 22 definierten Flags ist in Anhang~B dokumentiert. Ohne diese Flags wäre eine Unterscheidung zwischen Domain-Entities und Service-Projections nicht möglich, da beide als `Typ=ENTITY` klassifiziert sind.

=== Erweiterung um zusätzliche LSP-Features

Die #gls("Extension") nutzt neben `workspace/symbol` weitere #gls("LSP")-Operationen für #gls("IDE")-Funktionen. Diese sind über das Context-Menü der TreeView-Items zugänglich und erweitern die Navigation um typische #gls("IDE")-Features wie Referenzsuche, Definition-Lookup und Implementation-Mapping.

Über Rechtsklick auf ein #gls("CDS")-Artefakt im Tree kann der User "Go to Definition" oder "Find References" ausführen. Diese Befehle delegieren an den #gls("CDS") #gls("Language Server") via `vscode.commands.executeCommand`. Find References öffnet die References-View von #gls("VS Code") mit allen Fundstellen des Symbols und ist besonders wertvoll bei Refactorings oder beim Verstehen von Abhängigkeiten zwischen Services.

Der "Go to Implementation"-Befehl findet Event Handler-Dateien (`.js`/`.ts`) für Services. #gls("CAP")-Services bestehen aus #gls("CDS")-Definitionen und optionalen Implementierungsdateien mit registrierten Event Handlers. Die #gls("Extension") sendet eine `textDocument/implementation` Request an den #gls("Language Server"), der die URIs der Handler-Dateien zurückgibt. Dieses Feature ist besonders nützlich, da Implementierungsdateien nicht durch Namenskonventionen auffindbar sind. Der #gls("Language Server") analysiert die `require`-Statements und registrierte Handler im Projekt, um die Zuordnung zwischen Service-Definition und Implementierung zu ermitteln.

=== Automatische Entdeckung von Implementierungsdateien

Wie in #ref(<anforderungsanalyse>) beschrieben, sind die Artefakte eines #gls("CAP")-Services über mehrere Dateien verteilt. Besonders die Zuordnung von Event-Handler-Implementierungen zu Services ist nicht trivial, da keine eindeutige Namenskonvention existiert. Ein Service `CatalogService` kann beispielsweise in `catalog-service.js`, `catalog.js` oder `CatalogService.ts` implementiert sein.

Die #gls("Extension") löst dieses Problem durch automatische Entdeckung via #gls("Language Server"). Beim Expandieren eines Service-Nodes im Tree fragt die #gls("Extension") den #gls("CDS") #gls("Language Server") nach zugehörigen Implementierungsdateien. Der #gls("Language Server") analysiert die Event-Handler-Registrierungen im Projekt und liefert alle relevanten Dateien zurück. Diese werden im "Files"-Ordner unter dem jeweiligen Service angezeigt. Die Ergebnisse werden gecacht, um die Performance zu optimieren.

Dieses Feature arbeitet lazy: Implementierungsdateien werden erst bei Bedarf geladen, wenn der User einen Service expandiert. Dies reduziert die initiale Ladezeit der #gls("Extension"), da nicht für alle Services sofort Implementation-Lookups durchgeführt werden müssen. Die asynchrone Natur der Implementierung stellt sicher, dass die #gls("UI") responsiv bleibt, auch wenn der #gls("Language Server") mehrere Sekunden für die Analyse benötigt.

// Literatur: Adapter Pattern, Data Transfer Objects

== Datenmodell und Baumaufbau

Die flache Liste von Symbolen aus dem #gls("Language Server") muss in eine hierarchische Baumstruktur transformiert werden, die in #gls("VS Code")'s TreeView dargestellt werden kann. Dieser Abschnitt beschreibt das zugrunde liegende Datenmodell und die gewählte Navigationsstruktur.

=== TreeNode-Datenmodell

Der #gls("Language Server") liefert Symbole als flache Liste, in der jedes Symbol unabhängig mit seinen Metadaten repräsentiert ist. Diese Repräsentation ist für die Analyse geeignet, aber nicht für eine hierarchische #gls("UI")-Darstellung. Die #gls("Extension") transformiert daher die Symbole in eine Baumstruktur aus `TreeNode`-Objekten, die zusammengehörige Artefakte aggregiert, hierarchische Beziehungen etabliert, und #gls("UI")-spezifische Informationen ergänzt.

#figure(
  kind: raw,
  supplement: [Quellcode],
  caption: [TreeNode Interface],
  box(
    fill: rgb("#1e1e1e"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #set text(font: "DejaVu Sans Mono", size: 9pt, fill: rgb("#d4d4d4"))
    #set align(left)
    #let key = rgb("#569CD6")
    #let typ = rgb("#4EC9B0")

    #text(fill: key)[export] #text(fill: key)[interface] #text(fill: typ)[TreeNode] \{\
    #h(1em)label: #text(fill: typ)[string];\
    #h(1em)children?: #text(fill: typ)[TreeNode]\[\];\
    #h(1em)nodeType?: #text(fill: typ)[NodeType];\
    #h(1em)fileUri?: #text(fill: typ)[string];\
    #h(1em)range?: #text(fill: typ)[Range];\
    #h(1em)serviceName?: #text(fill: typ)[string];\
    \}
  ]
)

Das `TreeNode`-Interface bildet die Grundlage der Baumdarstellung. Das Feld `nodeType` bestimmt die visuelle Repräsentation (Icons, Farben) und unterscheidet zwischen verschiedenen Artefakt-Typen wie Services, Entities, Actions oder Ordnern. Die Felder `fileUri` und `range` ermöglichen die Navigation zur Quellcode-Position, während `serviceName` servicebasierte Filterung unterstützt.

=== Aufbau der Navigationsstruktur

Die #gls("Extension") implementiert eine servicezentrierte Navigationsstruktur, die das in #ref(<anforderungsanalyse>) identifizierte Problem der verteilten Service-Artefakte adressiert. Die gewählte Struktur orientiert sich an der fachlichen Gliederung von #gls("CAP")-Projekten und trennt zwischen Service-spezifischen Artefakten und domänenübergreifenden Modellen.

#figure(
  supplement: [Abbildung],
  caption: [Navigationsstruktur der Extension @vscode-cds-explorer],
  image("../assets/images/exetsion_tree_view.png", width: 50%)
)<navigationsstruktur>

Der Services-Bereich bildet den Hauptbereich der Extension und unterteilt sich in *Outbound* und *Inbound* Services. Outbound-Services repräsentieren externe APIs oder Remote Services, während Inbound-Services die Kernlogik der Anwendung bereitstellen. Die Unterscheidung erfolgt anhand des EXTERNAL_SERVICE Flags, das in #ref(<normalisierung-symboldaten>) beschrieben wurde. Services mit diesem Flag werden als Outbound klassifiziert. Diese Unterscheidung ist für die Navigation relevant, da externe Services typischerweise nur konsumiert werden, während interne Services implementiert und erweitert werden.

Innerhalb eines Services erfolgt eine Kategorisierung nach Artefakt-Typen (z.B. Entities, Operations, Files). Die Aggregation der Struktur erfolgt über die hierarchische Information im `containerName`-Feld, wobei die Notation "TravelService.Travels.bookings" in die entsprechende Baum-Hierarchie überführt wird.

// Literatur: Tree Data Structures, Hierarchical Navigation, Information Architecture

== Navigation und Interaktion

Die Visualisierung erfolgt über #gls("VS Code")'s TreeView #gls("API") (siehe #ref(<grundlagen>)). Die #gls("Extension") transformiert die `TreeNode` Objekte in darstellbare Elemente und registriert Click-Handler für die Navigation zum Quellcode.

Ein Controller verwaltet den Zustand der Ansicht, wobei zwischen Tree-Modus (vollständiger Baum) und Filter-Modus (gefilterte Ansicht) unterschieden wird. Der Controller koordiniert die Interaktion zwischen TreeView und Suchfunktion.

Das Such- und Filtersystem kombiniert Textsuche mit strukturierter Filterung nach Artefakt-Typen. Spezielle Token wie `@entity` oder `@service` ermöglichen die gezielte Filterung, die mit Freitextsuche kombiniert werden kann (z.B. `@entity booking`).

Die Filterlogik implementiert einen zweistufigen rekursiven Algorithmus. Im ersten Durchlauf prüft die #gls("Extension") für jeden Node, ob er selbst die Filterkriterien erfüllt oder ob seine Kinder Treffer enthalten. Im zweiten Durchlauf werden zusätzlich alle Geschwister-Nodes eines Treffers angezeigt (Sibling-Context-Preservation). Dies verhindert, dass der User beim Filtern die Orientierung verliert, da nicht-passende Geschwister-Nodes als Kontext erhalten bleiben. Passende Nodes werden in einem `autoExpandedIds`-Set gespeichert, damit der TreeProvider sie automatisch aufklappt. Übergeordnete Nodes bleiben sichtbar, solange ihre Kinder Treffer enthalten. Treffer werden im TreeView hervorgehoben.

=== State Management und Controller-Pattern

Die #gls("Extension") implementiert das Controller-Pattern zur Zentralisierung der Zustandsverwaltung. Der Controller hält den `ViewState` (Such-Query, Anzeigemodus, expandierte Nodes) und koordiniert die Interaktion zwischen TreeProvider und SearchProvider. Diese Entkopplung ermöglicht es, State-Logik unabhängig von der #gls("VS Code") #gls("API") zu testen.

Das `ViewState`-Objekt unterscheidet zwischen zwei Modi: Im Tree-Modus zeigt die #gls("Extension") den vollständigen Baum, wobei ein `userExpandedIds`-Set die manuell expandierten Nodes trackt. Im Filter-Modus wird nur der gefilterte Baum angezeigt, wobei ein `searchExpandedIds`-Set die automatisch expandierten passenden Nodes enthält. Diese Trennung verhindert, dass automatische Expansion beim Filtern die User-Präferenzen im Tree-Modus überschreibt.

Der Controller implementiert das Observer-Pattern via Callbacks. Bei State-Änderungen (z.B. `setFilterSpec`, `setStrategy`) notifiziert er den TreeProvider via `onStateChange`-Callback, der daraufhin die #gls("UI") refreshed. Der TreeProvider wiederum informiert den Controller via `onDidChangeData`-Callback, wenn neue Symboldaten vom #gls("Language Server") geladen wurden. Diese bidirektionale Kommunikation stellt sicher, dass #gls("UI") und State stets synchron bleiben.

== Fehlerbehandlung und Benutzer-Feedback

Die #gls("Extension") implementiert robuste Fehlerbehandlung für verschiedene Fehlerszenarien bei der #gls("LSP")-Kommunikation. Eine eigene Error-Klasse `CdsClientError` mit den Feldern `code`, `message` und `cause` ermöglicht differenzierte Reaktionen auf unterschiedliche Fehlerfälle. @error_handling_table gibt eine Übersicht aller Error-Typen.

#figure(
  supplement: [Tabelle],
  caption: [Error-Typen und deren Behandlung in der Extension],
)[
  #set text(size: 8pt)
  #table(
    columns: (auto, 2fr, 1.8fr, 1.8fr),
    inset: (x: 6pt, y: 5pt),
    align: (left, left, left, left),
    stroke: 0.3pt + black,
    [*Error-Typ*], [*Ursache*], [*Anzeige im Tree*], [*Benutzeraktion*],

    [Installation Error], [CDS Extension ist nicht installiert], [Error-Node mit Installations-Link], [Installation über VS Code Marketplace],

    [Version Error], [CDS Extension Version < 9.9.0], [Error-Node mit Versionshinweis], [Extension aktualisieren],

    [LSP Request Error], [workspace/symbol Request fehlgeschlagen], [Error-Node mit Fehlermeldung als Tooltip], ["Show Output" für vollständigen Log],

    [Language Server Inactive], [Language Server ist nicht aktiviert oder bereit], [Error-Node mit Hinweis auf Aktivierung], [Warten oder VS Code neu starten],

    [Timeout Error], [LSP Request überschreitet Timeout-Grenze], [Error-Node mit Timeout-Meldung], [Projekt verkleinern oder Timeout erhöhen],
  )
]<error_handling_table>

Die #gls("Extension") unterscheidet zwischen Installationsfehlern der erforderlichen #gls("CDS") #gls("Extension"), Versionskonflikten und fehlgeschlagenen #gls("LSP")-Requests. Bei Installationsfehlern wird ein Error-Node mit Installations-Link zum #gls("VS Code") #gls("Marketplace") angezeigt. Die Versionsprüfung stellt sicher, dass mindestens Version 9.9.0 installiert ist, da das `/gax`-Flag erst ab dieser Version verfügbar ist. Bei fehlgeschlagenen #gls("LSP")-Requests zeigt die #gls("Extension") die Fehlermeldung als Tooltip an und ermöglicht den Zugriff auf den vollständigen Log über den "Show Output"-Befehl.

Während des Ladevorgangs informiert die #gls("Extension") den User über den aktuellen Fortschritt durch eine Sequenz von Loading-Messages im Tree, beispielsweise "Activating CDS Extension", "Querying workspace symbols", "Processing symbols" und "Building tree". Diese Granularität ist notwendig, da der `workspace/symbol` Request bei großen Projekten mehrere Sekunden dauern kann. Die Status-Messages verhindern die Wahrnehmung eines eingefrorenen #gls("UI")s und kommunizieren, dass die #gls("Extension") aktiv arbeitet. Nach erfolgreichem Laden verschwindet der Loading-Node und der vollständige Tree wird angezeigt.

#pagebreak(weak: true)

== Ergebnis der Implementierung

Die implementierte #gls("Extension") integriert sich als TreeView in #gls("VS Code")'s Sidebar und aggregiert alle Artefakte eines Service in einer navigierbaren Baumstruktur. Ein Klick auf ein Element im Tree öffnet die entsprechende Datei und markiert die relevante Stelle im Code. @final_extension_screenshot zeigt die #gls("Extension") im Einsatz.

#block(breakable: false)[
#figure(
  placement: auto,
  supplement: [Abbildung],
  caption: [Extension mit TreeView und Code-Navigation @vscode-cds-explorer],
  image("../assets/images/final_extension.png", width: 100%)
)<final_extension_screenshot>
]

#pagebreak()

Die Suchfunktion am oberen Rand des TreeView ermöglicht die Filterung der Artefakte. Die #gls("Extension") filtert den Baum und zeigt nur die relevanten Treffer an, während die hierarchische Struktur erhalten bleibt. @extension_search_screenshot zeigt die Suche nach dem Begriff "travel".

#block(breakable: false)[
#figure(
  placement: auto,
  supplement: [Abbildung],
  caption: [Suchfunktion mit gefilterter Baumansicht @vscode-cds-explorer],
  image("../assets/images/extension_serach.png", width: 100%)
)<extension_search_screenshot>
]

#pagebreak()

Zusätzlich zur Textsuche unterstützt die #gls("Extension") strukturierte Filterung nach Artefakt-Typen. Die Filter können kombiniert werden, um gezielt bestimmte Artefakt-Typen anzuzeigen und andere auszublenden. @extension_filter_screenshot zeigt die Filterung mit speziellen Token.

#block(breakable: false)[
#figure(
  placement: auto,
  supplement: [Abbildung],
  caption: [Filterung nach Artefakt-Typen @vscode-cds-explorer],
  image("../assets/images/extension_filter_only_aspects_and_travelservice.png", width: 100%)
)<extension_filter_screenshot>
]