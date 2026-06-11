# CLAUDE.md

## Projekt

Seminararbeit (DHBW Mannheim, Wirtschaftsinformatik SE) von Max Meinel:
**„Model Context Protocol: Architektur, aktueller Stand und IT-sicherheitliche Herausforderungen"**

- **Sprache der Arbeit: Deutsch** (Fachbegriffe wie „Prompt Injection" bleiben englisch). Antworten an den Nutzer ebenfalls auf Deutsch.
- Geschrieben in **Typst** mit dem Template `vendor/supercharged-dhbw` (nicht verändern).
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
| 01 Einleitung | ~350 |
| 02 Grundlagen | ~550 |
| 03 MCP | ~800 |
| 04 Sicherheit | ~900 |
| 05 Fazit | ~400 |

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

## Arbeitsweise

- Wissenschaftlicher, sachlicher Stil; keine Füllwörter, keine Marketing-Sprache.
- Keine Behauptungen ohne Quelle in Grundlagen-/Sicherheitskapiteln.
- Inhaltliche Aussagen aus Quellen belegen, die tatsächlich in `sources.bib` stehen — keine erfundenen Referenzen.
- Änderungen klein halten und kapitelweise vorgehen, damit der Nutzer reviewen kann.
