#import "../vendor/supercharged-dhbw/lib.typ": *

= Einleitung

Dieses Kapitel führt in das Thema der Arbeit ein und beschreibt die Motivation, Problemstellung sowie Zielsetzung. Darüber hinaus wird der Aufbau der Arbeit dargelegt.

== Motivation

Ein Entwickler öffnet ein #gls("SAP CAP")-Projekt und soll einen Service verstehen. Die Service-Definition steht in `srv/`, die zugehörigen Entities in `db/`, die Event Handler in separaten Implementierungsdateien. Um den Service vollständig zu verstehen, muss der Entwickler zwischen mehreren Dateien navigieren und separate Kontextwechsel durchführen. Die Quantifizierung dieses Aufwands erfolgt in #ref(<anforderungsanalyse>).

#gls("SAP CAP") ist ein Framework zur Entwicklung von #gls("Enterprise-Anwendung")en, das auf dem Prinzip der #gls("Separation of Concerns") basiert #cite(<cap-bookshop-soc>, supplement: [Sec. Separation of Concerns]). Die Trennung von Domänenmodell (`db/`), Services (`srv/`) und #gls("UI") (`app/`) folgt etablierten Architekturprinzipien und unterstützt die Wartbarkeit skalierender Projekte #cite(<Nierstrasz_Achermann_2000_SoC>, supplement: [p. 38]). Diese Struktur hat jedoch eine Konsequenz. Ein einzelner Service, die zentrale fachliche Einheit, ist kein einzelnes Artefakt, sondern verteilt sich über viele Dateien in verschiedenen Ordnern.

Die Folge ist ein erhöhter Navigationsaufwand. Entwickler müssen die Struktur eines Services aus verschiedenen Dateien manuell rekonstruieren. Jeder Kontextwechsel zwischen Dateien unterbricht den Gedankenfluss und erhöht die #gls("Kognitive Belastung"). Diese Problematik verschärft sich mit zunehmender Projektgröße. Die Evaluation in #ref(<evaluation>) zeigt, dass in produktiven Projekten mit mehreren Services und verschachtelten Verzeichnissen die Rekonstruktion der Service-Struktur deutlich mehr Aufwand erfordert als in kleinen Beispielprojekten.

== Problemstellung

Moderne Entwicklungsumgebungen wie #gls("VS Code") bieten Navigationsfunktionen wie #gls("Go-to-Definition"), #gls("Outline-Ansicht")en und File Explorer #cite(<vscode-goto>, supplement: [Sec. Go to Definition]) #cite(<vscode-outline>, supplement: [Sec. Outline View]). Diese Werkzeuge operieren jedoch datei- oder symbolzentriert, nicht servicezentriert. Eine aggregierte Sicht, die alle zu einem Service gehörenden Artefakte in einer einheitlichen Übersicht bündelt, existiert nicht.

Ein #gls("CAP")-Service besteht aus mehreren konzeptionellen Ebenen, die physisch voneinander getrennt sind. Die Service-Identität ergibt sich erst aus dem Zusammenspiel von Datenmodell, #gls("API")-Schnittstelle, Implementierung und Sicherheitsregeln. Beziehungen zwischen Artefakten sind referenziell, nicht visuell. Entwickler müssen die Struktur eines Services aus verschiedenen Dateien manuell rekonstruieren.

== Zielsetzung der Arbeit

Diese Arbeit entwickelt eine #gls("VS Code") #gls("Extension"), die eine servicezentrierte Sicht auf #gls("CAP")-Projekte bereitstellt. Die #gls("Extension") aggregiert alle zu einem Service gehörenden Artefakte in einer hierarchischen Baumansicht und ermöglicht direkte Navigation zu den entsprechenden Quellcode-Positionen. Das Ziel ist die Reduktion von Navigations- und Kontextwechseln, um Entwicklern ein schnelleres Verständnis und effizientere Bearbeitung von Services zu ermöglichen.

Die Entwicklung folgt dem #gls("DSR") Ansatz nach Peffers et al. #cite(<Peffers_et_al_2008_DSRM>, supplement: [pp. 52–56]). #gls("DSR") ist eine Forschungsmethode, die darauf abzielt, Artefakte zur Lösung identifizierter Probleme zu konstruieren und zu evaluieren #cite(<Hevner_et_al_2004_Design_Science>, supplement: [p. 75]). Die Arbeit durchläuft die sechs Phasen des DSR-Prozesses, nämlich Problemidentifikation, Zieldefinition, Entwurf und Entwicklung, Demonstration, Evaluation und Kommunikation.

Die zentrale Herausforderung liegt in der Gewinnung von Service-Strukturinformationen aus #gls("CAP")-Projekten. Drei Integrationsstrategien werden entwickelt und mittels #gls("Nutzwertanalyse") verglichen. Die vorteilhafteste Strategie wird prototypisch implementiert und anhand konkreter Entwicklungsszenarien in #gls("CAP")-Projekten unterschiedlicher Größe evaluiert.

== Aufbau der Arbeit

Die Arbeit gliedert sich wie folgt. #ref(<grundlagen>) vermittelt die technischen Grundlagen zu #gls("SAP CAP"), #gls("CDS"), #gls("CSN"), #gls("LSP") und #gls("VS Code") #gls("Extension") Architektur. #ref(<methodik>) begründet die Wahl des #gls("DSR") Ansatzes als methodischen Rahmen und ordnet die Phasen den Kapiteln zu. #ref(<anforderungsanalyse>) analysiert das Navigationsproblem in #gls("CAP")-Projekten, quantifiziert den Navigationsaufwand anhand repräsentativer Szenarien und leitet funktionale sowie nicht-funktionale Anforderungen ab. #ref(<integrationsstrategien>) entwickelt und vergleicht drei Integrationsstrategien zur Gewinnung von Service-Strukturinformationen mittels #gls("Nutzwertanalyse"). #ref(<implementierung>) beschreibt die prototypische Implementierung der #gls("Extension") basierend auf der gewählten Strategie. #ref(<evaluation>) evaluiert die #gls("Extension") anhand der definierten Anforderungen in drei Testprojekten und quantifiziert die Reduktion des Navigationsaufwands. #ref(<diskussion-fazit>) diskutiert die Ergebnisse, benennt Limitationen, gibt einen Ausblick auf zukünftige Arbeiten und fasst die Erkenntnisse zusammen.
