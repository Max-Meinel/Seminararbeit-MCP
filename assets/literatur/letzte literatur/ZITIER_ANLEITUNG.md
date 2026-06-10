# Zitier-Anleitung für die 3 neuen Quellen

## ✅ Quellen wurden hinzugefügt zu sources.bib

Die folgenden 3 Quellen sind jetzt in deiner `sources.bib` verfügbar:

1. **@Fehling_2014_Cloud_Computing_Patterns** (Dissertation)
2. **@Krebs_et_al_2012_Multi_Tenant_SaaS** (Conference Paper)
3. **@IJRPR_2024_Cloud_Native** (Journal Article)

---

## 📍 Wo du die Quellen einbinden kannst

### 1. Fehling (Cloud Computing Patterns) - @Fehling_2014_Cloud_Computing_Patterns

#### A) **Grundlagen.typ - Zeile 9-11** (SAP CAP Einführung)
**Aktuell:**
```typst
Das #gls("SAP CAP") ist ein Framework für Enterprise-Cloud-Anwendungen von SAP @cap_docs. Das zentrale Ziel ist die Maximierung der Produktivität durch integrierte Best Practices.

Das Framework basiert auf drei Kernprinzipien @cap_docs.
```

**Ersetze mit:**
```typst
Das #gls("SAP CAP") ist ein Framework für Enterprise-Cloud-Anwendungen von SAP @cap_docs. Das zentrale Ziel ist die Maximierung der Produktivität durch integrierte Best Practices. Moderne Cloud-Anwendungen folgen dabei etablierten Architekturprinzipien wie Isolation, Elastizität und lose Kopplung #cite(<Fehling_2014_Cloud_Computing_Patterns>, supplement: [Ch. 3, IDEAL Properties]).

Das Framework basiert auf drei Kernprinzipien. #gls("Domain-Driven Design") bedeutet...
```

**Warum?** Fehling definiert die **IDEAL-Eigenschaften** (Isolated State, Distribution, Elasticity, Automated Management, Loose Coupling) – das sind die wissenschaftlichen Cloud-Native Prinzipien, die CAP umsetzt.

---

#### B) **Grundlagen.typ - Zeile 20** (Multi-Tenancy)
**Aktuell:**
```typst
Weitere zentrale Features sind Multi-Tenancy-Unterstützung zur Verwaltung mehrerer Mandanten, Datenbank-Abstraktion für #gls("HANA"), SQLite und PostgreSQL sowie Event-Driven Messaging für asynchrone Kommunikation.
```

**Ersetze mit:**
```typst
Weitere zentrale Features sind Multi-Tenancy-Unterstützung zur Verwaltung mehrerer Mandanten #cite(<Fehling_2014_Cloud_Computing_Patterns>, supplement: [Ch. 5, Multi-Tenancy Patterns]), Datenbank-Abstraktion für #gls("HANA"), SQLite und PostgreSQL sowie Event-Driven Messaging für asynchrone Kommunikation.
```

**Warum?** Fehling hat ein ganzes Kapitel zu Multi-Tenancy Patterns – das ist wissenschaftliche Fundierung statt SAP-Doku.

---

#### C) **Anforderungsanalyse.typ** (falls du dort Cloud-Architektur erwähnst)
Falls du in Kapitel 4 über "Cloud-Native Prinzipien" oder "Skalierbarkeit" schreibst, kannst du Fehling für:
- Elastizität (Ch. 6 - Elasticity Management)
- Automatisierung (Ch. 6 - Automated Management)
- Verteilte Architekturen (Ch. 4 - Cloud Application Architectures)

---

### 2. Krebs (Multi-Tenant SaaS) - @Krebs_et_al_2012_Multi_Tenant_SaaS

#### A) **Grundlagen.typ - Zeile 20** (Multi-Tenancy - KOMBINIERT mit Fehling!)
**Aktuell:**
```typst
Weitere zentrale Features sind Multi-Tenancy-Unterstützung zur Verwaltung mehrerer Mandanten, Datenbank-Abstraktion...
```

**Ersetze mit:**
```typst
Weitere zentrale Features sind Multi-Tenancy-Unterstützung zur Verwaltung mehrerer Mandanten #cite(<Fehling_2014_Cloud_Computing_Patterns>, supplement: [Ch. 5]) @Krebs_et_al_2012_Multi_Tenant_SaaS, Datenbank-Abstraktion...
```

**Warum?** Krebs behandelt die **architektonischen Herausforderungen** von Multi-Tenancy:
- Tenant-Isolation (Daten + Performance)
- Affinity-Strategien
- Persistenzdesign (Shared Database, Shared Schema, Separate Database)
- QoS-Differenzierung

---

#### B) **Grundlagen.typ - NEUE Sektion einfügen** (nach Zeile 20)
**Füge nach "Event-Driven Messaging" hinzu:**
```typst
Multi-Tenancy in #gls("SaaS")-Anwendungen erfordert Isolation auf mehreren Ebenen @Krebs_et_al_2012_Multi_Tenant_SaaS. Während Tenants dieselbe Anwendungsinstanz nutzen, müssen ihre Daten und Performance-Charakteristika isoliert bleiben. #gls("CAP") adressiert dies durch konfigurierbare Tenant-Isolation auf Datenbank-Ebene und Request-basierte Tenant-Erkennung.
```

**Warum?** Krebs ist DER Paper für Multi-Tenancy-Architektur. Das ist eine wissenschaftliche Fundierung von CAP's Multi-Tenancy-Konzept.

---

### 3. IJRPR (Cloud-Native Best Practices) - @IJRPR_2024_Cloud_Native

#### A) **Grundlagen.typ - Zeile 11** (Cloud-Native Prinzipien)
**Aktuell:**
```typst
Das Framework basiert auf drei Kernprinzipien @cap_docs. #gls("Domain-Driven Design") bedeutet...
```

**Ersetze mit:**
```typst
Das Framework basiert auf drei Kernprinzipien. Cloud-native Anwendungen zeichnen sich durch Skalierbarkeit, Resilienz und automatisierte Deployment-Prozesse aus @IJRPR_2024_Cloud_Native. #gls("Domain-Driven Design") bedeutet...
```

**Warum?** Der IJRPR-Artikel definiert "Cloud-Native" als Microservices, Containerisierung, CI/CD – das sind die Prinzipien, die CAP implementiert.

---

#### B) **Grundlagen.typ - Zeile 20** (CI/CD, Containerisierung)
**Falls du CI/CD oder Deployment erwähnst:**
```typst
#gls("CAP") unterstützt moderne Deployment-Strategien wie Containerisierung und CI/CD-Pipelines @IJRPR_2024_Cloud_Native, die schnelle Iterationen und automatisierte Tests ermöglichen.
```

**Warum?** Der IJRPR-Artikel behandelt CI/CD, Kubernetes, Docker – das sind moderne Cloud-Native Deployment-Praktiken.

---

## 🎯 Zusammenfassung: Wo ersetzen?

| Stelle | Aktuell | Ersetze mit | Grund |
|--------|---------|-------------|-------|
| **Grundlagen.typ:9** | `@cap_docs` (Cloud-Anwendungen) | + `@Fehling_2014_Cloud_Computing_Patterns` | IDEAL-Eigenschaften von Cloud-Apps |
| **Grundlagen.typ:11** | `@cap_docs` (Kernprinzipien) | + `@IJRPR_2024_Cloud_Native` | Cloud-Native Definition |
| **Grundlagen.typ:20** | `@cap_docs` (Multi-Tenancy) | + `@Fehling_2014_Cloud_Computing_Patterns` <br> + `@Krebs_et_al_2012_Multi_Tenant_SaaS` | Multi-Tenancy Patterns + Architektur |
| **Grundlagen.typ:20** | - | **NEU**: Multi-Tenancy Sektion mit `@Krebs_et_al_2012_Multi_Tenant_SaaS` | Wissenschaftliche Fundierung |

---

## ⚠️ WICHTIG: Was du NICHT tun solltest

**❌ Nicht:**
- `@cap_docs` komplett löschen – SAP-Doku bleibt als Referenz für CAP-spezifische Features
- Nur eine Quelle pro Stelle – kombiniere wissenschaftliche + CAP-Doku

**✅ Besser:**
```typst
Cloud-native Anwendungen folgen etablierten Patterns wie Elastizität und Isolation @Fehling_2014_Cloud_Computing_Patterns. #gls("SAP CAP") implementiert diese Prinzipien @cap_docs.
```

---

## 📚 Weitere Einsatzmöglichkeiten

### Fehling (@Fehling_2014_Cloud_Computing_Patterns)
- **Kap. 3**: IDEAL Properties (Isolation, Distribution, Elasticity, Automated Management, Loose Coupling)
- **Kap. 4**: Cloud Application Architectures
- **Kap. 5**: Multi-Tenancy Patterns
- **Kap. 6**: Elasticity + Automated Management

### Krebs (@Krebs_et_al_2012_Multi_Tenant_SaaS)
- Tenant-Definition
- Affinity-Strategien (Server-affin, Cluster-affin)
- Persistenzdesign (Shared Database vs. Separate Database)
- Performance-Isolation
- QoS-Differenzierung
- Customizability

### IJRPR (@IJRPR_2024_Cloud_Native)
- Microservices vs. Monolithen
- Containerisierung (Docker, Kubernetes)
- CI/CD-Pipelines
- Observability (Prometheus, Grafana)
- Serverless Computing
- Infrastructure as Code

---

## 🚀 Nächste Schritte

1. **Öffne [Grundlagen.typ](../../../Kapitel/Grundlagen.typ)**
2. **Ersetze die 3 Stellen** (Zeile 9, 11, 20)
3. **Füge die neue Multi-Tenancy-Sektion ein** (nach Zeile 20)
4. **Kompiliere die Arbeit** und prüfe, ob die Zitate korrekt erscheinen

---

## ❓ Falls du mehr brauchst

Diese 3 Quellen decken **nur Ordner A (Cloud-Native)** ab. Für die anderen kritischen Ordner brauchst du noch:

- 🔴 **Ordner F** (Design Patterns) - Observer/Adapter werden verwendet!
- 🔴 **Ordner B** (Domain-Driven Design) - DDD wird erwähnt!
- 🔴 **Ordner D** (DSL Parsing) - fehlt komplett!

**→ Nutze die Prompts aus [PROMPTS_FÜR_LLM.md](PROMPTS_FÜR_LLM.md) in Perplexity!**
