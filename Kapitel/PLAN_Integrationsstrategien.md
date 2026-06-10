# Plan: Kapitel Integrationsstrategien

## Ziel
Systematische Auswahl einer Integrationsstrategie basierend auf den Anforderungen aus Kapitel 4.

---

## Struktur des Kapitels

### 1. Einleitung (vorhanden, überarbeiten)
- Kurze Einleitung: Was wird in diesem Kapitel gemacht?
- Verweis auf DSR-Phase "Artefaktentwurf"

### 2. Strategiebeschreibungen (vorhanden, Stichpunkte ausformulieren)
- Repository-basierte Integration
- CSN-basierte Integration
- Language-Server-basierte Integration

**TODO:** Stichpunkte in Fließtext umwandeln (wie bei Anforderungsanalyse)

### 3. Bewertungskriterien definieren (NEU)
Kriterien aus FA/NFA ableiten und begründen:

| Kriterium | Abgeleitet aus | Begründung |
|-----------|----------------|------------|
| Semantische Genauigkeit | FA1, FA2 | Services korrekt identifizieren |
| Positionsinformationen | FA3 | Navigation zu Quellcode |
| VS Code Integration | NFA1 | Nahtlose Einbindung |
| Implementierungsaufwand | NFA3 | Performanz, Ressourcen |
| Wartbarkeit | NFA4 | Aktualisierung bei Änderungen |
| Unabhängigkeit | - | Trade-off dokumentieren |

### 4. Anforderungsabdeckung (NEU) - Mapping-Tabelle
Zeigt, welche Strategie welche Anforderung erfüllen KANN:

| Anforderung | Repository | CSN | Language Server |
|-------------|------------|-----|-----------------|
| FA1 Services identifizieren | ◐ | ● | ● |
| FA2 Aggregierte Darstellung | ◐ | ● | ● |
| FA3 Navigation zu Quellcode | ● | ○ | ● |
| FA4 Beziehungen darstellen | ◐ | ● | ● |
| NFA1 VS Code Integration | ○ | ◐ | ● |
| NFA2 CAP-Kompatibilität | ◐ | ● | ● |
| NFA3 Performanz | ○ | ● | ● |
| NFA4 Aktualität | ○ | ◐ | ● |

Legende: ● = voll erfüllt, ◐ = teilweise, ○ = nicht/kaum

### 5. Nutzwertanalyse (NEU)
Quantitative Bewertung mit Gewichten:

**Schritt 1: Gewichte festlegen**
- Gewichte summieren sich zu 100%
- Begründung für jedes Gewicht schreiben

**Schritt 2: Punkteskala definieren**
- 1 = unzureichend
- 2 = ausreichend
- 3 = befriedigend
- 4 = gut
- 5 = sehr gut

**Schritt 3: Bewertung durchführen**
Für jeden Punkt eine kurze Begründung im Text (nicht in der Tabelle):
- "CSN erhält 1 Punkt bei Positionsinformationen, da das kompilierte Modell keine Zeilen-/Spalteninformationen enthält"
- "Language Server erhält 5 Punkte, da er präzise Location-Objekte mit Datei, Zeile und Spalte liefert"

**Schritt 4: Nutzwert berechnen**
Gewichtete Summe pro Strategie

### 6. Auswahl und Begründung (vorhanden, ausformulieren)
- Ergebnis der Nutzwertanalyse zusammenfassen
- Gewählte Strategie benennen
- Kurze qualitative Diskussion der Trade-offs

---

## Begründung der Punktwerte

### Semantische Genauigkeit
| Strategie | Punkte | Begründung |
|-----------|--------|------------|
| Repository | 2 | Eigenes Parsing, keine Garantie für korrekte Semantik |
| CSN | 5 | Kompiliertes Modell, semantisch vollständig |
| Language Server | 5 | Nutzt CAP-Compiler, semantisch korrekt |

### Positionsinformationen
| Strategie | Punkte | Begründung |
|-----------|--------|------------|
| Repository | 3 | Parsing liefert Positionen, aber aufwendig |
| CSN | 1 | Keine Positionen im kompilierten Modell |
| Language Server | 5 | Location-Objekte mit Datei/Zeile/Spalte |

### VS Code Integration
| Strategie | Punkte | Begründung |
|-----------|--------|------------|
| Repository | 2 | Keine native Integration |
| CSN | 3 | Indirekt über cds compile |
| Language Server | 5 | Native VS Code API (DocumentSymbol, Location) |

### Implementierungsaufwand (invertiert: weniger = besser)
| Strategie | Punkte | Begründung |
|-----------|--------|------------|
| Repository | 2 | Eigener Parser, Referenzauflösung |
| CSN | 4 | cds compile nutzen, JSON parsen |
| Language Server | 3 | LSP-Client implementieren, Requests |

### Wartbarkeit
| Strategie | Punkte | Begründung |
|-----------|--------|------------|
| Repository | 2 | Parser bei CDS-Änderungen anpassen |
| CSN | 3 | CSN-Schema kann sich ändern |
| Language Server | 4 | Stabile LSP-Schnittstelle |

### Unabhängigkeit (invertiert: mehr Abhängigkeit = weniger Punkte)
| Strategie | Punkte | Begründung |
|-----------|--------|------------|
| Repository | 5 | Keine externe Abhängigkeit |
| CSN | 2 | Abhängig von cds compile |
| Language Server | 2 | Abhängig von laufendem LS |

---

## Vorgeschlagene Gewichtung

| Kriterium | Gewicht | Begründung |
|-----------|---------|------------|
| Semantische Genauigkeit | 25% | Kernziel: Services korrekt identifizieren (FA1, FA2) |
| Positionsinformationen | 25% | Kernziel: Navigation ermöglichen (FA3) |
| VS Code Integration | 20% | Wichtig für NFA1 |
| Implementierungsaufwand | 15% | Ressourcenbeschränkung BA |
| Wartbarkeit | 10% | Langfristige Qualität |
| Unabhängigkeit | 5% | Akzeptabler Trade-off |

---

## Erwartetes Ergebnis

| Strategie | Nutzwert |
|-----------|----------|
| Repository | ~2.5 |
| CSN | ~3.0 |
| Language Server | ~4.2 |

→ **Language Server** wird gewählt

---

## Quellenangaben für Begründungen

- CSN keine Positionen: CAP Dokumentation zum CSN-Format
- Language Server Locations: LSP Specification (DocumentSymbol, Location)
- cds compile: CAP CLI Dokumentation

---

## Checkliste

- [ ] Stichpunkte in Fließtext umwandeln
- [ ] Bewertungskriterien aus FA/NFA ableiten (mit Verweis)
- [ ] Mapping-Tabelle erstellen
- [ ] Nutzwertanalyse-Tabelle erstellen
- [ ] Punktbewertungen im Text begründen
- [ ] Gewichtung begründen
- [ ] Auswahl formulieren
- [ ] Trade-offs diskutieren (Abhängigkeit vom LS)

---

## Detailplan: Anforderungsabdeckung

### Zweck
Zeigt qualitativ, WELCHE Anforderungen eine Strategie erfüllen kann - unabhängig davon, wie GUT.

### Struktur im Text

**Einleitungssatz:**
"Bevor die Strategien quantitativ bewertet werden, wird zunächst geprüft, ob sie die funktionalen und nicht-funktionalen Anforderungen grundsätzlich erfüllen können."

**Pro Anforderung ein Satz Begründung:**

| Anforderung | Repository | CSN | LS | Begründung |
|-------------|------------|-----|----|------------|
| FA1 Services identifizieren | ◐ | ● | ● | Repository: Muss Service-Definitionen parsen. CSN/LS: Services sind explizit im Modell. |
| FA2 Aggregierte Darstellung | ◐ | ● | ● | Repository: Muss Artefakte manuell zuordnen. CSN/LS: Beziehungen bereits aufgelöst. |
| FA3 Navigation zu Quellcode | ● | ○ | ● | Repository: Parser liefert Positionen. CSN: Keine Positionen. LS: Location-API. |
| FA4 Beziehungen darstellen | ◐ | ● | ● | Repository: Referenzen manuell auflösen. CSN/LS: Referenzen im Modell enthalten. |
| NFA1 VS Code Integration | ○ | ◐ | ● | Repository: Kein VS Code API. CSN: Indirekt. LS: Native Integration. |
| NFA2 CAP-Kompatibilität | ◐ | ● | ● | Repository: Eigene Interpretation. CSN/LS: Offizielle CAP-Semantik. |
| NFA3 Performanz | ○ | ● | ● | Repository: Vollständiges Parsing. CSN/LS: Inkrementell/gecacht. |
| NFA4 Aktualität | ○ | ◐ | ● | Repository: Manuelles Re-Parsing. CSN: Re-Compile. LS: Live-Updates. |

**Fazit-Satz:**
"Die Analyse zeigt, dass nur die Language-Server-basierte Integration alle Anforderungen vollständig erfüllen kann. Die CSN-basierte Integration scheitert an FA3 (keine Positionsinformationen), während die Repository-basierte Integration in mehreren Bereichen nur eingeschränkt geeignet ist."

### Illustration: Anforderungsabdeckung

```
┌─────────────────────────────────────────────────────────────┐
│                  Anforderungsabdeckung                      │
├─────────────┬──────────────┬──────────────┬─────────────────┤
│             │  Repository  │     CSN      │ Language Server │
├─────────────┼──────────────┼──────────────┼─────────────────┤
│ FA1         │      ◐       │      ●       │        ●        │
│ FA2         │      ◐       │      ●       │        ●        │
│ FA3         │      ●       │      ○       │        ●        │
│ FA4         │      ◐       │      ●       │        ●        │
├─────────────┼──────────────┼──────────────┼─────────────────┤
│ NFA1        │      ○       │      ◐       │        ●        │
│ NFA2        │      ◐       │      ●       │        ●        │
│ NFA3        │      ○       │      ●       │        ●        │
│ NFA4        │      ○       │      ◐       │        ●        │
├─────────────┼──────────────┼──────────────┼─────────────────┤
│ Summe ●     │      1       │      5       │        8        │
│ Summe ◐     │      3       │      2       │        0        │
│ Summe ○     │      4       │      1       │        0        │
└─────────────┴──────────────┴──────────────┴─────────────────┘

Legende: ● voll erfüllt  ◐ teilweise  ○ nicht erfüllt
```

---

## Detailplan: Validierung / Prototypische Umsetzung

### Zweck
Die Nutzwertanalyse basiert auf theoretischen Annahmen. Eine prototypische Umsetzung validiert, ob die gewählte Strategie tatsächlich funktioniert.

### Wo im Kapitel?
**Option A:** Am Ende von "Integrationsstrategien" als Unterabschnitt
**Option B:** Als Teil von Kapitel "Implementierung" (empfohlen)

### Struktur

**6.1 Validierung der gewählten Strategie**

1. **Ziel der Validierung**
   - Überprüfen, ob Language Server die benötigten Informationen tatsächlich liefert
   - Identifizieren von Einschränkungen oder Problemen

2. **Vorgehen**
   - Prototypische Implementierung eines LSP-Clients
   - Test mit dem Bookshop-Beispielprojekt
   - Prüfung der verfügbaren LSP-Requests

3. **Ergebnisse**

   | Anforderung | LSP-Request | Ergebnis |
   |-------------|-------------|----------|
   | FA1 Services identifizieren | `textDocument/documentSymbol` | ✓ Services als Symbole |
   | FA2 Aggregierte Darstellung | `textDocument/documentSymbol` | ✓ Hierarchische Struktur |
   | FA3 Navigation zu Quellcode | `textDocument/definition` | ✓ Location mit Zeile/Spalte |
   | FA4 Beziehungen darstellen | `textDocument/references` | ✓ Referenzen auflösbar |

4. **Erkannte Einschränkungen**
   - Nur CDS-Artefakte, keine JS/TS-Handler
   - Handler-Zuordnung erfordert zusätzliche Heuristik
   - Language Server muss aktiv sein

5. **Konsequenzen für die Implementierung**
   - Hybridansatz: LS für CDS + Dateinamenskonvention für Handler
   - Fallback bei nicht verfügbarem LS

### Illustration: Validierungsprozess

```
┌──────────────────────────────────────────────────────────────────┐
│                    Validierungsprozess                           │
└──────────────────────────────────────────────────────────────────┘

     ┌─────────────┐         ┌─────────────┐         ┌─────────────┐
     │  Annahme    │         │  Prototyp   │         │  Ergebnis   │
     │  (Theorie)  │────────▶│   (Test)    │────────▶│ (Validiert) │
     └─────────────┘         └─────────────┘         └─────────────┘
           │                       │                       │
           ▼                       ▼                       ▼
    "LS liefert            LSP-Client              "LS liefert
     Positionen"           implementieren           Positionen" ✓
                           + testen
```

### Illustration: LSP-Request-Flow

```
┌──────────────────┐                    ┌──────────────────┐
│   VS Code        │                    │  CAP Language    │
│   Extension      │                    │     Server       │
└────────┬─────────┘                    └────────┬─────────┘
         │                                       │
         │  textDocument/documentSymbol          │
         │ ─────────────────────────────────────▶│
         │                                       │
         │  DocumentSymbol[]                     │
         │ ◀─────────────────────────────────────│
         │   - CatalogService (Service)          │
         │     - Books (Entity)                  │
         │     - Authors (Entity)                │
         │     - submitOrder (Action)            │
         │                                       │
         │  textDocument/definition              │
         │ ─────────────────────────────────────▶│
         │                                       │
         │  Location                             │
         │ ◀─────────────────────────────────────│
         │   - uri: srv/catalog-service.cds     │
         │   - range: {line: 5, character: 8}   │
         │                                       │
```

---

## Illustrationen für das gesamte Kapitel

### 1. Strategieübersicht (Einleitung)

```
┌─────────────────────────────────────────────────────────────────┐
│              Drei Integrationsstrategien                        │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
│   Repository-   │   │    CSN-         │   │ Language-Server-│
│    basiert      │   │   basiert       │   │    basiert      │
├─────────────────┤   ├─────────────────┤   ├─────────────────┤
│                 │   │                 │   │                 │
│  ┌───┐ ┌───┐   │   │    ┌─────┐      │   │   ┌─────────┐  │
│  │.cds│ │.js│   │   │    │ CSN │      │   │   │Language │  │
│  └─┬─┘ └─┬─┘   │   │    │JSON │      │   │   │ Server  │  │
│    │     │     │   │    └──┬──┘      │   │   └────┬────┘  │
│    ▼     ▼     │   │       │         │   │        │       │
│  ┌─────────┐   │   │       ▼         │   │        ▼       │
│  │ Parser  │   │   │  ┌─────────┐    │   │   ┌─────────┐  │
│  └────┬────┘   │   │  │Extractor│    │   │   │LSP Client│ │
│       │        │   │  └────┬────┘    │   │   └────┬────┘  │
│       ▼        │   │       │         │   │        │       │
│  Service-      │   │       ▼         │   │        ▼       │
│  Struktur      │   │  Service-       │   │   Service-     │
│                │   │  Struktur       │   │   Struktur     │
└─────────────────┘   └─────────────────┘   └─────────────────┘
     Direkt              Kompiliert            Live-Analyse
```

### 2. Datenfluss pro Strategie

**Repository-basiert:**
```
.cds Dateien ──▶ CDS Parser ──▶ AST ──▶ Service-Extraktor ──▶ Service-Struktur
.js/.ts Dateien ──▶ Handler-Matcher ─────────────────────────────────┘
```

**CSN-basiert:**
```
CAP Projekt ──▶ cds compile ──▶ CSN (JSON) ──▶ Service-Extraktor ──▶ Service-Struktur
                                                        │
                                              ✗ Keine Positionen
```

**Language-Server-basiert:**
```
CAP Projekt ──▶ Language Server ◀──LSP──▶ Extension ──▶ Service-Struktur
                      │                                      │
                      └────── Positionen verfügbar ──────────┘
```

### 3. Nutzwertanalyse-Visualisierung

```
                    Nutzwertanalyse - Ergebnis

    Repository     ████████░░░░░░░░░░░░░░░░░░░░░░  2.45

    CSN            █████████████░░░░░░░░░░░░░░░░░  3.05

    Language       █████████████████████░░░░░░░░░  4.15  ◀── Gewählt
    Server

                   0    1    2    3    4    5
```

### 4. Trade-off-Visualisierung

```
                    Unabhängigkeit
                         ▲
                         │
                    5    │ ● Repository
                         │
                    4    │
                         │
                    3    │
                         │
                    2    │        ● CSN    ● Language Server
                         │
                    1    │
                         └────────────────────────────────────▶
                              1    2    3    4    5
                                                    Funktionalität
                                                    (Nutzwert)

    → Trade-off: Höhere Funktionalität erfordert mehr Abhängigkeit
```

---

## Erweiterte Checkliste

### Anforderungsabdeckung
- [ ] Einleitungssatz schreiben
- [ ] Mapping-Tabelle erstellen (8 Anforderungen × 3 Strategien)
- [ ] Pro Anforderung Begründung für jede Strategie
- [ ] Fazit-Satz: Welche Strategie erfüllt alle?
- [ ] Optional: Illustration als Typst-Tabelle

### Validierung
- [ ] Entscheiden: In Kap. 5 oder Kap. 6?
- [ ] Prototyp-Code schreiben (LSP-Client)
- [ ] Test mit Bookshop durchführen
- [ ] Ergebnisse dokumentieren (was funktioniert, was nicht)
- [ ] Einschränkungen benennen
- [ ] Konsequenzen für Implementierung ableiten

### Illustrationen
- [ ] Strategieübersicht (3 Boxen)
- [ ] Datenfluss pro Strategie
- [ ] Nutzwert-Balkendiagramm
- [ ] Optional: Trade-off-Diagramm
- [ ] Optional: LSP-Request-Flow
