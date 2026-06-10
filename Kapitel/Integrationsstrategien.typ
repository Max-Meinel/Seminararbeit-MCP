#import "../vendor/supercharged-dhbw/lib.typ": *
#import "@preview/lilaq:0.5.0" as lq

= Integrationsstrategien <integrationsstrategien>

Dieses Kapitel bildet die dritte Phase des #gls("DSR")-Prozesses nach Peffers et al. @Peffers_et_al_2008_DSRM (Entwurf und Entwicklung). Es entwickelt und vergleicht drei Integrationsstrategien für die Gewinnung von Service-Strukturinformationen aus #gls("CAP")-Projekten. Die Strategien unterscheiden sich in ihrer Datenquelle und dem Integrationsansatz. Repository-basiert durch direktes Parsen, #gls("CSN")-basiert durch Nutzung des kompilierten Modells und #gls("Language Server")-basiert durch Integration des #gls("CDS") #gls("Language Server")s. Jede Strategie wird hinsichtlich Implementierungsaufwand, semantischer Genauigkeit, Verfügbarkeit von Positionsinformationen, Integrationsgrad, Wartbarkeit und Abhängigkeiten bewertet. Der Vergleich mündet in die Auswahl einer Strategie, die als Grundlage für die #gls("Prototyp")-Implementierung in #ref(<implementierung>) dient.

== Repository-basierte Integration

Die repository-basierte Integration rekonstruiert die Service-Struktur direkt aus den Dateien des Projektrepositories. Die Analyse erfolgt durch Parsing der `.cds`-Dateien, wobei Entities, Services, Projections und Operationen syntaktisch extrahiert werden. Die Implementierungslogik wird durch Analyse von `.js`- und `.ts`-Dateien ermittelt. Beziehungen zwischen Artefakten müssen aus Referenzen im Code rekonstruiert werden.

#pagebreak()

=== Struktur von CDS-Dateien

@cds_source_example zeigt einen Ausschnitt einer typischen CDS-Service-Definition, anhand derer die Parsing-Herausforderungen verdeutlicht werden können.

#figure(
  kind: raw,
  supplement: [Quellcode],
  caption: [CDS-Service-Definition mit Projections und Action @bookshop],
  box(
    fill: rgb("#1e1e1e"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #set text(font: "DejaVu Sans Mono", size: 9pt, fill: rgb("#d4d4d4"))
    #set align(left)
    #let kw = rgb("#C586C0")
    #let str = rgb("#CE9178")
    #let cmt = rgb("#6A9955")
    #let ann = rgb("#DCDCAA")
    #let typ = rgb("#4EC9B0")
    #let num = rgb("#9CDCFE")

    #text(fill: kw)[using] \{ #text(fill: num)[sap.capire.bookshop] #text(fill: kw)[as] #text(fill: num)[my] \} #text(fill: kw)[from] #text(fill: str)['../db/schema'];\
    \
    #text(fill: kw)[service] #text(fill: typ)[CatalogService] \{\
    #h(1em)#text(fill: ann)[\@readonly] #text(fill: kw)[entity] #text(fill: typ)[Books] #text(fill: kw)[as] #text(fill: kw)[projection] #text(fill: kw)[on] #text(fill: num)[my.Books] \{\
    #h(2em)\*, #text(fill: num)[author.name] #text(fill: kw)[as] #text(fill: num)[author], #text(fill: num)[genre.name] #text(fill: kw)[as] #text(fill: num)[genre]\
    #h(1em)\} #text(fill: kw)[excluding] \{ #text(fill: num)[createdBy], #text(fill: num)[modifiedBy] \};\
    \
    #h(1em)#text(fill: ann)[\@requires]: #text(fill: str)['authenticated-user']\
    #h(1em)#text(fill: kw)[action] #text(fill: ann)[submitOrder] \( #text(fill: num)[book]: #text(fill: typ)[Books]:ID, #text(fill: num)[quantity]: #text(fill: typ)[Integer] \);\
    \}
  ]
)<cds_source_example>

=== Herausforderungen beim Parsing von CDS

Die technische Umsetzung erfordert einen eigenen #gls("Parser") für die #gls("CDS")-Sprache. #gls("CDS") ist eine #gls("Domänenspezifische Sprache") mit eigener Grammatik, die Konstrukte wie `entity`, `service`, `projection`, `aspect` und `type` unterstützt @cap_cdl. Die Implementierung eines #gls("Parser")s durchläuft typischerweise mehrere Phasen: lexikalische Analyse (Tokenisierung), syntaktische Analyse (Aufbau eines Parse-Baums) und semantische Analyse (Typprüfung, Referenzauflösung) #cite(<Aho_et_al_2007_Compilers>, supplement: [Ch. 1, pp. 4–5]).

Bereits @cds_source_example zeigt mehrere Parsing-Herausforderungen. Der `using`-Import in Zeile 1 führt einen Namespace-Alias (`my`) ein, der im gesamten Service verwendet wird. Ein #gls("Parser") muss diese Alias-Zuordnung in einer Symboltabelle verwalten und bei jeder Referenz auflösen können. Die Projection `Books` in Zeile 4 referenziert `my.Books`, wobei `my` auf `sap.capire.bookshop` aufgelöst werden muss. Zusätzlich enthält die Projection Feld-Aliasing (`author.name as author`), wobei Pfad-Ausdrücke über Associations aufgelöst werden müssen.

Die Grammatik von #gls("CDS") unterstützt zudem Annotationen (`@readonly`, `@requires`), die syntaktisch an verschiedenen Stellen auftreten können. Annotationen können verschachtelt sein und komplex strukturierte Werte enthalten #cite(<cap_cdl>). Ein vollständiger #gls("Parser") muss diese Annotationen extrahieren und den entsprechenden Artefakten zuordnen können. Actions wie `submitOrder` definieren Parametertypen (`Books:ID`, `Integer`), wobei die Typen ebenfalls im Modell aufgelöst werden müssen.

=== Referenzauflösung über Dateigrenzen

Eine zentrale Herausforderung der repository-basierten Integration ist die Referenzauflösung über Dateigrenzen hinweg. #gls("CDS")-Dateien können sich gegenseitig importieren, wobei Imports relative Pfade (`'../db/schema'`) oder Namespace-Referenzen verwenden. Ein #gls("Parser") muss diese Imports auflösen, die referenzierten Dateien laden und deren Definitionen in eine globale Symboltabelle integrieren.

Zusätzlich müssen Event Handler in `.js`- oder `.ts`-Dateien den entsprechenden Services zugeordnet werden. Die Zuordnung erfolgt typischerweise durch Namenskonventionen (z.B. `srv/catalog-service.cds` und `srv/catalog-service.js`) oder durch explizite Registrierung im Handler-Code. Ein vollständiger Ansatz müsste auch #gls("JavaScript")-Dateien analysieren, um diese Zuordnungen zu erkennen. Dies erfordert zusätzlich einen #gls("JavaScript")-#gls("Parser") oder die Nutzung spezialisierter Parsing-Bibliotheken.

=== Implementierungsaufwand und semantische Grenzen

Dieser Ansatz bringt einen hohen Implementierungsaufwand für Parsing und Referenzauflösung mit sich. Die Implementierung eines vollständigen #gls("CDS")-#gls("Parser")s mit korrekter Symboltabellenverwaltung und Multi-File-Referenzauflösung würde mehrere Personenmonate in Anspruch nehmen. Zudem besteht das Risiko semantischer Fehlinterpretationen der #gls("CDS")-Sprache, da ein eigener #gls("Parser") die Sprachsemantik nicht vollständig abbilden kann. Sprachfeatures wie Aspects, Vererbung und berechnete Elemente erfordern semantische Analysen, die über syntaktisches Parsing hinausgehen #cite(<Aho_et_al_2007_Compilers>, supplement: [Ch. 6, pp. 373–376]).

Darüber hinaus dupliziert dieser Ansatz Analysefunktionen, die bereits durch das #gls("CAP")-Tooling bereitgestellt werden. Der #gls("CAP")-Compiler führt bereits eine vollständige Analyse der #gls("CDS")-Dateien durch, einschließlich Typprüfung, Referenzauflösung und Validierung. Ein eigener #gls("Parser") würde diese Logik erneut implementieren müssen, was sowohl redundant als auch fehleranfällig ist. Bei Änderungen an der #gls("CDS")-Sprache müsste der #gls("Parser") manuell aktualisiert werden, was die Wartbarkeit beeinträchtigt.

Der Vorteil dieses Ansatzes liegt in seiner hohen Flexibilität und Unabhängigkeit. Ein eigener #gls("Parser") ermöglicht die vollständige Kontrolle über die extrahierten Informationen und ist unabhängig von externen Tools. Der Ansatz könnte auch ohne installierten #gls("CAP")-Compiler funktionieren, was in bestimmten Entwicklungsumgebungen relevant sein kann. Zudem wären auch Analysefunktionen möglich, die über die vom #gls("CAP")-Tooling bereitgestellten Informationen hinausgehen, etwa statische Code-Analyse oder projektspezifische Konventionsprüfungen.

== CSN-basierte Integration

Die #gls("CSN")-basierte Integration nutzt das von #gls("CAP") generierte #gls("CSN") Modell als Informationsquelle. #gls("CSN") ist eine kompilierte #gls("JSON")-Repräsentation aller #gls("CDS")-Artefakte. Der #gls("CAP")-Compiler erzeugt #gls("CSN") aus den `.cds`-Quelldateien und löst dabei alle Referenzen, Imports und Vererbungen auf.

=== Struktur und Inhalt von CSN

Im #gls("CSN")-Modell sind Entities, Services, Projections und Operationen strukturiert enthalten. Jedes Artefakt ist unter seinem vollqualifizierten Namen als #gls("JSON")-Objekt abgelegt. Das Feld `kind` gibt dabei den Artefakttyp an (z.B. `"entity"`, `"service"`, `"function"`). Beziehungen zwischen Artefakten sind bereits explizit aufgelöst, sodass keine eigene Referenzauflösung erforderlich ist.

Die hierarchische Struktur von #gls("CSN") spiegelt die semantische Struktur des #gls("CDS")-Modells wider. Services werden als Top-Level-Definitionen mit `kind: "service"` repräsentiert. Entities innerhalb eines Services erhalten einen vollqualifizierten Namen wie `ServiceName.EntityName`. Das `projection`-Feld enthält Informationen über die Quell-Entity, auf die die Projection verweist. Das `elements`-Feld listet alle Felder der Entity mit ihren Typen und Eigenschaften auf.

@csn_example zeigt einen Ausschnitt eines #gls("CSN")-Modells mit einem Service und einer zugehörigen Entity.

#figure(
  kind: raw,
  supplement: [Quellcode],
  caption: [Ausschnitt eines CSN-Modells mit Service und Entity],
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
    #let bool = rgb("#569CD6")

    \{\
    #h(1em)#text(fill: key)["definitions"]: \{\
    #h(2em)#text(fill: key)["TravelService"]: \{\
    #h(3em)#text(fill: key)["kind"]: #text(fill: str)["service"],\
    #h(3em)#text(fill: key)["\$location"]: \{ #text(fill: key)["file"]: #text(fill: str)["srv/travel-service.cds"], #text(fill: key)["line"]: #text(fill: num)[5] \}\
    #h(2em)\},\
    #h(2em)#text(fill: key)["TravelService.Travels"]: \{\
    #h(3em)#text(fill: key)["kind"]: #text(fill: str)["entity"],\
    #h(3em)#text(fill: key)["projection"]: \{\
    #h(4em)#text(fill: key)["from"]: \{ #text(fill: key)["ref"]: \[#text(fill: str)["sap.capire.travels.Travels"]\] \}\
    #h(3em)\},\
    #h(3em)#text(fill: key)["elements"]: \{\
    #h(4em)#text(fill: key)["ID"]: \{ #text(fill: key)["key"]: #text(fill: bool)[true], #text(fill: key)["type"]: #text(fill: str)["cds.Integer"] \},\
    #h(4em)#text(fill: key)["Description"]: \{ #text(fill: key)["type"]: #text(fill: str)["cds.String"], #text(fill: key)["length"]: #text(fill: num)[1024] \},\
    #h(4em)#text(fill: key)["BeginDate"]: \{ #text(fill: key)["type"]: #text(fill: str)["cds.Date"] \}\
    #h(3em)\}\
    #h(2em)\}\
    #h(1em)\}\
    \}
  ]
)<csn_example>

Aus @csn_example wird die Struktur ersichtlich. Der Service `TravelService` ist als Top-Level-Definition mit `kind: "service"` und einem `$location`-Feld vorhanden. Die Entity `TravelService.Travels` ist als Projection definiert, wobei das `projection.from.ref`-Feld auf die Quell-Entity `sap.capire.travels.Travels` verweist. Die `elements` enthalten die Felder der Entity mit vollständigen Typ-Informationen. Felder mit der Eigenschaft `key: true` kennzeichnen Primärschlüssel.

=== CSN-Generierung und Build-Integration

#gls("CSN") wird durch den #gls("CAP")-Compiler erzeugt. Der Befehl `cds compile` liest alle `.cds`-Dateien im Projekt, führt die semantische Analyse durch und schreibt das Ergebnis als #gls("JSON") in eine Datei. Die Generierung erfolgt typischerweise während des Build-Prozesses oder on-demand durch die #gls("Extension").

Für die Nutzung in einer #gls("VS Code")-#gls("Extension") könnte #gls("CSN") auf zwei Arten bereitgestellt werden. Erstens durch direkten Aufruf des #gls("CAP")-Compilers aus der #gls("Extension") heraus mittels eines Child-Prozesses. Dies würde bei jedem Projektöffnen oder jeder Dateiänderung eine Neu-Kompilierung erfordern. Zweitens durch Nutzung einer bereits generierten #gls("CSN")-Datei, falls diese im Build-Prozess erzeugt wird. Dies setzt jedoch voraus, dass Entwickler den Build-Schritt ausgeführt haben, was in frühen Entwicklungsphasen nicht immer der Fall ist.

Die Performance der #gls("CSN")-Generierung ist für große Projekte relevant. Der #gls("CAP")-Compiler muss alle #gls("CDS")-Dateien parsen, alle Referenzen auflösen und das vollständige Modell aufbauen. Bei Projekten mit mehreren hundert #gls("CDS")-Dateien kann dies mehrere Sekunden dauern. Für eine responsive #gls("Extension") wäre eine Caching-Strategie erforderlich, die nur bei tatsächlichen Änderungen eine Neu-Kompilierung anstößt.

=== Limitationen der location-Daten

#gls("CSN") bietet optional Positionsinformationen über das Feld #raw("$location"), die durch den Kompilierungsmodus #raw("--locations") aktiviert werden können. Wie in @csn_example ersichtlich, enthält #raw("$location") die Datei (file) und Zeile (line) der Definition. Diese Informationen sind jedoch unvollständig und weisen mehrere Limitationen auf.

Nicht alle Artefakte erhalten #raw("$location")-Daten. Top-Level-Definitionen wie Services und Entities besitzen typischerweise Location-Informationen. Verschachtelte Elemente wie einzelne Felder oder Annotations erhalten jedoch oft keine Positionsdaten. Actions und Functions innerhalb eines Service können Location-Daten haben, aber Parameter und Rückgabewerte sind nicht immer präzise lokalisiert. Diese Unvollständigkeit macht #gls("CSN") für FA3 (direkte Navigation zu Artefakten) nur eingeschränkt nutzbar.

Zusätzlich fehlen Spalten-Informationen (character-Offset). #gls("CSN") liefert nur die Zeile, nicht jedoch die genaue Position innerhalb der Zeile. Für präzise Navigation zu kleinen Artefakten wie einzelnen Feldern oder Parametern ist dies unzureichend. Die #gls("Extension") müsste zusätzliche Heuristiken implementieren, um die genaue Position innerhalb einer Zeile zu bestimmen, etwa durch Textsuche nach dem Artefaktnamen.

=== Vorteile und Einschränkungen

Die semantisch korrekte Interpretation ist durch die Nutzung des #gls("CAP")-Compilers garantiert. Das #gls("JSON")-Format ist direkt parsebar und erfordert keinen eigenen #gls("CDS")-#gls("Parser"). Der Implementierungsaufwand für das Parsen von #gls("CSN") ist gering, da Standard-#gls("JSON")-Bibliotheken verwendet werden können. Die hierarchische Struktur mit vollqualifizierten Namen erleichtert die Zuordnung von Artefakten zu Services.

Die Haupteinschränkung liegt in den unvollständigen Positionsinformationen. Für FA3 (direkte Navigation zu Artefakten) ist diese Abdeckung nicht ausreichend. Die #gls("Extension") müsste Fallback-Mechanismen implementieren, etwa Textsuche oder Heuristiken, um fehlende Positionen zu approximieren. Zusätzlich ist #gls("CSN") integraler Bestandteil des #gls("CAP")-Compilers. Erweiterungen am #gls("CSN")-Format würden den Build-Prozess verlangsamen und sind daher nicht praktikabel. Die #gls("Extension") wäre auf die vom #gls("CAP")-Compiler bereitgestellten Informationen beschränkt.

== Language-Server-basierte Integration

Die #gls("Language Server")-basierte Integration nutzt den #gls("CAP") #gls("Language Server") als zentrale Analysequelle (siehe #ref(<grundlagen>)). Der #gls("Language Server") stellt semantische Analysen der #gls("CDS")-Artefakte bereit und kommuniziert über das #gls("LSP") mit #gls("VS Code").

=== CAP Language Server Architektur

Der #gls("CAP") #gls("Language Server") ist als eigenständiger Prozess implementiert, der parallel zur #gls("VS Code")-Instanz läuft. Die Kommunikation erfolgt über Standard-Input/Output oder Sockets, wie in #ref(<grundlagen>) beschrieben. Der #gls("Language Server") verwaltet intern ein vollständiges Modell aller #gls("CDS")-Dateien im Workspace, einschließlich semantischer Informationen wie Typ-Hierarchien, Referenzen und Annotationen. Bei Dateiänderungen aktualisiert der #gls("Language Server") inkrementell sein internes Modell, wodurch schnelle Antwortzeiten auch bei großen Projekten gewährleistet sind.

=== workspace/symbol Request im Detail

Für die Service-Struktur-Analyse ist der #gls("LSP")-Request workspace/symbol relevant. Dieser Request liefert alle Symbole eines Workspace in einem strukturierten #gls("JSON"). Jedes Symbol enthält den Namen, den Container (übergeordnetes Element), die Datei-#gls("URI"), die exakte Position (range) im Quellcode sowie den Symboltyp im Feld `kind`. @workspace_symbol_example zeigt einen Ausschnitt der Antwort des #gls("CAP") #gls("Language Server")s.

#figure(
  kind: raw,
  supplement: [Quellcode],
  caption: [Beispiel einer Workspace-Symbol-Antwort des CAP Language Servers],
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

    #text()[\[]\
    #h(1em)\{\
    #h(2em)#text(fill: key)["name"]: #text(fill: str)["Bookings"],\
    #h(2em)#text(fill: key)["containerName"]: #text(fill: str)["TravelService"],\
    #h(2em)#text(fill: key)["location"]: \{\
    #h(3em)#text(fill: key)["uri"]: #text(fill: str)["file:\/\/\/srv/travel-service.cds"],\
    #h(3em)#text(fill: key)["range"]: \{\
    #h(4em)#text(fill: key)["start"]: \{ #text(fill: key)["line"]: #text(fill: num)[4], #text(fill: key)["character"]: #text(fill: num)[0] \},\
    #h(4em)#text(fill: key)["end"]: \{ #text(fill: key)["line"]: #text(fill: num)[21], #text(fill: key)["character"]: #text(fill: num)[1] \}\
    #h(3em)\}\
    #h(2em)\},\
    #h(2em)#text(fill: key)["kind"]: #text(fill: num)[5]\
    #h(1em)\},\
    #h(1em)\{\
    #h(2em)#text(fill: key)["name"]: #text(fill: str)["BookingDate"],\
    #h(2em)#text(fill: key)["containerName"]: #text(fill: str)["TravelService.Bookings"],\
    #h(2em)#text(fill: key)["location"]: \{ ... \},\
    #h(2em)#text(fill: key)["kind"]: #text(fill: num)[8]\
    #h(1em)\}\
    \]
  ]
)<workspace_symbol_example>

Das Feld containerName kodiert die Hierarchie der Artefakte. Ein Wert wie TravelService.Bookings bedeutet, dass das Symbol BookingDate innerhalb von Bookings liegt, welches wiederum zum TravelService gehört. Das Feld `kind` gibt den Symboltyp an gemäß der #gls("LSP")-Spezifikation. Die numerischen Werte entsprechen dem SymbolKind-Enum: 5 steht für eine Entity (Typ Class), 8 für ein Feld (Typ Field), 12 für eine Funktion (Typ Function) und 19 für einen Service (Typ Struct). Diese Information ermöglicht die Rekonstruktion der Service-Hierarchie durch Parsing der containerName-Strings.

Das range-Feld enthält präzise Positionsinformationen mit Start- und End-Position. Jede Position spezifiziert Zeile (line) und Spalte (character), beide nullbasiert. Diese Granularität ermöglicht die exakte Navigation zu jedem Artefakt und erfüllt FA3 vollständig. Im Gegensatz zu #gls("CSN") sind diese Positionsinformationen für alle Symbole verfügbar, nicht nur für Top-Level-Definitionen.

=== Integration in VS Code

Der #gls("Language Server") bietet eine native Integration in #gls("VS Code") über das #gls("LSP"). #gls("VS Code") stellt mit der vscode-languageclient-Bibliothek eine Client-Implementierung bereit, die die Kommunikation mit dem #gls("Language Server") abstrahiert. Die #gls("Extension") muss lediglich den #gls("Language Server")-Prozess starten und die Client-Instanz konfigurieren. Alle #gls("LSP")-Requests werden automatisch an den #gls("Language Server") weitergeleitet.

Diese Integration reduziert den Implementierungsaufwand erheblich. Die #gls("Extension") muss keine eigene Parsing- oder Analyselogik implementieren, sondern nur die vom #gls("Language Server") bereitgestellten Symbole konsumieren und in einer Tree-View darstellen. Zusätzlich profitiert die #gls("Extension") von zukünftigen Verbesserungen am #gls("Language Server"), ohne eigene Anpassungen vornehmen zu müssen. Wenn der #gls("Language Server") beispielsweise neue #gls("CDS")-Features unterstützt, sind diese automatisch in der #gls("Extension") verfügbar.

=== Erweiterbarkeit und Wartbarkeit

Bei Bedarf ist der #gls("Language Server") erweiterbar, da diese Arbeit in der Abteilung entsteht, die den #gls("CAP") #gls("Language Server") entwickelt. Falls der Request workspace/symbol nicht alle benötigten Informationen liefert, könnten eigene #gls("LSP")-Requests hinzugefügt werden. Diese würden spezifische Informationen für die servicezentrierte Navigation bereitstellen, etwa bereits aggregierte Service-Strukturen oder zusätzliche Metadaten.

Die Wartbarkeit ist durch die Nutzung eines etablierten Standards hoch. Das #gls("LSP") ist weitverbreitet und gut dokumentiert. Änderungen an der #gls("CDS")-Sprache werden zentral im #gls("Language Server") implementiert und sind automatisch für alle #gls("LSP")-Clients verfügbar. Die #gls("Extension") ist von der konkreten Implementierung des #gls("CAP")-Compilers entkoppelt und kommuniziert nur über die standardisierte #gls("LSP")-Schnittstelle.

=== Abhängigkeiten und Voraussetzungen

Die Strategie setzt voraus, dass der #gls("CAP") #gls("Language Server") zur Laufzeit verfügbar ist. Dies ist in typischen #gls("CAP")-Entwicklungsumgebungen der Fall, da der #gls("Language Server") als Teil der #gls("CDS") Language Support #gls("Extension") installiert wird. Ohne verfügbaren #gls("Language Server") kann die #gls("Extension") nicht funktionieren. Ein Fallback-Mechanismus auf #gls("CSN") oder Repository-basiertes Parsing wäre möglich, würde jedoch den Implementierungsaufwand deutlich erhöhen und die Vorteile der #gls("Language Server")-Integration zunichtemachen.

== Vergleich und Auswahl
Im Rahmen dieser Bachelorarbeit wird nur eine Strategie implementiert. Zur Auswahl wird eine Nutzwertanalyse durchgeführt. Die Strategie mit dem höchsten Nutzwert wird in #ref(<implementierung>) umgesetzt.

=== Nutzwertanalyse als Bewertungsmethode

Die #gls("Nutzwertanalyse") ist ein Verfahren zur Bewertung von Entscheidungsalternativen bei mehreren Zielgrößen, bei dem qualitative und quantitative Kriterien systematisch in eine Entscheidung einbezogen werden #cite(<Goetze_2014_Investitionsrechnung>, supplement: [pp. 193–194]). Das Verfahren eignet sich besonders für Entscheidungsprobleme, bei denen nicht alle Kriterien quantitativ messbar sind, wie es bei der Bewertung von Softwarearchitekturen der Fall ist.

Die Methode funktioniert wie folgt: Zunächst werden relevante Bewertungskriterien definiert und mit Gewichten versehen, die ihre relative Bedeutung ausdrücken. Die Summe aller Gewichte beträgt 1. Jede Alternative wird anschließend bezüglich jedes Kriteriums mit einem Punktwert auf einer definierten Skala bewertet. Der Gesamtnutzwert einer Alternative ergibt sich aus der Summe der gewichteten Einzelbewertungen. Die Alternative mit dem höchsten Nutzwert wird als vorteilhafteste Option identifiziert #cite(<Goetze_2014_Investitionsrechnung>, supplement: [pp. 193–194]).

Der Gesamtnutzwert $N_(N i)$ einer Alternative $i$ berechnet sich formal wie folgt #cite(<Goetze_2014_Investitionsrechnung>, supplement: [p. 196]):

$ N_(N i) = sum_(k=1)^K n_(i k) dot w_k $

wobei $n_(i k)$ den Teilnutzenwert der Alternative $i$ bezüglich des Kriteriums $k$ bezeichnet, $w_k$ das Gewicht des Kriteriums $k$ und $K$ die Anzahl der Bewertungskriterien.

Im Folgenden wird die #gls("Nutzwertanalyse") auf die Bewertung der drei Integrationsstrategien angewendet. Die Gewichtung der Kriterien und die Bewertung der Alternativen erfolgen auf Basis der in #ref(<anforderungsanalyse>) identifizierten Anforderungen.

=== Bewertungskriterien und Gewichtung

Für die Nutzwertanalyse werden Bewertungskriterien herangezogen. Diese leiten sich von den Anforderungen ab oder werden als sinnvoll erachtet. @bewertungskriterien_table zeigt diese Bewertungskriterien mit ihrer Gewichtung und Herleitung aus den Anforderungen. In den Abschnitten darunter werden die Kriterien näher erläutert.

#figure(
  supplement: [Tabelle],
  caption: [Bewertungskriterien und Gewichtung],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, auto, auto),
    inset: (x: 8pt, y: 5pt),
    align: (left, center, left),
    stroke: 0.5pt + black,
    [*Kriterium*], [*Gewicht*], [*Herleitung*],
    [K1: Semantische Genauigkeit], [25%], [FA1, FA2],
    [K2: Positionsinformationen], [25%], [FA3],
    [K3: VS Code Integration], [20%], [NFA1],
    [K4: Implementierungsaufwand], [15%], [–],
    [K5: Wartbarkeit], [10%], [NFA4],
    [K6: Unabhängigkeit], [5%], [–],
  )
]<bewertungskriterien_table>

Die Gewichtung orientiert sich an der Kritikalität für die Funktionsfähigkeit der #gls("Extension"). Kriterien, ohne die die #gls("Extension") nicht nutzbar wäre (K1, K2), erhalten die höchste Gewichtung von jeweils 25%. Kriterien, die die Qualität der Lösung beeinflussen (K3, K4, K5), erhalten mittlere Gewichtungen zwischen 10% und 20%. Kriterien, die Abhängigkeiten betreffen, aber durch höhere Funktionalität kompensiert werden können (K6), erhalten die niedrigste Gewichtung von 5%.

*K1: Semantische Genauigkeit (25%)* beschreibt die Fähigkeit, CDS-Artefakte korrekt zu identifizieren und zu interpretieren. Das Kriterium leitet sich aus FA1 und FA2 ab, da Services korrekt erkannt werden müssen. Es erhält die höchste Gewichtung, da ohne korrekte Erkennung die Extension nicht nutzbar ist.

*K2: Positionsinformationen (25%)* bezeichnet die Verfügbarkeit von Quellcode-Positionen (Zeile/Spalte) für Artefakte. Das Kriterium leitet sich aus FA3 ab, da Navigation zu Definitionen möglich sein muss. Es erhält ebenfalls die höchste Gewichtung, da Navigation das zentrale Feature der Extension ist.

*K3: VS Code Integration (20%)* bewertet die Kompatibilität mit #gls("VS Code") #gls("API")s und der Erweiterungsarchitektur. Das Kriterium leitet sich aus NFA1 ab und fordert eine nahtlose Einbindung in die #gls("IDE"). Die hohe Gewichtung ergibt sich daraus, dass schlechte Integration die Akzeptanz mindert.

*K4: Implementierungsaufwand (15%)* erfasst Komplexität und Zeitbedarf für die Umsetzung. Es gibt keine direkte Anforderung, jedoch besteht eine praktische Ressourcenbeschränkung im Rahmen dieser Bachelorarbeit. Die mittlere Gewichtung spiegelt den realistischen Projektrahmen wider.

*K5: Wartbarkeit (10%)* bewertet die langfristige Anpassbarkeit bei Änderungen am #gls("CAP")-Framework. Das Kriterium leitet sich aus NFA4 ab, da die #gls("Extension") auch zukünftig funktionieren soll. Die geringere Gewichtung ergibt sich daraus, dass zunächst die Funktionalität wichtiger ist.

*K6: Unabhängigkeit (5%)* bezeichnet die Freiheit von externen Laufzeitabhängigkeiten. Es gibt keine direkte Anforderung. Abhängigkeiten sind akzeptabel, wenn die Funktionalität dadurch besser wird. Die niedrigste Gewichtung ist ein bewusster Trade-off.

@nutzwertanalyse_table zeigt die Bewertung der drei Strategien anhand der definierten Kriterien.

#figure(
  supplement: [Tabelle],
  caption: [Nutzwertanalyse der Integrationsstrategien],
)[
  #set text(size: 9pt)
  #table(
    columns: (1fr, auto, auto, auto, auto),
    inset: (x: 8pt, y: 5pt),
    align: (left, center, center, center, center),
    stroke: 0.3pt + black,
    [*Kriterium*], [*Gewicht*], [*Repository*], [*CSN*], [*Language Server*],
    [K1: Semantische Genauigkeit], [25%], [2], [5], [5],
    [K2: Positionsinformationen], [25%], [3], [1], [5],
    [K3: VS Code Integration], [20%], [2], [3], [5],
    [K4: Implementierungsaufwand], [15%], [2], [4], [3],
    [K5: Wartbarkeit], [10%], [2], [3], [4],
    [K6: Unabhängigkeit], [5%], [5], [2], [2],
    [*Gewichtete Summe*], [100%], [*2.40*], [*3.10*], [*4.45*],
  )
]<nutzwertanalyse_table>

#text(size: 9pt)[
  *Punkteskala:* 1 = unzureichend | 2 = ausreichend | 3 = befriedigend | 4 = gut | 5 = sehr gut
]

Die detaillierte Begründung der Punktvergabe für jedes Kriterium und jede Strategie ist in @nutzwertanalyse_begruendung_table im Anhang dokumentiert. Die wesentlichen Unterschiede lassen sich wie folgt zusammenfassen. Bei K1 (Semantische Genauigkeit) erzielen #gls("CSN") und #gls("Language Server") Höchstwerte, da beide den #gls("CAP")-Compiler nutzen. Der entscheidende Differenzierungsfaktor ist K2 (Positionsinformationen). #gls("CSN") liefert diese nur unvollständig, während der #gls("Language Server") über die Location-#gls("API") präzise Quellcode-Positionen bereitstellt. Bei K3 (#gls("VS Code") Integration) profitiert der #gls("Language Server") von der nativen #gls("LSP")-Unterstützung, während Repository und #gls("CSN") zusätzliche Adapter erfordern. Der Implementierungsaufwand (K4) ist bei #gls("CSN") am geringsten, da das #gls("JSON")-Format direkt parsebar ist. Bei K5 (Wartbarkeit) punktet der #gls("Language Server") durch die Stabilität des #gls("LSP")-Standards, während ein eigener #gls("Parser") bei jeder Sprachänderung angepasst werden müsste. K6 (Unabhängigkeit) zeigt den Trade-off: Die Repository-Strategie ist vollständig unabhängig, während #gls("CSN") und #gls("Language Server") externe Abhängigkeiten mitbringen.

== Auswahl der Integrationsstrategie
Die #gls("Nutzwertanalyse") ergibt den höchsten Wert für die #gls("Language Server")-basierte Integration mit 4.45 Punkten (siehe @nutzwertanalyse_chart). Der #gls("Language Server") bietet die beste #gls("VS Code") Integration, da er das #gls("LSP") nativ implementiert. Er liefert vollständige Positionsinformationen, während #gls("CSN") diese nur unvollständig bereitstellt. Ein eigener #gls("Parser") wäre aufwendig und fehleranfällig. Zusätzlich kann der #gls("Language Server") bei Bedarf erweitert werden, da diese Arbeit in der Abteilung entsteht, die ihn entwickelt.

#figure(
  supplement: [Abbildung],
  caption: [Ergebnis der Nutzwertanalyse],
  lq.diagram(
    width: 9cm,
    height: 3.5cm,
    yaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    xaxis: (lim: (0, 5.5), subticks: none, ticks: ((0, [0]), (1, [1]), (2, [2]), (3, [3]), (4, [4]), (5, [5]))),
    xlabel: [Nutzwert],
    lq.hbar(
      (2.40, 3.10, 4.45),
      (0, 1, 2),
      width: 0.5,
      fill: (rgb("#ef4444"), rgb("#f59e0b"), rgb("#10b981")),
    ),
    lq.place(2.40, 0, align: left, pad(left: 0.5em)[2.40]),
    lq.place(3.10, 1, align: left, pad(left: 0.5em)[3.10]),
    lq.place(4.45, 2, align: left, pad(left: 0.5em)[4.45]),
  )
)<nutzwertanalyse_chart>

Die Wahl des #gls("Language Server")s bringt eine Abhängigkeit zur Laufzeit mit sich. Dieser Trade-off wird zugunsten der höheren Funktionalität akzeptiert. #ref(<implementierung>) beschreibt die Implementierung der #gls("Extension") auf Basis der gewählten #gls("Language Server")-Integration.
