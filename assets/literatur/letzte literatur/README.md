# Literatur-Organisation für Bachelorarbeit

## Überblick

Diese Ordnerstruktur ersetzt die Online-Dokumentationen durch wissenschaftliche Literatur.

### Prioritäten

**KRITISCH (MUSS beschafft werden):**
- **A: Evans (2003)** - Domain-Driven Design (DDD wird verwendet aber nicht zitiert!)
- **F: Gamma et al. (1994)** - Design Patterns (Observer Pattern wird verwendet!)
- **D: Parr (2009)** - Language Implementation Patterns (DSL-Parsing)

**HOCH (sollte beschafft werden):**
- **A: Fehling et al. (2014)** - Cloud Computing Patterns (CAP-Fundierung)
- **E: Bass et al. (2012)** - Software Architecture (Architektur-Fundierung)
- **G: Cormen et al. (2009)** - Algorithms (Tree-Strukturen)

**MITTEL (wünschenswert):**
- **B: Vernon (2013)** - Implementing DDD
- **C: Beller et al. (2018)** - IDE Plug-ins
- **D: Fowler (2010)** - Domain-Specific Languages

**NIEDRIG (optional):**
- **H: Zangemeister (1976)** - Nutzwertanalyse (Götze 2014 reicht)
- **H: Wohlin et al. (2012)** - Software Experimentation

## Ordner-Struktur

```
A_SAP_CAP_Grundlagen/          → Ersetzt @cap_docs, @cap_cds
B_Domain_Driven_Design/         → DDD-Fundierung (fehlt komplett!)
C_LSP_und_IDE_Integration/      → Ersetzt @lsp_specification, @vscode-*
D_Compiler_und_Parsing/         → Parr 2009 für DSL-Parsing
E_Software_Architektur/         → Bass 2012 für Architektur
F_Design_Patterns/              → Gamma 1994 für Observer/Adapter (KRITISCH!)
G_Datenstrukturen_Algorithmen/  → Cormen 2009 für Trees
H_Evaluation_Methoden/          → Ergänzung zu Götze 2014
```

## Nächste Schritte

1. **Kritische Literatur beschaffen** (A, F, D)
2. PDFs in die entsprechenden Ordner legen
3. In `sources.bib` als `@book` oder `@inproceedings` eintragen
4. Online-Dokumentationen durch wissenschaftliche Zitate ersetzen

## Status

- [ ] A: Evans 2003 - DDD
- [ ] F: Gamma et al. 1994 - Design Patterns
- [ ] D: Parr 2009 - Language Implementation
- [ ] A: Fehling et al. 2014 - Cloud Patterns
- [ ] E: Bass et al. 2012 - Software Architecture
- [ ] G: Cormen et al. 2009 - Algorithms
