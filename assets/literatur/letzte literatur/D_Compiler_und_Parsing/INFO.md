# D. Compiler-Theorie und Parsing

## Problem
Parsing von CDS wird beschrieben, aber nur Aho et al. generisch zitiert
Benötigt: Spezifische Literatur zu DSL-Parsing, Symboltabellen

## Empfohlene Literatur

### Primär (KRITISCH)
- **Aho, Lam, Sethi, Ullman (2006)**: "Compilers: Principles, Techniques, and Tools" (2nd Edition)
  - Thema: Symboltabellen, Referenzauflösung, semantische Analyse
  - Relevanz: BEREITS zitiert, aber spezifischer nutzen für:
    - Kapitel 2: Lexical Analysis
    - Kapitel 3: Syntax Analysis  
    - Kapitel 6: Symbol Tables
  - Status: ✓ Vorhanden, präziser referenzieren

- **Parr (2009)**: "Language Implementation Patterns"
  - Thema: Praktische DSL-Parser, Tree Walking
  - Relevanz: CDS ist eine DSL - dieses Buch ist PERFEKT dafür
  - Verfügbarkeit: Pragmatic Bookshelf
  - Status: ✗ MUSS beschafft werden!

### Sekundär
- **Fowler (2010)**: "Domain-Specific Languages"
  - Thema: DSL Design und Implementierung
  - Relevanz: CDS als DSL einordnen

### Suchbegriffe
- "domain specific language parsing"
- "symbol table implementation"
- "reference resolution compiler"
- "namespace resolution"
- "multi-pass compiler"

## Einsatzort in der Arbeit
- **Integrationsstrategien.typ, Abschnitt "Herausforderungen beim Parsing von CDS"**
- Zeilen 48-66
- Aktuell: Aho et al. 2007 nur generisch
- Benötigt: Parr 2009 für DSL-spezifisches Parsing
