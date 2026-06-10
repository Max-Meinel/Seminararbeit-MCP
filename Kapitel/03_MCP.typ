#import "../vendor/supercharged-dhbw/lib.typ": *

= Model Context Protocol – Überblick und aktueller Stand

== Entstehung und Motivation

- Anthropic hat MCP im November 2024 veröffentlicht
- Ziel: einheitliche Schnittstelle für AI-Tool-Integration
- Vorher: jede Firma hatte eigene, inkompatible Lösung

== Architektur und Komponenten

- 3 Rollen: Host (z.B. Claude Desktop), Client, Server
- Transport: wie Nachrichten übertragen werden (Stdio, HTTP+SSE)
- Ablauf einer Anfrage von Host bis Server

== Kernfunktionen: Tools, Resources und Prompts

- Tools: Aktionen die der Server anbietet (z.B. Datei lesen)
- Resources: Daten die der Server bereitstellt
- Prompts: vordefinierte Eingabevorlagen

== Verbreitung, Ökosystem und Vergleich mit Alternativen

- Wie viele MCP-Server es schon gibt
- Welche Firmen mitmachen (Anthropic, Block, Replit, ...)
- Vergleich mit OpenAI function calling und LangChain
