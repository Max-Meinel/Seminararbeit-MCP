#import "../vendor/supercharged-dhbw/lib.typ": *
#import "@preview/fletcher:0.5.8": diagram, node, edge

= Model Context Protocol <mcp-kapitel>

== Entstehung und Zielsetzung

Anthropic veröffentlichte das #acr("MCP") im November 2024 als offenen Standard für die Anbindung externer Werkzeuge und Datenquellen an #acr("KI")-Anwendungen @anthropic2024mcp. Das Protokoll definiert eine einheitliche, bidirektionale Kommunikations- und Discovery-Schicht zwischen Sprachmodellen und externen Diensten und orientiert sich konzeptionell am Language Server Protocol aus der Entwicklungswerkzeug-Welt @hou2025mcp. Im Unterschied zum herkömmlichen Function Calling entkoppelt das #acr("MCP") die Implementierung eines Werkzeugs von seiner Nutzung. Werkzeuge werden nicht mehr fest in eine Anwendung einprogrammiert, sondern zur Laufzeit entdeckt, beschrieben und in einheitlicher Form aufgerufen @hou2025mcp. Guo et al. vergleichen den Anspruch des Protokolls mit der Rolle, die #acrs("HTTP") für das Web einnimmt, nämlich der eines vereinheitlichenden Integrationsstandards @guo2025measurement.

Das Protokoll hat sich seit seiner Veröffentlichung schnell verbreitet. Tausende unabhängig entwickelte Server stellen Schnittstellen zu Diensten wie GitHub, Slack oder Datenbanken bereit @hou2025mcp. Auch über das Anthropic-Ökosystem hinaus wird das Protokoll eingesetzt; Radosevich und Halloran nennen offizielle Integrationen unter anderem von OpenAI, Microsoft und Stripe @radosevich2025audit. Damit ist das #acr("MCP") innerhalb weniger Monate von einem Herstellerprotokoll zu einer Basisinfrastruktur für agentenbasierte Anwendungen geworden.

== Architektur und Komponenten

Die Architektur des #acr("MCP") besteht aus drei Komponenten: Host, Client und Server @hou2025mcp. Der Host ist die #acr("KI")-Anwendung selbst, etwa ein Chat-Client wie Claude Desktop oder eine Entwicklungsumgebung wie Cursor. Er führt das Sprachmodell aus und bettet einen oder mehrere #acr("MCP")-Clients ein. Jeder Client unterhält eine Eins-zu-eins-Verbindung zu genau einem #acr("MCP")-Server, fragt dessen Funktionen ab und leitet Aufrufe und Antworten zwischen Host und Server weiter. Der Server kapselt den Zugriff auf ein externes System, beispielsweise einen Webdienst, eine Datenbank oder das lokale Dateisystem, und stellt dessen Funktionen in standardisierter Form bereit @hou2025mcp. @fig-mcp-architektur zeigt das Zusammenspiel der Komponenten im Überblick.

#figure(
  caption: [Architektur des Model Context Protocol (eigene Darstellung in Anlehnung an @hou2025mcp)],
  diagram(
    spacing: (58pt, 13pt),
    node-stroke: 0.6pt,
    node-corner-radius: 2pt,
    node-inset: 6pt,
    {
      let box-width = 74pt
      let inner(pos, body, name) = node(pos, text(size: 9pt, body), name: name, width: box-width)
      let group-label(pos, body, name) = node(pos, text(size: 9pt)[*#body*], stroke: none, name: name)
      // Nutzer
      node((0, 0.78), [Nutzer], stroke: none, name: <user>)
      // MCP-Host
      group-label((1, -0.25), [MCP-Host], <host-label>)
      inner((1, 0.5), [Sprachmodell], <llm>)
      inner((1, 1.8), [MCP-Client], <client>)
      node(enclose: (<host-label>, <llm>, <client>), inset: 9pt, stroke: 0.8pt, name: <host>)
      // MCP-Server
      group-label((2.5, -0.25), [MCP-Server], <server-label>)
      inner((2.5, 0.5), [Tools], <tools>)
      inner((2.5, 1.15), [Resources], <res>)
      inner((2.5, 1.8), [Prompts], <prompts>)
      node(enclose: (<server-label>, <tools>, <res>, <prompts>), inset: 9pt, stroke: 0.8pt, name: <server>)
      // Externe Systeme
      group-label((4, -0.25), [Externe Systeme], <ext-label>)
      inner((4, 0.5), [Webdienst], <web>)
      inner((4, 1.15), [Datenbank], <db>)
      inner((4, 1.8), [Dateisystem], <fs>)
      node(enclose: (<ext-label>, <web>, <db>, <fs>), inset: 9pt, stroke: (dash: "dashed", thickness: 0.8pt), name: <ext>)
      // Verbindungen
      edge(<user>, <host>, "<->")
      edge(<host>, <server>, "<->", label: text(size: 8pt)[JSON-RPC #linebreak() (1:1)], label-sep: 3pt, label-fill: white)
      edge(<server>, <ext>, "<->", label: text(size: 8pt)[API-Zugriff], label-sep: 3pt, label-fill: white)
    },
  ),
) <fig-mcp-architektur>

Die Kommunikation zwischen Client und Server erfolgt über #acr("JSON-RPC")-Nachrichten @anthropic2024mcp. Als Transportmechanismen sieht die Spezifikation die Standard-Datenströme (stdio) für lokal gestartete Server sowie #acrs("HTTP")-basierte Transporte mit #acr("SSE") für entfernte Server vor @anthropic2024mcp. Beim Verbindungsaufbau handeln Client und Server zunächst ihre Fähigkeiten aus. Der Server liefert eine Liste seiner verfügbaren Funktionen samt Beschreibungen, die der Host dem Sprachmodell als Kontext bereitstellt @hou2025mcp.

Eine typische Anfrage durchläuft damit folgenden Ablauf: Der Nutzer formuliert eine Eingabe an den Host, das Sprachmodell analysiert die Absicht und wählt aus den gemeldeten Funktionen ein passendes Werkzeug aus. Der Client übermittelt den Aufruf an den zuständigen Server, der die Operation gegen das externe System ausführt und das Ergebnis zurückliefert. Der Host führt das Ergebnis in den Kontext des Modells zurück, das daraus die Antwort an den Nutzer erzeugt @hou2025mcp.

== Kernfunktionen

Ein #acr("MCP")-Server bietet drei Arten von Fähigkeiten an: Tools, Resources und Prompts @anthropic2024mcp. Tools sind ausführbare Operationen, die der Server im Auftrag des Modells durchführt, etwa das Lesen einer Datei, das Versenden einer Nachricht oder der Aufruf einer externen #acrs("API"). Anders als bei anbieterspezifischen Function-Calling-Schnittstellen werden Tools über ein modellunabhängiges Protokoll beschrieben und können dadurch von beliebigen Hosts dynamisch entdeckt und aufgerufen werden @hou2025mcp.

Resources stellen dem Modell Daten zur Verfügung, ohne selbst Aktionen auszuführen, beispielsweise Dateiinhalte, Datenbankauszüge oder Dokumente. Prompts sind vordefinierte Eingabevorlagen und Arbeitsabläufe, die der Server bereitstellt, um wiederkehrende Aufgaben zu vereinheitlichen @hou2025mcp. Die Unterscheidung ist sicherheitlich relevant: Tools führen aktive Operationen mit Seiteneffekten aus, während Resources und Prompts Inhalte in den Modellkontext einbringen, die das Verhalten des Modells beeinflussen können.

== Sicherheitsrelevante Designentscheidungen <sicherheitsrelevante-designentscheidungen>

Die Spezifikation benennt Sicherheitsprinzipien, überlässt deren Durchsetzung aber den Implementierungen. Sie fordert, dass Nutzer jedem Werkzeugaufruf und jedem Datenzugriff explizit zustimmen, dass Hosts vor der Weitergabe von Daten an Server die Freigabe einholen und dass Werkzeugbeschreibungen als nicht vertrauenswürdig zu behandeln sind, sofern sie nicht von einem verifizierten Server stammen @anthropic2024mcp. Zugleich stellt die Spezifikation klar, dass das Protokoll diese Prinzipien nicht auf Protokollebene erzwingen kann; sie sind als Empfehlungen an die Implementierer formuliert @anthropic2024mcp.

Bewusst offen gelassen hat das Design zentrale Kontrollmechanismen. Es existiert kein verbindliches offizielles Verzeichnis geprüfter Server, keine verpflichtende Signierung von Serverpaketen und keine zentrale Verifikation von Werkzeugbeschreibungen. Hou et al. identifizieren Sicherheit und Tool-Discovery entsprechend als die wesentlichen ungelösten Bereiche des jungen Ökosystems @hou2025mcp.

Wie sich diese Lücken praktisch auswirken, zeigt die Messstudie von Guo et al. über sechs inoffizielle #acr("MCP")-Marktplätze. Von 17630 erfassten Einträgen erweisen sich weniger als die Hälfte als valide Projekte, der Rest besteht aus Platzhaltern, Forks oder aufgegebenen Prototypen. Rund 22 Prozent der validen Server werden seit über einem Jahr nicht mehr gepflegt, und etwa 11 Prozent enthalten Code, der potenziell sensible #acrs("API", plural: true) wie Authentifizierungsdienste anspricht @guo2025measurement. Nutzer installieren Server aus diesen Quellen damit weitgehend ungeprüft, während die Einhaltung der Zustimmungsprinzipien vom jeweiligen Host abhängt. Diese Kombination aus mächtigen Werkzeugzugriffen und fehlender zentraler Kontrolle bildet die Grundlage für die Angriffsvektoren, die das folgende Kapitel systematisch analysiert.
