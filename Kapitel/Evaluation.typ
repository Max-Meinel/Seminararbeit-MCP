#import "../vendor/supercharged-dhbw/lib.typ": *

#import "@preview/lilaq:0.5.0" as lq

= Evaluation <evaluation>

Die Evaluation bildet die fünfte Phase des #gls("DSR")-Prozesses nach Peffers et al. @Peffers_et_al_2008_DSRM. Dieses Kapitel prüft, inwieweit die #gls("Extension") die in #ref(<anforderungsanalyse>) definierten Anforderungen erfüllt. Die Bewertung erfolgt kriterienbasiert anhand von drei Testprojekten unterschiedlicher Größe und Komplexität.

== Testprojekte

Die #gls("Extension") wurde an drei #gls("CAP")-Projekten evaluiert, die sich in Größe und Komplexität unterscheiden.

*bookshop* ist das offizielle #gls("CAP")-Referenzbeispiel von SAP @bookshop. Das Projekt eignet sich als Baseline, da es die dokumentierte Best-Practice-Struktur abbildet und als kleines, übersichtliches Projekt den unteren Komplexitätsbereich repräsentiert.

*xtravels* ist ein Travel-Management-System mittlerer Komplexität @xtravels. Das Projekt eignet sich, weil es die in #ref(<anforderungsanalyse>) beschriebene Fragmentierung zeigt. Service-Definition, Handler-Implementierung und Authorization-Annotationen liegen in separaten Dateien.

*ctsm-develop* ist ein produktives Clinical-Trial-System @ctsm-develop. Das Projekt eignet sich, weil es die Komplexität realer #gls("Enterprise-Anwendung")en abbildet. Es umfasst mehrere Services, verschachtelte Verzeichnisstrukturen und externe Service-Referenzen.

Diese Auswahl deckt kleine, mittlere und große #gls("CAP")-Projekte ab und testet die #gls("Extension") unter unterschiedlichen Bedingungen.

#figure(
  supplement: [Tabelle],
  caption: [Charakterisierung der Testprojekte nach Größenmetriken],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, auto, auto, auto, auto),
    inset: (x: 8pt, y: 5pt),
    align: (left, center, center, center, left),
    stroke: 0.3pt + black,
    [*Projekt*], [*Services*], [*Entities*], [*CDS-Dateien*], [*Kategorie*],
    [bookshop], [2], [4], [16], [Klein],
    [xtravels], [3], [9], [16], [Mittel],
    [ctsm-develop], [66], [1835], [803], [Groß],
  )
]<projekt_charakterisierung>

Die Kategorisierung basiert auf der Anzahl von Services und Entities. Kleine Projekte (< 3 Services, < 5 Entities) repräsentieren einfache Anwendungsfälle und dienen als Baseline. Mittlere Projekte (1–10 Services, 5–20 Entities) entsprechen typischen Entwicklungsprojekten. Große Projekte (> 50 Services, > 1000 Entities) bilden produktive #gls("Enterprise-Anwendung")en mit komplexen Datenmodellen ab.

== Vergleich mit bestehenden Ansätzen

Die #gls("Extension") wird mit drei bestehenden Navigationsmethoden verglichen: #gls("VS Code") Outline-View, File Explorer und direkte Nutzung der #gls("CDS") #gls("Language Server")-Features (Go to Definition, Find References).

Die Outline-View zeigt nur Symbole der aktuell geöffneten Datei und bietet keine servicezentrierte Aggregation über Dateigrenzen hinweg. Ein Service, dessen Artefakte über `db/`, `srv/` und `app/` verteilt sind, ist in der Outline nicht als Einheit erfassbar. Die Extension adressiert dies durch projektweite Aggregation aller servicebezogenen Artefakte in einer einheitlichen Baumstruktur.

Der File Explorer navigiert entlang der physischen Ordnerstruktur. Zusammengehörige Service-Artefakte müssen manuell über mehrere Ordner hinweg gesucht werden. Die Extension invertiert diese Perspektive: Der Service ist der primäre Einstiegspunkt, die Dateien sind sekundär im "Files"-Ordner sichtbar. Dies entspricht dem fachlichen mentalen Modell von CAP-Entwicklern, die in Services denken, nicht in Ordnern.

Die direkten #gls("Language Server")-Features (Go to Definition, Find References) unterstützen punktuelle Navigation von einem Symbol zu dessen Verwendungsstellen. Eine Übersicht aller Service-Komponenten ohne initialen Einstiegspunkt ist nicht möglich. Die #gls("Extension") kombiniert beide Ansätze: Übersicht (Tree) plus Detail-Navigation (#gls("LSP")-Features im Context-Menü).

Die #gls("Extension") ersetzt diese Werkzeuge nicht, sondern ergänzt sie um die fehlende servicezentrierte Perspektive. Die bestehenden Tools bleiben für ihre spezifischen Anwendungsfälle (datei-lokale Navigation, Verzeichnis-Browsing, Symbol-zu-Symbol-Navigation) weiterhin relevant.

== Ergebnisse der Evaluation

*FA1 Identifikation von CAP-Services.* Die #gls("Extension") erkennt Services automatisch in allen drei Testprojekten. Nach dem Öffnen eines Projekts werden die Services in der Sidebar unter "Services" angezeigt und nach Inbound und Outbound kategorisiert.

*FA2 Aggregierte Serviceübersicht.* Alle zu einem Service gehörenden Artefakte werden hierarchisch gruppiert dargestellt. Entities, Actions, Operations und zugehörige Dateien sind unter dem jeweiligen Service sichtbar. Die Aggregation ersetzt die manuelle Rekonstruktion der Service-Struktur über mehrere Dateien.

*FA3 Navigation zu Artefakten.* Ein Klick auf ein Artefakt im Tree öffnet die entsprechende Datei und positioniert den Cursor an der exakten Zeile der Definition. Die Positionsinformationen stammen vom #gls("Language Server") und sind präzise.

*FA4 Darstellung von Artefaktbeziehungen.* Die Extension zeigt hierarchische Beziehungen zwischen Artefakten. Ein Service enthält Entities, eine Entity enthält Actions und Fields. Referenzielle Associations zwischen Entities werden jedoch nicht dargestellt. Ein Feld wie `Agency` erscheint als normales Feld, ohne dass erkennbar ist, dass es auf eine andere Entity verweist. Dieser Limitation liegt zugrunde, dass der Language Server über `workspace/symbol` keine Typ-Auflösung für Felder bereitstellt. Eine Erweiterung würde zusätzliche LSP-Requests (`textDocument/definition` für jedes Feld) erfordern, was die Ladezeit signifikant erhöhen würde. Dies wurde als Trade-off zugunsten der Performance nicht implementiert.

*NFA1 Integration in Visual Studio Code.* Die #gls("Extension") ist als natives #gls("VS Code") Plugin implementiert und nutzt die TreeView #gls("API") für die hierarchische Darstellung. Die Installation erfolgt über eine #gls("VSIX")-Datei.

*NFA2 Kompatibilität mit CAP-Projektstrukturen.* Alle drei Testprojekte folgen dem #gls("CAP")-Standardlayout und werden korrekt erkannt. Die #gls("Extension") analysiert die Projektstruktur automatisch.

*NFA3 Performante Analyse.* @performance_chart zeigt die gemessenen Ladezeiten beim initialen Projektöffnen. Die Messungen erfolgten isoliert mit nur #gls("CDS") #gls("Language Server") und #gls("Extension") unter den im Anhang dokumentierten Testbedingungen (siehe @testumgebung_table). Jedes Projekt wurde dreimal geöffnet (#gls("VS Code") Neustart zwischen Messungen), die angegebenen Werte sind Durchschnittswerte. Die Messung umfasst die Zeit von "#gls("Extension") aktiviert" bis "Tree vollständig gerendert". Alle Projekte laden deutlich unter der 10-Sekunden-Schwelle (0.56s - 1.86s). Alle nachfolgenden Navigationsoperationen im Tree erfolgen unmittelbar (< 100ms), da die Datenstruktur bereits im Speicher liegt und lediglich #gls("UI")-Updates erforderlich sind.

#figure(
  supplement: [Abbildung],
  caption: [Ladezeiten der Extension nach Projektöffnung],
  lq.diagram(
    width: 8cm,
    height: 4cm,
    yaxis: (
      subticks: none,
      ticks: ((0, "bookshop"), (1, "xtravels"), (2, "ctsm-develop")),
    ),
    xaxis: (lim: (0, 2.5), subticks: none),
    xlabel: pad(bottom: 0.8em)[Sekunden],
    lq.hbar(
      (0.56, 1.55, 1.86),
      (0, 1, 2),
      width: 0.5,
      fill: rgb("#3b82f6"),
    ),
    lq.place(0.56, 0, align: left, pad(left: 0.3em)[0.56s]),
    lq.place(1.55, 1, align: left, pad(left: 0.3em)[1.55s]),
    lq.place(1.86, 2, align: left, pad(left: 0.3em)[1.86s]),
  )
)<performance_chart>

*NFA4 Aktualität der Artefaktübersicht.* Nach dem Speichern einer geänderten #gls("CDS")-Datei aktualisiert sich der Tree nicht automatisch. Ein manueller Refresh ist erforderlich. Die automatische Aktualisierung wurde im Rahmen dieser Arbeit als nicht kritisch priorisiert und kann in zukünftigen Versionen ergänzt werden, sobald der #gls("Language Server") entsprechende Optimierungen für schnellere Refresh-Zyklen bereitstellt.

@scenario_comparison zeigt die Reduktion des Navigationsaufwands anhand der in #ref(<anforderungsanalyse>) definierten Szenarien. Die detaillierten Navigationsabläufe sind im Anhang dokumentiert.

#figure(
  supplement: [Tabelle],
  caption: [Vergleich des Navigationsaufwands],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, auto, 2fr, 1.5fr),
    inset: (x: 8pt, y: 5pt),
    align: (left, left, left, left),
    stroke: 0.3pt + black,
    [*Szenario*], [*Projekt*], [*Ohne Extension*], [*Mit Extension*],

    table.cell(rowspan: 3)[Service verstehen],
    [bookshop], [3 Dateien, 9 Schritte], [2 Klicks im Tree],
    [xtravels], [4 Dateien, 12 Schritte], [3 Klicks im Tree],
    [ctsm-develop], [4 Dateien, 12 Schritte], [2 Klicks im Tree],

    table.cell(rowspan: 3)[Action lokalisieren],
    [bookshop], [2 Dateien, 6 Schritte], [2 Interaktionen],
    [xtravels], [3 Dateien, 9 Schritte], [2 Interaktionen],
    [ctsm-develop], [3 Dateien, 9 Schritte], [2 Interaktionen],

    table.cell(rowspan: 3)[Entities identifizieren],
    [bookshop], [2 Dateien, 6 Schritte], [1 Klick],
    [xtravels], [3 Dateien, 9 Schritte], [2 Klicks],
    [ctsm-develop], [3 Dateien, 9 Schritte], [1 Klick],
  )
]<scenario_comparison>

Die Extension reduziert den Navigationsaufwand in den evaluierten Szenarien um durchschnittlich 79% über drei Projekte und neun Szenarien hinweg. Die Aussagekraft dieser Metrik ist bei einer Stichprobe von drei Projekten begrenzt, eine statistische Generalisierbarkeit kann nicht beansprucht werden. @eval_uebersicht fasst die Ergebnisse zusammen.

#figure(
  supplement: [Tabelle],
  caption: [Übersicht der Anforderungserfüllung],
)[
  #set text(size: 9pt)
  #table(
    columns: (auto, 2fr, auto),
    inset: (x: 8pt, y: 5pt),
    align: (left, left, center),
    stroke: 0.3pt + black,
    [*ID*], [*Anforderung*], [*Status*],
    [FA1], [Identifikation von Services], [✓],
    [FA2], [Aggregierte Serviceübersicht], [✓],
    [FA3], [Navigation zu Artefakten], [✓],
    [FA4], [Darstellung von Beziehungen], [◐],
    [NFA1], [VS Code Integration], [✓],
    [NFA2], [CAP-Kompatibilität], [✓],
    [NFA3], [Performance], [✓],
    [NFA4], [Automatische Aktualisierung], [✗],
  )
  #text(size: 8pt)[✓ erfüllt #h(2em) ◐ teilweise erfüllt #h(2em) ✗ nicht erfüllt]
  #v(0.8em)
]<eval_uebersicht>

== Explorative Entwickler-Rückmeldungen

Ergänzend zur funktionalen Evaluation wurden explorative Rückmeldungen von zwei CAP-Entwicklern eingeholt (Details in Anhang C, @feedback_table). Die Teilnehmer testeten die Extension an unterschiedlichen Projekten (bookshop Sample vs. produktives System mit 131 Entities) und bestätigten die Benutzerfreundlichkeit (5/5). Die Navigationsaufwand-Reduktion wurde mit 3/5 bzw. 4/5 bewertet. Die Rückmeldungen identifizierten Verbesserungspotenziale (Sortierung bei großen Projekten, `extend`-Statement-Duplikate) und bestätigten die in NFA4 identifizierte Limitation der fehlenden automatischen Aktualisierung.

== Qualitative Beobachtungen

Neben den quantitativen Metriken wurden qualitative Aspekte der Benutzererfahrung beobachtet.

Die servicezentrierte Strukturierung ist intuitiv erfassbar. Die Trennung zwischen Inbound- und Outbound-Services folgt der fachlichen Logik und erleichtert die Orientierung in Projekten mit externen API-Abhängigkeiten. Die hierarchische Gruppierung (Services → Entities → Fields) entspricht dem mentalen Modell von CAP-Entwicklern, die in fachlichen Services denken, nicht in technischen Ordnern.

Die automatische Expansion beim Filtern reduziert manuelle Interaktionen. Treffer sind sofort sichtbar, ohne dass der User mehrere Ordner manuell öffnen muss. Die Hervorhebung von Suchtreffern im Tree erleichtert das Scannen großer Ergebnislisten. Die Kombination von Freitext-Suche und strukturierten Filtern (`@entity`, `@action`) ermöglicht präzise Abfragen ohne komplexe Syntax.

Die Integration der LSP-Features (Go to Definition, Find References, Go to Implementation) im Context-Menü fügt sich nahtlos in den gewohnten VS Code-Workflow ein. Die Hover-Tooltips mit Typ-Informationen und Flags reduzieren die Notwendigkeit, Dateien zu öffnen, nur um Metadaten zu prüfen. Die automatische Entdeckung von Implementierungsdateien erspart manuelle Suchen nach Handler-Dateien mit unklaren Namenskonventionen.

Als Limitation wurde beobachtet, dass die fehlende Association-Darstellung (FA4) bei komplexen Datenmodellen mit vielen Beziehungen zu Orientierungsschwierigkeiten führen kann. Ein Entwickler muss manuell über Go to Definition navigieren, um zu erkennen, dass ein Feld auf eine andere Entity verweist. Die manuelle Refresh-Notwendigkeit (NFA4) unterbricht den Arbeitsfluss bei iterativer Entwicklung, da Änderungen erst nach explizitem Reload sichtbar werden.

== Einordnung der Ergebnisse

Die Evaluation fokussiert auf die funktionale Prüfung der Anforderungen. Eine empirische Nutzerstudie mit Zeitmessungen war gemäß der Abgrenzung in #ref(<anforderungsanalyse>) nicht Bestandteil dieser Arbeit. Die Szenarien zeigen dennoch eine klare Reduktion des Navigationsaufwands um durchschnittlich 79%.

Die drei Testprojekte decken unterschiedliche Komplexitätsstufen ab, von einem kleinen Referenzprojekt bis zu einem produktiven Enterprise-Anwendungs-System. Die Architektur durch die Nutzung des Language Servers lässt eine gute Skalierbarkeit auch für größere Projekte erwarten.

Die Ergebnisse zeigen, dass die Extension das identifizierte Navigationsproblem adressiert und sechs von acht Anforderungen vollständig erfüllt. Die nicht erfüllte automatische Aktualisierung sowie die fehlende Association-Darstellung bieten Ansatzpunkte für zukünftige Erweiterungen.
