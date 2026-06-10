#import "../vendor/supercharged-dhbw/lib.typ": *

= Diskussion und Fazit <diskussion-fazit>

Dieses Kapitel bildet die sechste Phase des DSR-Prozesses nach Peffers et al. @Peffers_et_al_2008_DSRM. Die Kommunikationsphase dient der Reflexion und Einordnung der Ergebnisse. Im Folgenden werden die Evaluationsergebnisse interpretiert, Limitationen benannt und Ansatzpunkte für zukünftige Arbeiten aufgezeigt.

== Diskussion der Ergebnisse

Die Evaluation zeigt, dass die Extension das identifizierte Navigationsproblem adressiert. Die gemessene Reduktion des Navigationsaufwands um durchschnittlich 79% in den evaluierten Szenarien bestätigt die zentrale Annahme dieser Arbeit. Die technische Ordnerstruktur von CAP-Projekten erschwert das Verständnis einzelner Services, und eine servicezentrierte Sicht kann dieses Problem lösen.

Die Generalisierbarkeit dieser Ergebnisse ist durch die Stichprobengröße von drei Projekten limitiert. Eine Evaluation an einer größeren Projektmenge (N>10) würde die Aussagekraft der 79%-Reduktion erhöhen und statistische Signifikanz ermöglichen.

Die Wahl der Language Server-basierten Integration hat sich als richtig erwiesen. Die Nutzwertanalyse in #ref(<integrationsstrategien>) identifizierte diese Strategie als vorteilhafteste Option, und die Evaluation bestätigt diese Einschätzung. Der Language Server liefert präzise Positionsinformationen, die eine zeilengenaue Navigation ermöglichen. Die semantische Genauigkeit ist durch die Nutzung des CAP-Compilers garantiert. Ein eigener Parser hätte diesen Grad an Zuverlässigkeit nicht erreichen können.

== Wissenschaftlicher Beitrag

Diese Arbeit liefert einen Beitrag in drei Bereichen.

*Methodisch* demonstriert die Arbeit die Anwendung des DSR-Ansatzes auf Navigationsprobleme in domänengetriebenen Frameworks. Die Nutzwertanalyse in #ref(<integrationsstrategien>) vergleicht drei Integrationsstrategien anhand von neun gewichteten Kriterien. Diese systematische Entscheidungsfindung ist auf andere Werkzeugentwicklungen übertragbar, die zwischen Parser-basierter, Compiler-basierter und Language Server-basierter Integration wählen müssen.

*Praktisch* liefert das entwickelte Artefakt eine funktionierende VS Code Extension @vscode-cds-explorer. Der implementierte Beitrag zum CDS Language Server (x-Flag in workspace/symbol) @cds-lsp-release-9-9-0 erweitert dessen API um servicezentrierte Metadaten. Diese Erweiterung ist permanent in den Language Server integriert und steht anderen Tools zur Verfügung.

*Empirisch* quantifiziert die Arbeit den Navigationsaufwand in CAP-Projekten anhand konkreter Szenarien. Die gemessene durchschnittliche Reduktion um 79% basiert auf reproduzierbaren Szenarien in drei Projekten unterschiedlicher Größe und liefert eine empirische Grundlage für zukünftige Untersuchungen zum Zusammenhang zwischen Projektgröße und Navigationskomplexität.

== Limitationen

Die Extension erfüllt sechs von acht Anforderungen vollständig. Zwei Anforderungen sind nicht oder nur teilweise erfüllt.

Die automatische Aktualisierung der Artefaktübersicht ist nicht implementiert. Nach dem Speichern einer geänderten CDS-Datei muss der Entwickler den Tree manuell aktualisieren. Diese Einschränkung beeinträchtigt den Arbeitsfluss, ist aber technisch lösbar. Die VS Code API bietet File-Watcher-Events, die eine automatische Aktualisierung ermöglichen würden.

Die Darstellung referenzieller Associations zwischen Entities ist nicht umgesetzt. VS Code's TreeView API ist auf hierarchische Strukturen ausgelegt, während Associations Graph-Strukturen darstellen. Eine Visualisierung dieser Beziehungen würde alternative UI-Patterns erfordern, die nicht Teil der TreeView-Architektur sind. Dies stellt ein architektonisches Limit der gewählten Darstellungsform dar.

Die Evaluation basiert auf drei Testprojekten und einer qualitativen Analyse der Navigationsszenarien. Die gemessene Reduktion um 79% ist reproduzierbar, aber bei einer Stichprobengröße von drei Projekten nicht statistisch generalisierbar. Eine empirische Nutzerstudie mit Zeitmessungen, größerer Projektanzahl und Entwickler-Befragungen könnte zusätzliche Erkenntnisse zur tatsächlichen Produktivitätssteigerung und statistischen Signifikanz liefern. Die Szenarien wurden manuell definiert und gezählt, was eine gewisse Subjektivität birgt. Eine automatisierte Metrik-Erfassung über User-Tracking würde objektivere Daten liefern.

== Praktische Implikationen

Die Ergebnisse haben praktische Implikationen für #gls("CAP")-Entwickler und Werkzeughersteller.

Für CAP-Entwickler zeigt die Evaluation, dass servicezentrierte Navigation den Navigationsaufwand messbar reduziert, wobei der Mehrwert mit der Projektgröße steigt. Die Ladezeiten von 0.56s bis 1.86s liegen unter der Wahrnehmungsschwelle, sodass die Extension den Arbeitsfluss nicht unterbricht.

Für Werkzeughersteller demonstriert die Arbeit, dass Language Server als Integrationsschicht eine tragfähige Architektur darstellen. Die Erweiterung des CDS Language Servers um das x-Flag zeigt, dass domänenspezifische Metadaten in LSP-konforme Strukturen eingebettet werden können, ohne die Standardkonformität zu verletzen. Die Extension nutzt ausschließlich Standard-LSP-Requests (`workspace/symbol`, `textDocument/hover`, `textDocument/implementation`), was die Wartbarkeit und Erweiterbarkeit sichert.

Die Arbeit zeigt, dass das CAP-Prinzip der Separation of Concerns und die Entwickler-Erfahrung nicht im Widerspruch stehen müssen. Die physische Trennung der Artefakte bleibt erhalten, während Werkzeuge eine logische Aggregation bereitstellen. Dies vermeidet einen Zielkonflikt zwischen Architekturprinzipien und Usability.

== Ausblick

Die nicht erfüllten Anforderungen bieten Ansatzpunkte für zukünftige Erweiterungen.

Die Implementierung der automatischen Aktualisierung würde den Arbeitsfluss verbessern. Durch Registrierung auf File-Watcher-Events könnte die Extension Änderungen an CDS-Dateien erkennen und den Tree automatisch aktualisieren. Dies würde NFA4 vollständig erfüllen.

Die Visualisierung von Associations würde das Verständnis von Datenmodellen erleichtern. Da TreeView nur hierarchische Strukturen unterstützt, würde dies alternative UI-Patterns erfordern. Mögliche Ansätze wären Hover-Tooltips, die das Ziel einer Association anzeigen, oder klickbare Verweise, die direkt zur referenzierten Entity navigieren. Eine separate Graph-Ansicht für Datenmodell-Beziehungen wäre eine umfassendere Lösung, würde aber die Komplexität der Extension deutlich erhöhen. Die explorativen Entwickler-Rückmeldungen liefern zusätzliche Verbesserungsvorschläge: Sortierung nach Name bei großen Projekten (>100 Entities), Darstellung von Annotations über `annotate`-Statements, und Namespace-Gruppierung zur besseren Strukturierung bei verschachtelten Modellen.

Eine Nutzerstudie könnte die quantitativen Ergebnisse dieser Arbeit ergänzen. Messungen der tatsächlichen Zeitersparnis und Befragungen zur Zufriedenheit würden die praktische Relevanz der Extension validieren.

== Reflexion der Forschungsmethode

Die Anwendung des DSR-Ansatzes nach Peffers et al. hat sich für diese Arbeit als geeignet erwiesen. Die strukturierte Progression durch die sechs Phasen gewährleistete eine systematische Entwicklung des Artefakts. Die Problemidentifikation in Phase 1 lieferte konkrete Szenarien mit quantifizierten Navigationsschritten. Die Nutzwertanalyse in Phase 3 führte zu einer nachvollziehbaren Strategiewahl. Die Evaluation in Phase 5 validierte die Zielerreichung anhand der definierten Anforderungen.

Eine Limitation ist die einmalige Iteration zwischen Build und Evaluate. Mehrere Build-Evaluate-Zyklen hätten möglicherweise zusätzliche Verbesserungspotenziale identifiziert. Die Evaluation in Phase 5 identifizierte Limitationen (automatische Aktualisierung, Association-Darstellung), die in einer zweiten Iteration hätten adressiert werden können. Der Zeitrahmen einer Bachelorarbeit begrenzt jedoch die Anzahl möglicher Iterationen. Peffers et al. beschreiben DSR explizit als iterativen Prozess @Peffers_et_al_2008_DSRM, diese Arbeit realisiert jedoch nur einen Durchlauf.

Die Evaluation basiert auf Szenarien und qualitativen Beobachtungen, nicht auf empirischen Nutzerstudien mit Entwicklern. Die gemessene Reduktion von 79% ist reproduzierbar, aber nicht durch Zeitmessungen mit Probanden validiert. Eine partizipative DSR-Methode mit stärkerer Nutzerbeteiligung hätte zusätzliche Erkenntnisse zur Akzeptanz und tatsächlichen Nutzung liefern können. Dies war jedoch gemäß der Abgrenzung in #ref(<anforderungsanalyse>) nicht Bestandteil dieser Arbeit.

== Fazit

Diese Arbeit entwickelt und evaluiert eine VS Code Extension zur servicezentrierten Navigation in SAP CAP-Projekten. Das Ausgangsproblem ist die Verteilung servicebezogener Artefakte über mehrere Dateien und Verzeichnisse, die das Verständnis einzelner Services erschwert.

Die Arbeit folgt dem DSR Ansatz nach Peffers et al. und durchläuft alle sechs Phasen des Prozessmodells. Die Anforderungsanalyse identifiziert das Navigationsproblem und quantifiziert den Aufwand anhand konkreter Szenarien. Der Vergleich dreier Integrationsstrategien mittels Nutzwertanalyse führt zur Auswahl der Language Server-basierten Integration. Die Implementierung setzt diese Strategie als VS Code Extension um.

Die Evaluation an drei Testprojekten unterschiedlicher Größe zeigt eine durchschnittliche Reduktion des Navigationsaufwands um 79%. Sechs von acht Anforderungen werden vollständig erfüllt. Die Extension aggregiert alle servicebezogenen Artefakte in einer hierarchischen Ansicht und ermöglicht präzise Navigation zu Quellcode-Positionen.

Das entwickelte Artefakt löst das identifizierte Problem und bietet einen konkreten Mehrwert für CAP-Entwickler. Die servicezentrierte Sicht ergänzt die dateibasierte Navigation und reduziert den kognitiven Aufwand beim Verstehen und Bearbeiten von Services.