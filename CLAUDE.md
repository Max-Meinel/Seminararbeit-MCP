# CLAUDE.md

## Projekt

Seminararbeit (DHBW Mannheim, Wirtschaftsinformatik SE) von Max Meinel:
**„Model Context Protocol: Architektur, aktueller Stand und IT-sicherheitliche Herausforderungen"**

- **Sprache der Arbeit: Deutsch** (Fachbegriffe wie „Prompt Injection" bleiben englisch). Antworten an den Nutzer ebenfalls auf Deutsch.
- Geschrieben in **Typst** mit dem Template `vendor/supercharged-dhbw`. Das Template ist lokal vendored (normal in git getrackt, kein Submodul/Universe-Paket) und **darf angepasst werden**; Anpassungen werden mitcommittet und vom CI-Build (`.github/workflows/typst.yml`) verwendet.
- Schwerpunkt der Arbeit: IT-Sicherheit von MCP (Kapitel 4 ist das Kernkapitel).

## Struktur

- `main.typ` — Einstiegspunkt, Template-Konfiguration, bindet Kapitel ein. IEEE-Zitierstil ist hier bereits konfiguriert: `bibliography("sources.bib", style: "ieee")`.
- `Kapitel/01_Einleitung.typ` … `05_Fazit.typ` — die Kapitel.
- `sources.bib` — BibTeX-Quellen (Stand Juni 2026: noch leer, Ziel ~10 Quellen).
- `acronyms.typ`, `glossary.typ` — Abkürzungen/Glossar (Acronyms aktuell deaktiviert).
- `assets/` — Bilder.
- `papers/` — lokale PDF-Volltexte aller Quellen plus `papers/README.md` mit der Zuordnung Bib-Key → Datei → Kapitel. **Beim Schreiben eines Kapitels zuerst die zugehörigen PDFs lesen**, damit Aussagen aus den echten Volltexten belegt werden.

## Build & Prüfung

```bash
typst compile main.typ            # PDF bauen
typst watch main.typ              # Live-Vorschau
python3 wordcount.py              # saubere Wortzahl pro Kapitel (ohne Typst-Syntax)
cat Kapitel/*.typ | wc -w         # grobe Wortzahl (zählt auch Typst-Syntax mit)
```

Nach inhaltlichen Änderungen immer kompilieren und auf Fehler prüfen (insbesondere tote `@key`-Referenzen auf nicht existierende Bib-Einträge).

## Anforderungen der Arbeit

- **~3000 Wörter Gesamtumfang** (Fließtext der Kapitel, ohne Verzeichnisse).
- **13 Literaturquellen** (12 Paper + MCP-Spezifikation, final ausgewählt und qualitätsgeprüft — siehe `papers/README.md`), alle in `sources.bib`, IEEE-Stil, Zitieren im Text mit `@key`.
- Jede Quelle soll mindestens einmal zitiert werden.

### Wortbudget pro Kapitel (Richtwerte)

| Kapitel | Ziel |
|---|---|
| 01 Einleitung | ~290 |
| 02 Grundlagen | ~430 |
| 03 MCP | ~680 |
| 04 Sicherheit | ~1400 |
| 05 Fazit | ~360 |

### Quellen-Zuordnung (Richtwerte)

- Einleitung: 1–2 (Motivation, LLM-Agenten-Trend)
- Grundlagen: 2–3 (LLMs, Tool-Use/Function-Calling)
- MCP: 2–3 (Spezifikation, Architektur)
- Sicherheit: 3–4 (Prompt Injection, Tool Poisoning, MCP-Security-Analysen 2024/2025)

## Workflow (vereinbarte Reihenfolge)

1. **Erst Literatur, dann Text** — keine Zitations-Nachrüstung. Quellen mit dem `paper-search`-MCP suchen (bevorzugte Quellen: arXiv, Semantic Scholar, CrossRef), Kandidaten dem Nutzer zur Auswahl vorlegen, dann BibTeX-Einträge in `sources.bib` anlegen.
2. Quellen den Kapiteln zuordnen.
3. Kapitel für Kapitel ausschreiben, Wortbudget einhalten.
4. Abschluss: kompilieren, Wortzahl prüfen, Zitate kontrollieren.

## Tooling

- **paper-search MCP**: konfiguriert in `.mcp.json` (läuft via `uv run --directory /home/mazus/paper-search-mcp paper-search-mcp`). Bietet Tools wie `search_arxiv`, `search_semantic`, `search_crossref`, `download_arxiv`, plus Volltext-Extraktion. Für Literatursuche immer diesen MCP nutzen statt Web-Suche.
- Falls der MCP nicht verbunden ist: Session neu starten bzw. mit `/mcp` prüfen.

## Schreibstil

- **Unpersönlich schreiben**: kein „ich"/„wir"/„man". Stattdessen „die vorliegende Arbeit untersucht…", Passiv oder Sachsubjekte („Das Protokoll definiert…").
- **Zeitform**: durchgehend Präsens, auch für Aussagen aus Quellen („Wang et al. beschreiben…", nicht „beschrieben"). Vergangenheit nur für tatsächlich Vergangenes (z. B. „Anthropic veröffentlichte MCP im November 2024").
- **Abkürzungen**: nie als Klartext schreiben, sondern immer `#acr("LLM")` bzw. Plural `#acrpl("LLM")` verwenden (Template schreibt bei Ersterwähnung automatisch aus, danach nur Kurzform). Allgemein bekannte Abkürzungen (HTTP, API, JSON, URL) mit `#acrs("...")`, die werden nie ausgeschrieben, stehen aber im Verzeichnis. Neue Abkürzungen zuerst in `acronyms.typ` eintragen.
- **Englische Fachbegriffe**: bei Ersterwähnung kursiv (`_Tool Poisoning_`), bei nicht selbsterklärenden Begriffen mit kurzer deutscher Erläuterung; danach normal gesetzt. Keine eingedeutschten Kunstübersetzungen.
- **Zitierposition**: `@key` steht direkt hinter der belegten Aussage, vor dem Satzzeichen. Mehrere Aussagen aus derselben Quelle im selben Absatz: einmal am Ende der zusammenhängenden Passage genügt.
- **Interpunktion**: keine Gedankenstriche (—/–) im Fließtext; stattdessen Kommas, Klammern oder eigenständige Sätze. Doppelpunkte im Fließtext sparsam einsetzen (nur wo eine Umformulierung gekünstelt wirken würde).
- **Satzbau**: kurze Hauptsätze bevorzugen, maximal eine Nebensatzebene, keine Aufzählungs-Schachtelsätze. Lieber zwei Sätze als ein überladener.
- **Absatzlogik**: ein Gedanke pro Absatz; jeder Absatz beginnt mit seiner Kernaussage, danach Beleg und Einordnung. Absätze von 3–6 Sätzen, keine Ein-Satz-Absätze.
- **Nüchternheit**: keine wertenden Adjektive ohne Beleg („beeindruckend", „enorm", „revolutionär"), keine rhetorischen Fragen, keine Superlative. Bewertungen nur als belegte Aussage einer Quelle.
- **Kapitelübergänge**: jedes Kapitel endet mit 1–2 Sätzen Überleitung zum nächsten; keine Vorab-Zusammenfassungen am Kapitelanfang.

## Arbeitsweise

- Wissenschaftlicher, sachlicher Stil; keine Füllwörter, keine Marketing-Sprache.
- Keine Behauptungen ohne Quelle in Grundlagen-/Sicherheitskapiteln.
- Inhaltliche Aussagen aus Quellen belegen, die tatsächlich in `sources.bib` stehen — keine erfundenen Referenzen.
- Änderungen klein halten und kapitelweise vorgehen, damit der Nutzer reviewen kann.
