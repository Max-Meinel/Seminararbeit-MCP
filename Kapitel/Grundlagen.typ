#import "../vendor/supercharged-dhbw/lib.typ": *

= Grundlagen <grundlagen>

Dieses Kapitel vermittelt die technischen Grundlagen zum Verständnis der Arbeit. Es beschreibt das #gls("SAP CAP"), #gls("CDS") und #gls("CSN"). Anschließend werden das #gls("LSP") sowie die #gls("VS Code") #gls("Extension") Architektur erläutert.

== SAP Cloud Application Programming Model (CAP)

Das #gls("SAP CAP") ist ein Framework für Enterprise-Cloud-Anwendungen von SAP @cap_docs. Das zentrale Ziel ist die Maximierung der Produktivität durch integrierte Best Practices. Entwickler erhalten bewährte Lösungsmuster standardmäßig bereitgestellt, ohne diese manuell implementieren zu müssen. Moderne Cloud-Anwendungen folgen dabei etablierten Architekturprinzipien wie Isolation, Elastizität und lose Kopplung #cite(<Fehling_2014_Cloud_Computing_Patterns>, supplement: [Ch. 3, IDEAL Properties]).

Das Framework folgt etablierten Architekturprinzipien. Cloud-native Anwendungen zeichnen sich durch Skalierbarkeit, Resilienz und automatisierte Deployment-Prozesse aus @IJRPR_2024_Cloud_Native. #gls("Domain-Driven Design") bedeutet, dass der Fokus auf der Geschäftslogik liegt, während technische Details in den Hintergrund treten. #gls("Separation of Concerns") strukturiert die Anwendung durch klare Trennung von Domänenmodell (Datenbank), Services und Benutzeroberfläche @Nierstrasz_Achermann_2000_SoC. #gls("Serviceorientierte Architektur") bedeutet, dass Funktionalität über klar definierte #gls("API")s zugänglich gemacht wird @Papazoglou_2003_SOC.

@cap_architecture zeigt die Architektur von #gls("CAP") im Überblick. #gls("CDS") bilden den zentralen Baustein, der Services, Datenmodelle und #gls("UI")s verbindet. #gls("CAP") unterstützt zwei Laufzeitumgebungen: Node.js und Java.

#figure(
  image("../assets/images/architecture.drawio.svg", width: 80%),
  caption: [CAP-Architektur mit CDS als zentralem Baustein @cap_concepts]
)<cap_architecture>

Die technischen Features umfassen vollständige #gls("SDK")s für die Laufzeitumgebungen Node.js und Java @cap_docs. Event Handler werden als #gls("JavaScript")-, #gls("TypeScript")-Funktionen oder als Java-Klassen implementiert. #gls("CAP") unterstützt mehrere Kommunikationsprotokolle wie #gls("OData") @odata_spec, #gls("OpenAPI") @openapi_spec und #gls("AsyncAPI"), die automatisch aus #gls("CDS")-Modellen generiert werden. Weitere zentrale Features sind Multi-Tenancy-Unterstützung zur Verwaltung mehrerer Mandanten #cite(<Fehling_2014_Cloud_Computing_Patterns>, supplement: [Ch. 5]) @Krebs_et_al_2012_Multi_Tenant_SaaS, Datenbank-Abstraktion für #gls("HANA"), #gls("SQLite") und #gls("PostgreSQL") sowie Event-Driven Messaging für asynchrone Kommunikation.

Multi-Tenancy in #gls("SaaS")-Anwendungen erfordert Isolation auf mehreren Ebenen @Krebs_et_al_2012_Multi_Tenant_SaaS. Während Tenants dieselbe Anwendungsinstanz nutzen, müssen ihre Daten und Performance-Charakteristika isoliert bleiben. #gls("CAP") adressiert dies durch konfigurierbare Tenant-Isolation auf Datenbank-Ebene und Request-basierte Tenant-Erkennung.

=== Core Data Services (CDS)
#gls("CDS") ist die Modellierungssprache von #gls("SAP CAP") @cap_cds. Entwickler definieren in #gls("CDS") die Struktur ihrer Anwendung. Entities repräsentieren Datenmodelle, Services definieren #gls("API")-Schnittstellen und Associations beschreiben Beziehungen zwischen Entities. Die textuelle Syntax heißt #gls("CDL") und wird in Dateien mit der Endung `.cds` geschrieben #cite(<cap_cdl>, supplement: [Sec. Language Preliminaries]).

Das #gls("CDS")-Toolkit kompiliert alle `.cds`-Dateien eines Projekts zu #gls("CSN"), der kompilierten Repräsentation des Gesamtmodells #cite(<cap_csn>, supplement: [Sec. Anatomy]). @cds_csn_compilation zeigt diesen Kompilierungsprozess. #gls("CSN") repräsentiert das Modell als Datenstruktur und enthält die vollständige semantische Information aller Definitionen.

#figure(
  image("../assets/images/csn.drawio.svg", width: 80%),
  caption: [CDS-Kompilierungsfluss mit CSN als zentralem Zwischenformat @cap_cds]
)<cds_csn_compilation>

=== Core Schema Notation (CSN)

#gls("CSN") ist die interne Repräsentation des #gls("CDS")-Modells als #gls("JSON")-Struktur #cite(<cap_csn>, supplement: [Sec. Anatomy]). Während #gls("CDL") die textuelle Quellform ist, die Entwickler schreiben, ist #gls("CSN") die vollständig aufgelöste und semantisch validierte Zielform, die Werkzeuge verarbeiten.

Das #gls("CSN")-Format strukturiert alle Modelldefinitionen unter einem zentralen `definitions`-Objekt. Jede Definition ist über ihren vollqualifizierten Namen eindeutig identifizierbar #cite(<cap_csn>, supplement: [Sec. Structure]). Das Feld `kind` gibt den Typ der Definition an (z.B. `service`, `entity`, `type` oder `action`). Entities enthalten ein `elements`-Objekt, das alle Felder mit ihren Typen und Constraints beschreibt. Services sind als Container-Definitionen strukturiert, wobei die zu ihnen gehörenden Entities über den Namensraum zugeordnet werden.

#gls("CSN") löst während der Kompilierung alle Referenzen, Imports und Vererbungen auf. Eine Entity, die einen Aspect einbindet, enthält in #gls("CSN") alle geerbten Felder direkt #cite(<cap_cdl>, supplement: [Sec. Aspects]). Ein Service, der Entities aus anderen Namespaces importiert, referenziert diese über vollqualifizierte Namen. Projections werden als eigenständige Entities mit einem `projection`-Feld repräsentiert, das auf die Quell-Entity verweist #cite(<cap_cdl>, supplement: [Sec. Projections]). Diese vollständige Auflösung macht #gls("CSN") zu einer verlässlichen Quelle für semantische Analysen.

#gls("CSN") dient als Ausgangsbasis für nachgelagerte Werkzeuge. Der #gls("CAP")-Compiler generiert daraus Datenbankschemas, #gls("API")-Dokumentationen und Laufzeit-Metadaten #cite(<cap_csn>, supplement: [Sec. Anatomy]). #gls("Extension")s können #gls("CSN") nutzen, um die Modellstruktur zu analysieren, ohne eigene #gls("Parser") implementieren zu müssen. Allerdings enthält #gls("CSN") standardmäßig keine Quellcode-Positionsinformationen, da es primär für die Codegenerierung gedacht ist, nicht für die Navigation im Quellcode.

Neben #gls("CDL") und #gls("CSN") umfasst #gls("CDS") weitere Notationen wie Core Query Language (CQL) für Abfragen und Core Expression Language (CXL) für Ausdrücke @cap_cds. Diese sind für die vorliegende Arbeit nicht relevant.

=== CDS-Artefakt-Typen

#gls("CDS") definiert verschiedene Artefakt-Typen zur Modellierung von Anwendungen. Diese Artefakte werden in #gls("CDS")-Dateien mit spezifischen Keywords deklariert und vom #gls("Language Server") als Symbole mit entsprechenden Typ-Kennungen bereitgestellt. @cds_artefakt_typen fasst die zentralen Artefakt-Typen mit ihrer Notation zusammen. Die Definitionen basieren auf der offiziellen CAP CDL-Dokumentation #cite(<cap_cdl>).

#figure(
  supplement: [Tabelle],
  caption: [Zentrale CDS-Artefakt-Typen mit Notation und Verwendungskontext],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, auto, auto),
    inset: (x: 8pt, y: 6pt),
    align: (left, left, left),
    stroke: 0.3pt + black,
    [*Artefakt-Typ*], [*CDS-Keyword*], [*Beschreibung*],

    [Entity], [`entity`], [Datenmodell mit Feldern, repräsentiert persistierte Datensätze],
    [Type], [`type`], [Wiederverwendbare Typdefinition für Felder],
    [Association], [`association`], [Deklarative Beziehung zwischen Entities],
    [Aspect], [`aspect`], [Modellerweiterung zur Anreicherung von Entities],
    [Service], [`service`], [Container für exponierte Entities und Operationen],
    [Projection], [`projection`], [Abgeleitete Entity-Sicht mit Filterung],
    [Action], [`action`], [Service-Operation mit Seiteneffekten],
    [Function], [`function`], [Service-Operation ohne Seiteneffekte],
    [Event Handler], [–], [Implementierung von Service-Logik (JS, TS oder Java)],
    [Annotation], [`@`...], [Metadaten zur Anreicherung von Definitionen],
  )
]<cds_artefakt_typen>

In dieser Arbeit wird folgende Notationskonvention verwendet: Fachliche Bezüge auf Artefakt-Typen im Fließtext werden großgeschrieben (Entity, Service, Action). CDS-Keywords in Code-Beispielen werden in Monospace-Schrift kleingeschrieben (`entity`, `service`). Technische Bezeichner aus dem #gls("LSP")-Kontext werden in Großbuchstaben geschrieben (ENTITY, SERVICE).

== Language Server und Language Server Protocol

Moderne #gls("IDE")s bieten intelligente Funktionen wie Autovervollständigung, Fehleranzeige, #gls("Go-to-Definition") und Refactoring (z.B. Umbenennen von Symbolen). Diese Funktionen erfordern ein tiefes Verständnis der Programmiersprache, insbesondere von Syntax, Semantik und Typsystem. Ein #gls("Language Server") ist ein separater Prozess, der diese Sprachanalyse übernimmt und die entsprechenden #gls("IDE")-Features bereitstellt #cite(<langserver_org>, supplement: [Sec. What is LSP?]) @Bork_Langer_2023_LSP_Introduction. Die klare Trennung ermöglicht, dass der Server die "Language Smarts" implementiert (Parsing, #gls("AST")-Erzeugung, Analyse), während der Client sprachagnostisch bleibt und sich auf Editor-Interaktion konzentriert.

Das #gls("LSP") ist ein von Microsoft entwickeltes Standardprotokoll zur Kommunikation zwischen #gls("IDE") und #gls("Language Server") #cite(<langserver_org>, supplement: [Sec. What is LSP?]) @Bork_Langer_2023_LSP_Introduction. Das Ziel ist die Entkopplung von Editor und Sprachanalyse. Ein #gls("Language Server") kann dadurch in allen #gls("IDE")s genutzt werden. Vor #gls("LSP") musste jede #gls("IDE") die Sprachunterstützung selbst implementieren, was zu N×M Implementierungen führte (N #gls("IDE")s multipliziert mit M Sprachen). Mit #gls("LSP") genügt es, den #gls("Language Server") einmal zu implementieren, wodurch nur noch N+M Implementierungen erforderlich sind #cite(<langserver_org>, supplement: [Sec. Why LSP?]) @Bork_Langer_2023_LSP_Introduction.

=== Architektur des Language Servers

#gls("LSP") basiert auf einem Client-Server-Modell. Die #gls("IDE") ist der Client, der #gls("Language Server") ist ein separater Prozess, der als Server fungiert #cite(<lsp_specification>, supplement: [Sec. Base Protocol]). Der Server wird vom Client gestartet, verarbeitet während der Laufzeit Anfragen und wird am Ende wieder beendet. Der Server ist zustandsbehaftet und kennt den aktuellen Stand aller geöffneten Dokumente. Diese Architektur wurde durch Erfahrungen mit Eclipse beeinflusst, wo #gls("Extension")s im selben Prozess liefen und Startzeit oder Kernfunktionalität negativ beeinflussen konnten @Bork_Langer_2023_LSP_Introduction. #gls("VS Code") entschied sich deshalb für getrennte Extension-Prozesse und kontrollierte #gls("API")-Gateways.

=== Kommunikationsprotokoll

Die Kommunikation zwischen #gls("IDE") und #gls("Language Server") basiert auf #gls("JSON-RPC") 2.0 als Nachrichtenaustausch-Protokoll #cite(<jsonrpc_specification>). Das Protokoll ermöglicht Remote Procedure Calls, bei denen ein Client Methoden auf einem Server aufrufen kann, der in einem separaten Prozess läuft. Die Nachrichten werden als #gls("JSON")-Objekte kodiert und über Standardein- und -ausgabe oder Netzwerkverbindungen übertragen.

Das Protokoll unterscheidet zwischen Requests, die eine Antwort erwarten, und Notifications, die asynchron ohne Antworterwartung gesendet werden. Diese Trennung ermöglicht sowohl synchrone Operationen wie "Hole die Definition eines Symbols" als auch asynchrone Benachrichtigungen wie "Datei wurde geändert". Die Verwendung von #gls("JSON") als Nachrichtenformat macht das Protokoll sprachunabhängig und einfach implementierbar, da alle modernen Programmiersprachen #gls("JSON")-Bibliotheken bereitstellen.

=== Relevante LSP-Funktionalitäten

#gls("LSP") definiert verschiedene Funktionen für die Interaktion zwischen #gls("IDE") und #gls("Language Server") #cite(<lsp_specification>, supplement: [Sec. Language Features]). Der Client sendet Requests an den Server, die jeweils eine Dokumentenposition oder einen Workspace-Kontext enthalten. Der Server analysiert den Quellcode und liefert die angeforderten Informationen als Response zurück. Diese Funktionen sind nicht auf klassische Programmiersprachen beschränkt, sondern können auch für domänenspezifische Sprachen implementiert werden @Loth_et_al_2023_UVLS. Relevante Funktionen sind:

- `textDocument/completion`\
  Liefert Vervollständigungsvorschläge für die aktuelle Eingabeposition

- `textDocument/hover`\
  Liefert Typ- und Dokumentationsinformationen für ein Symbol an einer gegebenen Position

- `textDocument/definition`\
  Liefert die Quellcode-Position der Definition eines Symbols

- `workspace/symbol`\
  Liefert alle im Workspace definierten Symbole mit ihren Positionen

Neben diesen Kernfunktionen bieten #gls("Language Server") in der Praxis oft zusätzliche Features wie Syntaxhervorhebung, kontextsensitive Autovervollständigung, Referenznavigation und gleichzeitiges Umbenennen aller Referenzen @Loth_et_al_2023_UVLS.

== VS Code Extension Architektur

#gls("VS Code") ist über #gls("Extension")s erweiterbar @extension. #gls("Extension")s sind Plug-ins, die zusätzliche Funktionalität zum Editor hinzufügen. Sie laufen in einem separaten Extension Host Prozess und sind damit vom Editor-Kern isoliert @vscode-extension-host. #gls("Extension")s können #gls("UI")-Elemente, Commands und Sprachfeatures beitragen.

#gls("VS Code") stellt eine #gls("Extension") #gls("API") bereit, über die #gls("Extension")s auf Editor-Funktionen zugreifen können @vscode-capabilities. Die #gls("API") umfasst verschiedene Bereiche wie Dateiverwaltung, #gls("UI")-Komponenten, Sprach-Features und Debugging-Funktionen. Eine dieser #gls("API")s ist die Tree View #gls("API").

=== UI-Extensions: Tree View und Webview API

#gls("VS Code") bietet verschiedene #gls("API")s zur Implementierung eigener Benutzeroberflächen in #gls("Extension")s. Die Wahl der passenden #gls("API") hängt von der Komplexität und Art der darzustellenden Inhalte ab.

Die *Tree View #gls("API")* ermöglicht das Erstellen hierarchischer Baumansichten in der Sidebar @vscode-treeview. Das zentrale Konzept ist der `TreeDataProvider`, der die Methoden `getTreeItem()` und `getChildren()` implementiert @vscode-treeview-provider. Die erste Methode liefert die Darstellung eines Knotens mit Label, Icon und Zustand, während die zweite die Kind-Elemente zurückgibt. #gls("VS Code") ruft diese Methoden nur für aktuell sichtbare Knoten auf, wodurch auch große Baumstrukturen performant darstellbar sind. Die Aktualisierung erfolgt ereignisbasiert über ein `onDidChangeTreeData` Event @vscode-treeview-updating.

Die *Webview #gls("API")* ermöglicht die Darstellung von #gls("HTML")-basiertem Inhalt mit vollständiger Kontrolle über #gls("HTML"), #gls("CSS") und #gls("JavaScript") @vscode-webview. Die Kommunikation zwischen #gls("Extension") und Webview erfolgt bidirektional über Message-Passing. Webviews bieten mehr Gestaltungsfreiheit als Tree Views, erfordern aber höheren Implementierungsaufwand.

=== Integration von Language Servern

#gls("VS Code") bietet native Unterstützung für #gls("Language Server") über die `vscode-languageclient` Bibliothek. Eine #gls("Extension") kann einen #gls("Language Server") als separaten Prozess starten. Der Language Client übernimmt die #gls("LSP")-Kommunikation automatisch. Neben den Standard-#gls("LSP")-Features kann eine #gls("Extension") auch eigene Requests an den Server senden. So können Analyseergebnisse des #gls("Language Server")s für eigene #gls("UI")-Komponenten genutzt werden @vscode-languageserver.

== Navigation und Informationssuche in Softwaresystemen

Das Verständnis und die Wartung von Softwaresystemen erfordern kontinuierliche Navigation zwischen verschiedenen Artefakten. Entwickler verbringen einen erheblichen Teil ihrer Arbeitszeit damit, relevante Informationen zu lokalisieren, Abhängigkeiten nachzuvollziehen und Kontexte zu rekonstruieren. Die Art und Weise, wie Entwicklungsumgebungen Navigation unterstützen, hat direkten Einfluss auf die Produktivität und #gls("Kognitive Belastung") von Entwicklern.

Beim Verstehen von Software müssen Entwickler mehrere Informationsebenen gleichzeitig verarbeiten. Die Cognitive Load Theory nach Sweller beschreibt, dass Menschen nur über eine begrenzte kognitive Verarbeitungskapazität im Arbeitsgedächtnis verfügen #cite(<Sweller_1988_Cognitive_Load>, supplement: [p. 261]). Wenn diese Kapazität durch das Navigieren zwischen Dateien, das Rekonstruieren von Zusammenhängen oder das Merken verteilter Informationen erschöpft wird, bleibt weniger Kapazität für das eigentliche Problem. Kontextwechsel zwischen verschiedenen Dateien erhöhen die kognitive Belastung zusätzlich, da Entwickler den vorherigen Kontext im Gedächtnis behalten müssen, während sie sich in einen neuen Kontext einarbeiten.

Ko et al. identifizieren in ihrer Studie zu Informationsbedürfnissen von Entwicklern, dass Entwickler häufig Schwierigkeiten haben, relevante Informationen über Code, Design und Programmausführung aus verschiedenen Artefakten zusammenzuführen #cite(<Ko_et_al_2007_Information_Needs>, supplement: [p. 347]). LaToza et al. zeigen, dass Entwickler stark auf implizites Code-Wissen angewiesen sind, das nicht in Werkzeugen oder Dokumentation externalisiert ist #cite(<LaToza_et_al_2006_Mental_Models>, supplement: [p. 492]). Entwickler müssen mentale Modelle der Systemarchitektur aufbauen, die die verteilten Artefakte wieder zusammenführen. Dieser Prozess ist fehleranfällig und zeitaufwändig, insbesondere bei unbekannten oder großen Codebases.

Moderne #gls("IDE")s bieten verschiedene Navigationsmuster an, die unterschiedliche Arten der Informationssuche unterstützen. File-basierte Navigation ermöglicht das Durchsuchen der Verzeichnisstruktur über einen Datei-Explorer. Symbol-basierte Navigation ermöglicht die direkte Suche nach Funktionen, Klassen oder Variablen, etwa durch #gls("Go-to-Definition") #cite(<vscode-goto>, supplement: [Sec. Go to Definition]) oder Symbol-Search. Hierarchische Navigation zeigt Beziehungen zwischen Code-Elementen in Baumstrukturen, beispielsweise durch die #gls("Outline-Ansicht") #cite(<vscode-outline>, supplement: [Sec. Outline View]). Referenz-basierte Navigation ermöglicht das Auffinden aller Verwendungsstellen eines Symbols über Find References.

Diese existierenden Navigationsmuster operieren jedoch überwiegend datei- oder symbolzentriert. Eine servicezentrierte Navigation, die alle zu einer logischen Einheit gehörenden Artefakte aggregiert darstellt, ist in gängigen #gls("IDE")s nicht vorhanden. Genau diese Lücke adressiert die vorliegende Arbeit für #gls("SAP CAP")-Projekte.