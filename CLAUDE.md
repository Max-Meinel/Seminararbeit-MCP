# Bachelorarbeit: Domänenbasierter Explorer für SAP CAP

## Kontext und Problemstellung

Diese Bachelorarbeit behandelt ein Navigationsproblem in SAP CAP-Projekten. SAP CAP (Cloud Application Programming Model) ist ein Framework zur Entwicklung von Enterprise-Anwendungen. Das zentrale Problem: Ein einzelner CAP-Service ist kein einzelnes Artefakt, sondern verteilt sich über viele Dateien in verschiedenen Ordnern. Die Arbeit entwickelt eine VS-Code Extension, die alle Teile eines Services aggregiert in einer Baumansicht darstellt.

## Begriffsdefinitionen

**SAP CAP**: Framework für Cloud-Anwendungen. Projekte folgen einer festen Ordnerstruktur nach dem Prinzip "Separation of Concerns".

**CDS (Core Definition Services)**: Modellierungssprache von CAP. Definiert Entities, Services, Projektionen in `.cds`-Dateien.

**CSN (Core Schema Notation)**: Kompilierte JSON-Repräsentation aller CDS-Definitionen. Enthält die vollständige Semantik, aber keine Quellcode-Positionen (Zeile/Spalte).

**Language Server**: Prozess, der IDE-Funktionen bereitstellt (Go-to-Definition, Hover, Autocomplete). Kommuniziert über das Language Server Protocol (LSP). Liefert präzise Positionsinformationen.

**CAP-Service**: Besteht aus vier konzeptionellen Ebenen, die physisch getrennt sind:
- Modeling (CDS): Entities, Types, Associations in `db/`
- API-Schnittstelle: Service-Definition, Projektionen, Actions in `srv/*.cds`
- Implementierung: Event Handler in `srv/*.js` oder `srv/*.ts`
- Security: Authorization-Annotationen (@restrict, @requires)

**Tyrannei der dominanten Dekomposition**: Fachbegriff aus der Softwarearchitektur. Bedeutet: Code wird nach einer primären Dimension organisiert (hier: technische Ordner), wodurch andere wichtige Sichten (hier: servicezentriert) über das Projekt verstreut werden.

## Repository-Struktur

```
main.typ                         → Hauptdatei, inkludiert alle Kapitel
Kapitel/Abstract.typ             → Abstract (noch leer)
Kapitel/Einleitung.typ           → Einleitung (Struktur vorhanden, Inhalt offen)
Kapitel/Grundlagen.typ           → Grundlagen (Struktur vorhanden, Inhalt offen)
Kapitel/Methodik.typ             → Methodik (ausformuliert)
Kapitel/Anforderungsanalyse.typ  → Problem- und Anforderungsanalyse (ausformuliert)
Kapitel/Integrationsstrategien.typ → Integrationsstrategien (teilweise ausformuliert)
Kapitel/Implementierung.typ      → Implementierung (Struktur vorhanden, Inhalt offen)
Kapitel/Evaluation.typ           → Evaluation (Struktur vorhanden, Inhalt offen)
Kapitel/Diskussion.typ           → Diskussion (Struktur vorhanden, Inhalt offen)
Kapitel/Fazit_und_Ausblick.typ   → Fazit (Struktur vorhanden, Inhalt offen)
sources.bib                      → Literaturverzeichnis
```

## Kapitelstruktur und Inhalt

### Kapitel 1: Einleitung
Status: NUR STRUKTUR, INHALT FEHLT

Geplante Unterabschnitte:
- Motivation: Begründung der Relevanz des Themas
- Problemstellung: Konkrete Beschreibung des Navigationsproblems
- Zielsetzung: Definition des Ziels (VS-Code Extension entwickeln)
- Forschungsfragen: Leitfragen der Arbeit
- Aufbau der Arbeit: Kapitelübersicht

### Kapitel 2: Grundlagen
Status: NUR STRUKTUR, INHALT FEHLT

Geplante Unterabschnitte:
- SAP CAP: Einführung ins Framework
- CDS und CDL: Erklärung der Modellierungssprache
- CSN: Erklärung der kompilierten Modellrepräsentation
- Language Server und LSP: Architektur, relevante Funktionalitäten
- VS Code Extension Architektur: Tree View API, Language Server Integration

### Kapitel 3: Methodik
Status: AUSFORMULIERT

Inhalt: Beschreibt Design Science Research (DSR) als methodischen Rahmen. DSR ist geeignet für Arbeiten, die ein konkretes Artefakt entwickeln. Das Artefakt dieser Arbeit ist die VS-Code Extension.

DSR-Phasen in dieser Arbeit:
1. Problemidentifikation: Analyse der Navigationsherausforderungen
2. Zieldefinition: Anforderungen an die Extension
3. Artefaktentwurf: Konzeption verschiedener Integrationsstrategien
4. Demonstration: Prototypische Implementierung
5. Evaluation: Bewertung des Artefakts

### Kapitel 4: Problem- und Anforderungsanalyse
Status: AUSFORMULIERT

Inhalt: Konkretisiert das Problem und leitet Anforderungen ab.

Abschnitt "Typische Struktur von CAP-Projekten": Beschreibt die Ordnerstruktur (db/, srv/, app/, test/, config/). Erklärt, dass diese Struktur dem Separation-of-Concerns-Prinzip folgt.

Abschnitt "Verteilung servicebezogener Artefakte": Erklärt, dass ein Service aus mehreren Artefakt-Typen besteht (Entity, Type, Association, Aspect, Service, Projection, Action/Function, Event Handler, Authorization Annotations). Diese sind über verschiedene Dateien verteilt.

Abschnitt "Identifizierte Herausforderungen":
- Artefakte eines Services sind physisch getrennt
- Beziehungen sind referenziell, nicht visuell
- Hoher Navigationsaufwand durch viele Dateiwechsel
- Keine aggregierte Service-Übersicht vorhanden

Abschnitt "Quantifizierung": Konkrete Beispiele mit Zahlen. Beispiel "Authorization-Regeln anpassen": erfordert 4-5 Dateien, 6-8 Kontextwechsel. Beispiel "Unbekannten Service verstehen": erfordert 6-9 Dateien, 12-20 Kontextwechsel.

Abschnitt "Designziele" (lösungsneutral formuliert):
1. Aggregierte Service-Sicht: Alle Artefakte eines Services gebündelt darstellen
2. Reduktion von Kontextwechseln: Weniger Dateiwechsel erforderlich
3. Explizite Darstellung von Abhängigkeiten: Beziehungen sichtbar machen
4. Servicezentrierte Navigation: Service als logische Einheit im Mittelpunkt

Abschnitt "Funktionale Anforderungen":
- FA1: Extension muss CAP-Services automatisch identifizieren
- FA2: Extension muss aggregierte Darstellung aller Service-Artefakte bieten
- FA3: Extension muss direkte Navigation zu Quellcode-Positionen ermöglichen
- FA4: Extension muss Beziehungen zwischen Artefakten sichtbar machen

Abschnitt "Nicht-funktionale Anforderungen":
- NFA1: Implementierung als VS Code Extension
- NFA2: Kompatibilität mit CAP-Projektstrukturen
- NFA3: Performante Analyse ohne merkliche Verzögerung
- NFA4: Automatische Aktualisierung bei Dateiänderungen

Abschnitt "Abgrenzung": Keine Codegenerierung, keine Nutzerstudie.

### Kapitel 5: Integrationsstrategien
Status: TEILWEISE AUSFORMULIERT (Stichpunkte und Vergleichstabelle vorhanden)

Inhalt: Vergleicht drei Strategien zur Gewinnung der Service-Strukturinformationen.

Strategie 1 - Repository-basiert:
- Parst CDS-Dateien direkt
- Hoher Implementierungsaufwand
- Geringe semantische Genauigkeit
- Dupliziert existierende CAP-Analysefunktionen

Strategie 2 - CSN-basiert:
- Nutzt kompiliertes CAP-Modell
- Semantisch korrekt
- Keine Quellcode-Positionsinformationen
- Mittlerer Implementierungsaufwand

Strategie 3 - Language-Server-basiert:
- Nutzt CAP Language Server
- Semantisch korrekt
- Präzise Positionsinformationen
- Gute VS Code Integration
- Abhängigkeit vom Language Server

Abschnitt "Vergleich": Tabellarische Gegenüberstellung nach Kriterien (Implementierungsaufwand, Semantische Genauigkeit, Positionsinformationen, Integrationsgrad, Wartbarkeit, Abhängigkeit).

Abschnitt "Auswahl der Strategie": INHALT FEHLT - hier soll die Begründung für die gewählte Strategie stehen.

### Kapitel 6: Implementierung des Prototyps
Status: NUR STRUKTUR, INHALT FEHLT

Geplante Unterabschnitte:
- Technische Architektur der Extension: Aufbau, verwendete VS Code APIs
- Umsetzung der Integrationsansätze: Konkrete Implementierung der gewählten Strategie
- Visualisierung im VS Code Explorer: Tree View Darstellung, Icons, Hierarchie
- Update- und Synchronisationsstrategie: Wie reagiert die Extension auf Dateiänderungen

### Kapitel 7: Evaluation
Status: NUR STRUKTUR, INHALT FEHLT

Geplante Unterabschnitte:
- Evaluationskriterien: Welche Kriterien werden zur Bewertung herangezogen
- Vergleich der Integrationsansätze: Praktische Bewertung der implementierten Strategie
- Analyse der Ergebnisse: Interpretation der Evaluationsdaten

### Kapitel 8: Diskussion
Status: NUR STRUKTUR, INHALT FEHLT

Geplante Unterabschnitte:
- Interpretation der Ergebnisse: Was bedeuten die Evaluationsergebnisse
- Limitationen: Einschränkungen der Arbeit und des gewählten Ansatzes

### Kapitel 9: Fazit und Ausblick
Status: NUR STRUKTUR, INHALT FEHLT

Geplante Unterabschnitte:
- Zusammenfassung der Ergebnisse: Kernaussagen komprimiert
- Beantwortung der Forschungsfragen: Explizite Beantwortung der in Kapitel 1 gestellten Fragen
- Ausblick auf zukünftige Arbeiten: Mögliche Weiterentwicklungen

## Logischer Zusammenhang der Kapitel

```
Einleitung (Problem + Ziel)
    ↓
Grundlagen (Technisches Wissen für Verständnis)
    ↓
Methodik (DSR als Rahmen)
    ↓
Anforderungsanalyse (Problem konkretisieren → Anforderungen ableiten)
    ↓
Integrationsstrategien (Lösungsansätze vergleichen → einen auswählen)
    ↓
Implementierung (Ausgewählte Strategie umsetzen)
    ↓
Evaluation (Artefakt bewerten)
    ↓
Diskussion (Ergebnisse interpretieren + Grenzen aufzeigen)
    ↓
Fazit (Zusammenfassen + Forschungsfragen beantworten)
```

## Zentrale These der Arbeit

Die technische Ordnerstruktur von CAP-Projekten (db/, srv/, app/) erschwert das Verständnis einzelner Services, weil deren Artefakte verstreut liegen. Eine servicezentrierte Sicht in Form einer VS-Code Extension kann dieses Problem lösen, indem sie alle zu einem Service gehörenden Artefakte aggregiert darstellt und direkte Navigation ermöglicht.


## IEEE Zitier-Spickzettel

### 1. Grundprinzip
- Quellen werden **nummeriert** zitiert: `[1]`, `[2]`, `[3]`
- Nummer entspricht der **Reihenfolge der ersten Nennung im Text**
- Dieselbe Quelle behält **immer dieselbe Nummer**

Beispiel:
> Separation of concerns is a fundamental principle in software engineering [1].

---

### 2. Mehrere Quellen
Mehrere Referenzen zusammenfassen:

- `[1], [2], [3]`
- oder kompakt: `[1]–[3]`

Beispiel:
> Several studies analyze software evolution [1]–[3].

---

### 3. Seiten, Abschnitte oder Kapitel
Nur wenn du **eine konkrete Stelle** meinst.

| Typ | Format |
|---|---|
| Seite | `[1, p. 1068]` |
| mehrere Seiten | `[1, pp. 1068–1071]` |
| Abschnitt | `[1, Sec. II]` |
| Kapitel | `[1, Ch. 3]` |
| Abbildung | `[1, Fig. 2]` |
| Tabelle | `[1, Table I]` |

Beispiel:
> The law of increasing complexity is described in [1, p. 1068].

---

### 4. Keine Seiten vorhanden (z. B. Webseiten)
Wenn möglich:

- `[n, Sec. X]`

sonst einfach:

- `[n]`

Beispiel:
> This concept is widely discussed in software engineering literature [4].

---

### 5. Kein „vgl.“ im IEEE-Stil
Nicht schreiben:
