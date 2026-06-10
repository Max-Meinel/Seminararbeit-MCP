# Fehlende Literatur - Checkliste

**Stand:** 24.04.2026  
**Zweck:** Systematische Übersicht über fehlende Quellen nach Kapiteln

---

## Kapitel 2: Grundlagen

### 2.1 SAP CAP (Zeile 17)
- [ ] **CAP Architecture / Best Practices**
  - **Art:** SAP Dokumentation oder Technical Guide
  - **Inhalt:** Sollte SDKs, Runtime-Features, Multi-Tenancy beschreiben
  - **Beispiel-Suche:** "SAP CAP Architecture Overview" oder "CAP Best Practices Guide"

---

### 2.2 CDS (Zeile 22)
- [ ] **CAP Compiler Dokumentation**
  - **Art:** SAP Dokumentation
  - **Inhalt:** Wie der CDS-Compiler funktioniert, von CDL zu CSN
  - **Beispiel-Suche:** "CDS Compiler" auf cap.cloud.sap

---

### 2.3 Language Server (Zeile 42-46)
- [ ] **IDE Features / Intelligent Code Completion**
  - **Art:** Journal Paper oder Konferenzbeitrag
  - **Inhalt:** Was macht moderne IDEs "intelligent" (Autocomplete, Refactoring, etc.)
  - **Beispiel-Autoren:** Murphy-Hill, Ko, DeLine
  - **Keywords:** "IDE support", "code completion", "language-aware editing"

- [ ] **LSP Original Paper**
  - **Art:** Conference Paper (idealerweise von Microsoft-Autoren)
  - **Inhalt:** Originalpaper zur Einführung des Language Server Protocol
  - **Beispiel:** Bunder et al. (2019) "The Language Server Protocol"
  - **Alternative:** Microsoft LSP Blog Announcement (2016)

---

### 2.4 VS Code Extension (Zeile 64)
- [ ] **VS Code Extension Host Process**
  - **Art:** VS Code Dokumentation
  - **Inhalt:** Wie Extensions in separatem Prozess laufen
  - **Beispiel-Suche:** "VS Code Extension Host Architecture"

---

## Kapitel 3: Methodik

### 3.1 DSR als methodischer Rahmen (Zeile 8-9)
- [ ] **Unterschied Behavioral Science vs. Design Science**
  - **Art:** Journal Paper
  - **Inhalt:** Grundlegende Unterscheidung der beiden Forschungsansätze
  - **Beispiel:** March & Smith (1995) "Design and Natural Science Research on Information Technology"
  - **Journal:** Decision Support Systems

---

## Kapitel 4: Anforderungsanalyse

### 4.1 Verteilung servicebezogener Artefakte (Zeile 94, 119)
- [ ] **CAP Security / Authorization Annotations**
  - **Art:** SAP Dokumentation
  - **Inhalt:** Wie @restrict und @requires funktionieren
  - **Beispiel-Suche:** "CAP Authorization" oder "CAP Security Guide"

- [ ] **Domain-Driven Design (DDD)**
  - **Art:** Buch (Klassiker!)
  - **Autor:** Eric Evans
  - **Titel:** "Domain-Driven Design: Tackling Complexity in the Heart of Software" (2003)
  - **Warum wichtig:** Du behauptest, CAP folgt DDD-Prinzipien → muss zitiert werden

---

### 4.2 Bestehende Ansätze (Zeile 191)
- [ ] **Limitationen von file-basierten IDEs**
  - **Art:** Empirische Studie (ICSE, FSE, CHI)
  - **Inhalt:** Warum file-basierte Navigation nicht ausreicht, Cross-cutting Concerns
  - **Beispiel-Autoren:** LaToza, Ko, DeLine, Venolia
  - **Beispiel:** LaToza "Maintaining Mental Models" (2006)
  - **Keywords:** "developer navigation", "code comprehension", "IDE limitations"

---

## Kapitel 5: Integrationsstrategien

### 5.1 Repository-basierte Integration (Zeile 10, 43)
- [ ] **Compiler-Theorie / Parser Design**
  - **Art:** Lehrbuch ODER Buch über DSLs
  - **Option 1:** Aho et al. "Compilers: Principles, Techniques, and Tools" (2006) - das Standardwerk
  - **Option 2:** Fowler "Domain-Specific Languages" (2010) - wenn DSL-Fokus besser passt
  - **Inhalt:** Warum eigene Parser komplex sind

---

### 5.2 CSN-basierte Integration (Zeile 91)
- [ ] **Build Performance / Compiler Optimization**
  - **Art:** Conference Paper oder Technical Report
  - **Inhalt:** Warum Compiler-Erweiterungen Build-Zeit erhöhen
  - **Keywords:** "compiler performance", "build pipeline optimization"
  - **Alternative:** Falls keine gute Quelle → weglassen und nur empirisch begründen

---

### 5.3 Nutzwertanalyse (Zeile 147)
- [ ] **Nutzwertanalyse in Software Engineering**
  - **Art:** Buch über Software Architecture Evaluation
  - **Autor:** Clements, Kazman, Klein
  - **Titel:** "Evaluating Software Architectures: Methods and Case Studies" (2002)
  - **ODER:** Kazman "ATAM: Method for Architecture Evaluation" (2000)
  - **Inhalt:** Wie man Architekturentscheidungen bewertet

---

## Kapitel 6: Implementierung

### 6.1 Architektur (Zeile 8-13)
- [ ] **Layered Architecture / Clean Architecture**
  - **Art:** Buch
  - **Option 1:** Robert C. Martin "Clean Architecture" (2017) - modern, gut lesbar
  - **Option 2:** Buschmann et al. "Pattern-Oriented Software Architecture" (1996) - Klassiker
  - **Inhalt:** Mehrschichtige Architektur, Dependency Injection, Domain Layer

---

### 6.2 Technologie-Stack (Zeile 63-65)
- [ ] **TypeScript Type Safety**
  - **Art:** Dokumentation oder Paper
  - **Option 1:** TypeScript Handbook (offizielle Docs)
  - **Option 2:** Academic Paper über "Benefits of Static Typing in JavaScript"
  - **Inhalt:** Warum TypeScript besser als JavaScript ist

- [ ] **Frontend Bundle Size / Performance**
  - **Art:** Web Performance Guide oder Empirische Studie
  - **Inhalt:** Impact von Bundle-Größe auf Ladezeiten
  - **Beispiel-Suche:** "JavaScript bundle size performance", "frontend build optimization"
  - **Alternative:** Google Web Fundamentals Artikel

---

### 6.3 LSP Kommunikation (Zeile 73-76)
- [ ] **Eigener Beitrag zum CDS Language Server**
  - **Art:** Interne SAP-Referenz
  - **Inhalt:** Dein `/gax` Flag für workspace/symbol
  - **Optionen:**
    - Merge Request Nummer (z.B. cap/cds-lsp MR #12345)
    - Git Commit SHA
    - Technical Design Document
    - Issue Tracker Nummer
  - **Falls nichts verfügbar:** Im Text als "Im Rahmen dieser Arbeit entwickelt" kennzeichnen

---

### 6.4 Datenmodell (Zeile 94-96)
- [ ] **Tree Data Structures / Hierarchical Navigation**
  - **Art:** Lehrbuch Algorithmen ODER Buch über Information Architecture
  - **Option 1:** Cormen et al. "Introduction to Algorithms" (2009) - für Tree-Strukturen
  - **Option 2:** Rosenfeld "Information Architecture" (2015) - für Navigationskonzepte
  - **Inhalt:** Wie man hierarchische Daten strukturiert

---

### 6.5 Navigation und Interaktion (Zeile 148)
- [ ] **Observer Pattern**
  - **Art:** Design Patterns Buch
  - **Autor:** Gamma, Helm, Johnson, Vlissides (Gang of Four)
  - **Titel:** "Design Patterns: Elements of Reusable Object-Oriented Software" (1994)
  - **Inhalt:** Observer Pattern für Event-Handling

---

## Kapitel 7: Evaluation

### 7.1 Testprojekte (Zeile 15-18)
- [ ] **xtravels Projekt-Referenz**
  - **Art:** Repository URL oder Projektbeschreibung
  - **Falls öffentlich:** GitHub/GitLab Link
  - **Falls intern:** Anonymisierte Beschreibung (LoC, Anzahl Services, Files)

- [ ] **ctsm-develop Projekt-Referenz**
  - **Art:** Anonymisierte Projektbeschreibung
  - **Falls SAP-intern:** Fußnote mit "Produktives SAP-Projekt, anonymisiert"
  - **Empfehlung:** Statistiken in Anhang (X Services, Y Files, Z LoC)

---

### 7.2 Performance (Zeile 35-36)
- [ ] **Testumgebung-Dokumentation**
  - **Art:** Anhang-Eintrag (keine externe Quelle)
  - **Inhalt:** Hardware, OS, VS Code Version, Node.js Version
  - **Aktion:** Im Anhang ergänzen

- [ ] **Performance Measurement Methodology (optional)**
  - **Art:** Standard oder Technical Report
  - **Beispiel:** ISO/IEC 25010 (Software Quality Model)
  - **Inhalt:** Wie man Software-Performance misst
  - **Priorität:** NIEDRIG - nur wenn du methodisch tiefer gehen willst

---

### 7.3 Szenario-Vergleich (Zeile 94)
- [ ] **Statistische Berechnung (optional)**
  - **Art:** Anhang-Eintrag (keine externe Quelle)
  - **Inhalt:** Wie die 72% berechnet wurden
  - **Aktion:** Formel + Tabelle im Anhang ergänzen

---

## Kapitel 8: Diskussion und Fazit

### 8.1 Diskussion (Zeile 10-11)
- [ ] **Software Metrics / Skalierbarkeit**
  - **Art:** Lehrbuch
  - **Autor:** Fenton & Bieman
  - **Titel:** "Software Metrics: A Rigorous and Practical Approach" (2014)
  - **Inhalt:** Wie man Software-Komplexität misst und diskutiert
  - **Priorität:** MITTEL - nur wenn du Skalierbarkeits-Diskussion vertiefen willst

---

### 8.2 Limitationen (Zeile 21)
- [ ] **VS Code FileSystemWatcher API**
  - **Art:** VS Code API Dokumentation
  - **Inhalt:** Wie File-Watching funktioniert
  - **Beispiel-Suche:** "VS Code FileSystemWatcher API Reference"

---

### 8.3 Ausblick (Zeile 35-36)
- [ ] **Cross-Paradigm Navigation (optional)**
  - **Art:** Research Paper
  - **Inhalt:** Navigation zwischen deklarativem und imperativem Code
  - **Keywords:** "declarative vs imperative code navigation", "information scent"
  - **Priorität:** NIEDRIG - nur erwähnt, nicht zentral

---

## 🔴 Prioritäten-Übersicht

### PRIO 1: Unbedingt ergänzen (vor Abgabe!)
1. ✅ **Domain-Driven Design** (Kapitel 4) - Evans (2003)
2. ✅ **Design Patterns** (Kapitel 6) - Gamma et al. (1994)
3. ✅ **Clean Architecture / Layered Architecture** (Kapitel 6) - Martin (2017) oder Buschmann (1996)
4. ✅ **Eigener LSP-Beitrag** (Kapitel 6) - Interner Merge Request oder Fußnote
5. ✅ **TypeScript Dokumentation** (Kapitel 6) - TypeScript Handbook

### PRIO 2: Sollte ergänzt werden (verbessert Note)
6. ⚠️ **LSP Original Paper** (Kapitel 2) - Bunder et al. (2019)
7. ⚠️ **IDE Limitations** (Kapitel 4) - LaToza (2006) oder Ko et al. (2007)
8. ⚠️ **Compiler-Theorie** (Kapitel 5) - Aho (2006) oder Fowler (2010)
9. ⚠️ **Software Architecture Evaluation** (Kapitel 5) - Clements (2002)
10. ⚠️ **CAP Security Dokumentation** (Kapitel 4)

### PRIO 3: Nice to have (optional)
11. 🔵 **March & Smith DSR** (Kapitel 3)
12. 🔵 **Information Architecture** (Kapitel 6) - Rosenfeld (2015)
13. 🔵 **Software Metrics** (Kapitel 8) - Fenton (2014)
14. 🔵 **Frontend Performance** (Kapitel 6)

---

## 📝 Notizen

- **Kommentare entfernen:** In Kapitel 6 sind noch `// Literatur: ...` Kommentare - diese löschen!
- **Testumgebung:** Hardware-Specs für Performance-Messung im Anhang ergänzen
- **Anonymisierung:** Falls ctsm-develop vertraulich ist → anonymisieren

---

## ✅ Checkliste Abarbeitung

```
[ ] Kapitel 2 - Grundlagen durchgearbeitet
[ ] Kapitel 3 - Methodik durchgearbeitet
[ ] Kapitel 4 - Anforderungsanalyse durchgearbeitet
[ ] Kapitel 5 - Integrationsstrategien durchgearbeitet
[ ] Kapitel 6 - Implementierung durchgearbeitet
[ ] Kapitel 7 - Evaluation durchgearbeitet
[ ] Kapitel 8 - Diskussion durchgearbeitet
[ ] sources.bib aktualisiert
[ ] Alle Zitate im Text eingefügt
```
