#import "../vendor/supercharged-dhbw/lib.typ": *

= Einleitung

== Motivation und Relevanz

#acrpl("LLM") entwickeln sich von reinen Textgeneratoren zu autonomen Agenten, die Aufgaben selbstständig planen und ausführen. Die Forschung zu solchen #acr("LLM")-basierten Agenten wächst seit 2021 stark, wobei das Sprachmodell als zentrale Steuerungskomponente dient, die mit Gedächtnis, Planung und Werkzeugzugriff ausgestattet wird @wang2023survey. Damit Agenten über die Textgenerierung hinaus wirken können, benötigen sie Zugriff auf externe Werkzeuge und Datenquellen, etwa Dateisysteme, Datenbanken oder Webdienste.

Mit dem #acr("MCP") veröffentlichte Anthropic im November 2024 einen offenen Standard, der genau diese Anbindung vereinheitlicht @anthropic2024mcp. Das Protokoll wird seither branchenweit adoptiert; um es herum ist in kurzer Zeit ein Ökosystem aus tausenden unabhängig entwickelten Servern entstanden. Diese Verbreitung hat eine Kehrseite: Jeder angebundene Server erhält Einfluss auf das Verhalten des Agenten und damit potenziell Zugriff auf sensible Daten und Systeme. Die Sicherheit des Protokolls und seines Ökosystems wird so zu einer zentralen Voraussetzung für den vertrauenswürdigen Einsatz von #acr("KI")-Agenten.

== Forschungsfrage und Zielsetzung

Die vorliegende Arbeit untersucht die Forschungsfrage: Welche Angriffsvektoren weist das #acr("MCP") auf, und inwieweit lassen sich diese mitigieren? Ziel ist eine systematische Analyse der protokollspezifischen Bedrohungen auf Basis der aktuellen Sicherheitsforschung sowie eine Einordnung der verfügbaren Gegenmaßnahmen und ihrer Grenzen. Die Arbeit richtet den Blick dabei auf die Designentscheidungen des Protokolls, die diese Angriffe ermöglichen, und nicht allein auf einzelne Schwachstellen konkreter Implementierungen.

== Aufbau der Arbeit

Die Arbeit gliedert sich in fünf Kapitel. @grundlagen[Kapitel] legt die Grundlagen zu #acrpl("LLM"), autonomen Agenten und Werkzeugintegration. @mcp-kapitel[Kapitel] stellt das #acr("MCP") vor, beschreibt Architektur und Kernfunktionen und arbeitet die sicherheitsrelevanten Designentscheidungen heraus. @sicherheit[Kapitel] bildet den Kern der Arbeit: Es systematisiert Angreifer und Ziele, analysiert die Angriffsvektoren Prompt Injection, Tool Poisoning und Manipulation der Werkzeugauswahl und ordnet die verfügbaren Gegenmaßnahmen diesen Vektoren zu. @fazit[Kapitel] beantwortet die Forschungsfrage und gibt einen Ausblick auf offene Fragen der Protokollentwicklung. Den Ausgangspunkt bilden die Grundlagen zu Sprachmodellen und ihrer Werkzeugnutzung im folgenden Kapitel.
