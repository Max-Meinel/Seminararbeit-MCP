#import "../vendor/supercharged-dhbw/lib.typ": *

= Model Context Protocol

- Anthropic hat MCP im November 2024 veröffentlicht
- Ziel: einheitliche Schnittstelle für AI-Tool-Integration
- Vorher: jede Firma hatte eigene, inkompatible Lösung

== Architektur und Komponenten

- 3 Rollen: Host (z.B. Claude Desktop), Client, Server
- Transport: wie Nachrichten übertragen werden (Stdio, HTTP+SSE)
- Ablauf einer Anfrage von Host bis Server

== Kernfunktionen

- Tools: Aktionen die der Server anbietet (z.B. Datei lesen)
- Resources: Daten die der Server bereitstellt
- Prompts: vordefinierte Eingabevorlagen

== Sicherheitsrelevante Designentscheidungen

- Was Anthropic beim Design explizit für Sicherheit vorgesehen hat (z.B. Nutzerzustimmung bei Tool-Aufruf)
- Was bewusst offen gelassen wurde (kein zentrales Verzeichnis, keine Signierung)
- Warum diese Lücken die Angriffsvektoren in Kap. 4 erst ermöglichen
