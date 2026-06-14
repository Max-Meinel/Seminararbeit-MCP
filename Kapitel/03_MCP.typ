#import "../vendor/supercharged-dhbw/lib.typ": *

= Model Context Protocol <mcp-kapitel>

== Entstehung und Zielsetzung

Anthropic veröffentlichte das #acr("MCP") im November 2024 als offenen Standard für die Anbindung externer Werkzeuge und Datenquellen an #acr("KI")-Anwendungen @anthropic2024mcp. Das Protokoll definiert eine einheitliche, bidirektionale Kommunikations- und Discovery-Schicht zwischen Sprachmodellen und externen Diensten und orientiert sich konzeptionell am Language Server Protocol aus der Entwicklungswerkzeug-Welt @hou2025mcp. Im Unterschied zum herkömmlichen Function Calling entkoppelt das #acr("MCP") die Implementierung eines Werkzeugs von seiner Nutzung. Werkzeuge werden nicht mehr fest in eine Anwendung einprogrammiert, sondern zur Laufzeit entdeckt, beschrieben und in einheitlicher Form aufgerufen @hou2025mcp. Guo et al. vergleichen den Anspruch des Protokolls mit der Rolle, die #acrs("HTTP") für das Web einnimmt, nämlich der eines vereinheitlichenden Integrationsstandards @guo2025measurement.

Das Protokoll hat sich seit seiner Veröffentlichung schnell verbreitet. Tausende unabhängig entwickelte Server stellen Schnittstellen zu Diensten wie GitHub, Slack oder Datenbanken bereit @hou2025mcp. Auch über das Anthropic-Ökosystem hinaus wird das Protokoll eingesetzt; Radosevich und Halloran nennen offizielle Integrationen unter anderem von OpenAI, Microsoft und Stripe @radosevich2025audit. Damit ist das #acr("MCP") innerhalb weniger Monate von einem Herstellerprotokoll zu einer Basisinfrastruktur für agentenbasierte Anwendungen geworden.

== Architektur und Komponenten

Die Architektur des #acr("MCP") besteht aus drei Komponenten: Host, Client und Server @hou2025mcp. Der Host ist die #acr("KI")-Anwendung selbst, etwa ein Chat-Client wie Claude Desktop oder eine Entwicklungsumgebung wie Cursor. Er führt das Sprachmodell aus und bettet einen oder mehrere #acr("MCP")-Clients ein. Jeder Client unterhält eine Eins-zu-eins-Verbindung zu genau einem #acr("MCP")-Server, fragt dessen Funktionen ab und leitet Aufrufe und Antworten zwischen Host und Server weiter. Der Server kapselt den Zugriff auf ein externes System, beispielsweise einen Webdienst, eine Datenbank oder das lokale Dateisystem, und stellt dessen Funktionen in standardisierter Form bereit @hou2025mcp.

Die Kommunikation zwischen Client und Server erfolgt über #acr("JSON-RPC")-Nachrichten @anthropic2024mcp. Als Transportmechanismen sieht die Spezifikation die Standard-Datenströme (stdio) für lokal gestartete Server sowie #acrs("HTTP")-basierte Transporte mit #acr("SSE") für entfernte Server vor @anthropic2024mcp. Beim Verbindungsaufbau handeln Client und Server zunächst ihre Fähigkeiten aus. Der Server liefert eine Liste seiner verfügbaren Funktionen samt Beschreibungen, die der Host dem Sprachmodell als Kontext bereitstellt @hou2025mcp.

Eine typische Anfrage durchläuft damit folgenden Ablauf: Das Sprachmodell wählt aus den gemeldeten Funktionen ein passendes Werkzeug, der Client übermittelt den Aufruf an den zuständigen Server, dieser führt die Operation gegen das externe System aus und der Host gibt das Ergebnis als Kontext an das Modell zurück @hou2025mcp.

== Kernfunktionen

Ein #acr("MCP")-Server bietet drei Arten von Fähigkeiten an: Tools, Resources und Prompts @anthropic2024mcp. Tools sind ausführbare Operationen wie das Lesen einer Datei oder der Aufruf einer externen #acrs("API"). Im Unterschied zu anbieterspezifischen Function-Calling-Schnittstellen werden sie über ein modellunabhängiges Protokoll beschrieben und können dadurch von beliebigen Hosts dynamisch entdeckt und aufgerufen werden @hou2025mcp.

Resources stellen dem Modell Daten ohne Seiteneffekt bereit, etwa Dateiinhalte oder Datenbankauszüge. Prompts sind vordefinierte Eingabevorlagen für wiederkehrende Aufgaben @hou2025mcp. Die Unterscheidung ist sicherheitlich relevant, weil Tools aktive Operationen mit Seiteneffekten ausführen, während Resources und Prompts Inhalte in den Modellkontext einbringen und damit das Verhalten des Modells beeinflussen können.

== Sicherheitsrelevante Designentscheidungen <sicherheitsrelevante-designentscheidungen>

Die Spezifikation benennt Sicherheitsprinzipien, überlässt deren Durchsetzung aber den Implementierungen. Sie fordert, dass Nutzer jedem Werkzeugaufruf und jedem Datenzugriff explizit zustimmen, dass Hosts vor der Weitergabe von Daten an Server die Freigabe einholen und dass Werkzeugbeschreibungen als nicht vertrauenswürdig zu behandeln sind, sofern sie nicht von einem verifizierten Server stammen @anthropic2024mcp. Zugleich stellt die Spezifikation klar, dass das Protokoll diese Prinzipien nicht auf Protokollebene erzwingen kann; sie sind als Empfehlungen an die Implementierer formuliert @anthropic2024mcp.

Bewusst offen gelassen hat das Design zentrale Kontrollmechanismen. Es existiert kein verbindliches offizielles Verzeichnis geprüfter Server, keine verpflichtende Signierung von Serverpaketen und keine zentrale Verifikation von Werkzeugbeschreibungen. Hou et al. identifizieren Sicherheit und Tool-Discovery entsprechend als die wesentlichen ungelösten Bereiche des jungen Ökosystems @hou2025mcp.

Wie sich diese Lücken praktisch auswirken, zeigt die Messstudie von Guo et al. über sechs inoffizielle #acr("MCP")-Marktplätze. Von 17630 erfassten Einträgen erweisen sich weniger als die Hälfte als valide Projekte, der Rest besteht aus Platzhaltern, Forks oder aufgegebenen Prototypen. Rund 22 Prozent der validen Server werden seit über einem Jahr nicht mehr gepflegt, und etwa 11 Prozent enthalten Code, der potenziell sensible #acrs("API", plural: true) wie Authentifizierungsdienste anspricht @guo2025measurement. Nutzer installieren Server aus diesen Quellen damit weitgehend ungeprüft, während die Einhaltung der Zustimmungsprinzipien vom jeweiligen Host abhängt. Diese Kombination aus mächtigen Werkzeugzugriffen und fehlender zentraler Kontrolle bildet die Grundlage für die Angriffsvektoren, die das folgende Kapitel systematisch analysiert.
