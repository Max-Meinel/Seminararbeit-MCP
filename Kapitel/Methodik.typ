#import "../vendor/supercharged-dhbw/lib.typ": *

= Methodik <methodik>

Diese Arbeit folgt dem #gls("DSR") Ansatz zur Entwicklung und Evaluation eines technischen Artefakts. Das zu entwickelnde Artefakt ist eine #gls("VS Code")-#gls("Extension"), die Entwickler bei der Navigation in #gls("SAP CAP")-Projekten unterstützen soll. Dieses Kapitel begründet zunächst die Wahl des methodischen Rahmens und beschreibt anschließend die konkrete Anwendung des DSR-Prozesses in dieser Arbeit.

== Design Science Research als methodischer Rahmen

Die Wahl der Forschungsmethode hängt vom Forschungsziel ab. Verhaltenswissenschaftliche Ansätze erklären bestehende Phänomene und entwickeln Theorien. #gls("DSR") hingegen konstruiert und evaluiert neue Artefakte zur Lösung identifizierter Probleme #cite(<Hevner_et_al_2004_Design_Science>, supplement: [p. 75]). Diese Arbeit entwickelt eine #gls("VS Code")-#gls("Extension") als konkretes technisches Artefakt, das Navigationsprobleme in #gls("CAP")-Projekten löst. #gls("DSR") ist daher die geeignete Forschungsmethode.

Alternative Forschungsansätze wurden geprüft und als ungeeignet befunden. Action Research ist ein Ansatz, bei dem Forscher aktiv in Veränderungsprozesse innerhalb einer Organisation eingreifen #cite(<Baskerville_Wood-Harper_1996_Action_Research>, supplement: [p. 235]). Die Methode durchläuft iterative Zyklen von Diagnose, Planung, Aktion und Evaluation. Sie setzt voraus, dass Forscher und Praktiker eng in einem spezifischen organisationalen Kontext zusammenarbeiten. Für diese Arbeit ist Action Research ungeeignet, da keine organisationale Intervention angestrebt wird, sondern die Entwicklung eines generischen Werkzeugs.

Case Study Research ermöglicht die tiefgehende Analyse von Phänomenen in ihrem natürlichen Kontext. Case Studies sind explorativ, deskriptiv oder explanatorisch und zielen darauf ab, existierende Phänomene zu verstehen #cite(<Runeson_Hoest_2009_Case_Study>, supplement: [p. 135]). Diese Arbeit hingegen entwickelt ein neues Artefakt und evaluiert dessen Eignung. Case Study Research ist daher nicht geeignet.

== Eignung von DSR für diese Arbeit

Die Anwendung von #gls("DSR") setzt voraus, dass das adressierte Problem bestimmte Charakteristika aufweist. Hevner et al. fordern, dass #gls("DSR") technologiebasierte Lösungen für wichtige und relevante Probleme entwickelt #cite(<Hevner_et_al_2004_Design_Science>, supplement: [p. 82]). Das Problem muss zudem durch Konstruktion und Evaluation eines IT-Artefakts adressierbar sein #cite(<Peffers_et_al_2008_DSRM>, supplement: [p. 49]). Diese Arbeit erfüllt diese Voraussetzungen aus folgenden Gründen.

Das Navigationsproblem in #gls("CAP")-Projekten ist praxisrelevant und der aktuelle Entwicklungsprozess ineffizient. Wie #ref(<anforderungsanalyse>) zeigt, ist die physische Verteilung servicebezogener Artefakte über verschiedene Verzeichnisse mit einem hohen Navigationsaufwand verbunden. Die dort quantifizierten Szenarien belegen die Ineffizienz durch die hohe Anzahl erforderlicher Kontextwechsel zwischen Dateien.

#gls("VS Code") bietet keine servicezentrierte Sicht auf #gls("CAP")-Projekte. Existierende Navigationswerkzeuge folgen der technischen Ordnerstruktur. Eine aggregierte Darstellung aller zu einem Service gehörenden Artefakte existiert nicht. Das Problem ist somit durch Konstruktion eines Artefakts adressierbar.

Die Konstruktion einer servicezentrierten Navigationshilfe ist nicht trivial. Hevner et al. charakterisieren #gls("DSR")-geeignete Probleme als "wicked problems", die durch komplexe Interaktionen zwischen Problemkomponenten und Lösung gekennzeichnet sind #cite(<Hevner_et_al_2004_Design_Science>, supplement: [p. 81]). Die Gewinnung von Service-Strukturinformationen erfordert semantisches Verständnis der #gls("CAP")-Architektur. #ref(<integrationsstrategien>) vergleicht drei Lösungsansätze mit unterschiedlichen Trade-offs. Diese Notwendigkeit eines systematischen Vergleichs belegt die Nicht-Trivialität des Problems und die Forschungswürdigkeit der Arbeit.

== Auswahl des DSR-Prozessmodells

Innerhalb von #gls("DSR") existieren verschiedene Prozessmodelle, die den Forschungsprozess unterschiedlich strukturieren. Diese Modelle unterscheiden sich in Detaillierungsgrad, Phasenstruktur und Anwendbarkeit auf konkrete Forschungsprojekte.

Das konzeptionelle Framework von Hevner et al. bietet eine grundlegende Struktur mit drei Säulen (Environment, Information Systems Research, Knowledge Base) und den Phasen Build und Evaluate #cite(<Hevner_et_al_2004_Design_Science>, supplement: [pp. 79–80, Fig. 2]). Dieses Framework eignet sich zur grundsätzlichen Einordnung von #gls("DSR")-Forschung, bietet jedoch keine detaillierte Prozessstruktur für die praktische Durchführung.

Dresch et al. definieren einen 12-schrittigen #gls("DSR")-Prozess #cite(<Dresch_et_al_2014_Design_Science_Research>, supplement: [pp. 118–124, Fig. 6.1]), der sich in drei methodische Phasen gliedert. Das Modell unterscheidet explizit zwischen abduktiven, deduktiven und induktiven Schlussformen. Diese Fundierung ist zwar methodisch wertvoll, führt jedoch zu einem hohen Detaillierungsgrad, der für eine anwendungsorientierte Bachelorarbeit nicht erforderlich ist.

Peffers et al. schlagen ein 6-Phasen-Prozessmodell vor, das speziell für Information Systems Research entwickelt wurde. Das Modell strukturiert #gls("DSR")-Forschung in die Phasen Problemidentifikation und Motivation, Zieldefinition, Entwurf und Entwicklung, Demonstration, Evaluation und Kommunikation #cite(<Peffers_et_al_2008_DSRM>, supplement: [pp. 52–54]). Dieses Modell ist ein weitverbreiteter Standard in der Information-Systems-Community und bietet einen guten Kompromiss zwischen Strukturierung und Praktikabilität.

Für diese Arbeit wurde das Prozessmodell von Peffers et al. gewählt. Die Begründung liegt in mehreren Faktoren. Erstens ist Peffers' Prozessmodell ein weitverbreiteter #gls("DSR")-Ansatz in der Information-Systems-Forschung, was die wissenschaftliche Anerkennung der Methodik stärkt. Zweitens ist das Modell explizit prozessgetrieben und flexibel: Peffers et al. beschreiben verschiedene Einstiegspunkte in den Prozess (problem-centered, objective-centered, design-centered, client-context-initiated) #cite(<Peffers_et_al_2008_DSRM>, supplement: [p. 56]), was die Anwendbarkeit auf unterschiedliche Forschungskontexte erhöht. Drittens bietet die 6-Phasen-Struktur einen klaren Rahmen, der im Vergleich zu Dresch's 12 Schritten keine unnötige Komplexität einführt. Viertens enthält das Modell eine explizite Demonstration-Phase, die ideal zur prototypischen Implementierung dieser Arbeit passt, während Hevner's Framework diese Phase nicht explizit ausweist.

== Anwendung des DSR-Prozesses in dieser Arbeit

Die sechs Phasen des #gls("DSR")-Prozesses nach Peffers et al. #cite(<Peffers_et_al_2008_DSRM>, supplement: [pp. 52–56]) strukturieren den Forschungsprozess dieser Arbeit. Die Phasen dienen als methodischer Rahmen, während die Kapitelstruktur der fachlichen Logik des Untersuchungsgegenstands folgt.

*Phase 1: Problemidentifikation und Motivation*\
#ref(<anforderungsanalyse>) identifiziert das Navigationsproblem in #gls("CAP")-Projekten durch Analyse typischer Repository-Strukturen und quantifiziert den Navigationsaufwand anhand repräsentativer Entwicklungsszenarien.

*Phase 2: Zieldefinition*\
Ebenfalls in #ref(<anforderungsanalyse>) werden aus den identifizierten Herausforderungen lösungsneutrale Designziele abgeleitet und in konkrete funktionale sowie nicht-funktionale Anforderungen überführt.

*Phase 3: Entwurf und Entwicklung*\
#ref(<integrationsstrategien>) vergleicht drei Integrationsstrategien zur Gewinnung von Service-Strukturinformationen mittels #gls("Nutzwertanalyse") und wählt die vorteilhafteste aus. #ref(<implementierung>) implementiert die gewählte Strategie als #gls("VS Code")-#gls("Extension").

*Phase 4: Demonstration*\
#ref(<implementierung>) demonstriert die praktische Anwendbarkeit der #gls("Extension") am Bookshop-Referenzprojekt.

*Phase 5: Evaluation*\
#ref(<evaluation>) evaluiert das Artefakt kriterienbasiert anhand der definierten Anforderungen durch praktische Erprobung an repräsentativen #gls("CAP")-Projekten.

*Phase 6: Kommunikation*\
#ref(<diskussion-fazit>) interpretiert die Ergebnisse, diskutiert Limitationen, fasst die Erkenntnisse zusammen und reflektiert den Beitrag zur Wissensbasis. Diese Arbeit selbst stellt die primäre Kommunikationsform dar.
