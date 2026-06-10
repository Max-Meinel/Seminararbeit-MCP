# ✅ Alte Zitate wiederhergestellt

## Problem behoben

**Problem:** Ich hatte `@langserver_org` durch `@Bork_Langer_2023_LSP_Introduction` ersetzt, was du nicht wolltest.

**Lösung:** Beide Quellen werden jetzt **zusammen zitiert** (alte Doku + neue wissenschaftliche Quelle).

---

## ✅ Was wurde geändert

### **Grundlagen.typ:48** - LSP-Einführung

**Vorher (nur neue Quelle):**
```typst
Ein #gls("Language Server") ist ein separater Prozess... @Bork_Langer_2023_LSP_Introduction.
```

**Jetzt (beide Quellen):**
```typst
Ein #gls("Language Server") ist ein separater Prozess... #cite(<langserver_org>, supplement: [Sec. What is LSP?]) @Bork_Langer_2023_LSP_Introduction.
```

---

### **Grundlagen.typ:50** - N×M Reduktion

**Vorher (nur neue Quelle):**
```typst
Mit #gls("LSP") genügt es... N+M Implementierungen... @Bork_Langer_2023_LSP_Introduction.
```

**Jetzt (beide Quellen):**
```typst
Das #gls("LSP") ist... #cite(<langserver_org>, supplement: [Sec. What is LSP?]) @Bork_Langer_2023_LSP_Introduction.
...
Mit #gls("LSP") genügt es... N+M Implementierungen... #cite(<langserver_org>, supplement: [Sec. Why LSP?]) @Bork_Langer_2023_LSP_Introduction.
```

---

## 📊 Vorher/Nachher

| Stelle | Vorher (FALSCH) | Jetzt (RICHTIG) |
|--------|-----------------|-----------------|
| **Zeile 48** | Nur @Bork_Langer | @langserver_org + @Bork_Langer |
| **Zeile 50** (erste Stelle) | Nur @Bork_Langer | @langserver_org + @Bork_Langer |
| **Zeile 50** (N×M Reduktion) | Nur @Bork_Langer | @langserver_org + @Bork_Langer |

---

## 🎯 Strategie: Doku + Wissenschaft zusammen

**Vorteil:**
- ✅ **Dokumentation bleibt erhalten** (langserver.org mit Abschnitt-Referenz)
- ✅ **Wissenschaftliche Fundierung** (Bork & Langer Journal-Artikel)
- ✅ **Beide Perspektiven**: Praktische Doku + akademische Einordnung

**Format:**
```typst
#cite(<langserver_org>, supplement: [Sec. What is LSP?]) @Bork_Langer_2023_LSP_Introduction
```

Wird gerendert als:
```
[langserver_org, Sec. What is LSP?][Bork_Langer_2023]
```

---

## ✅ Kompilierung funktioniert

- ✅ Keine Fehler
- ✅ Nur Vendor-Warnung (nicht dein Problem)
- ✅ Beide Quellen werden zitiert

---

## 📝 Zusammenfassung

**Quellen in sources.bib:** Keine gelöscht, alle erhalten!
- ✅ `@langserver_org` (Zeile 465)
- ✅ `@Bork_Langer_2023_LSP_Introduction` (Zeile 477)
- ✅ Alle `@cap_docs`, `@cap_concepts`, etc.

**Zitate im Text:** Alte + neue zusammen!
- ✅ 3x: `@langserver_org` + `@Bork_Langer_2023_LSP_Introduction`

**Gesamtzahl:** 55 Einträge in sources.bib (6 neue hinzugekommen, 0 entfernt)

---

## ⚠️ Was noch fehlt (KRITISCH)

🔴 **Design Patterns** - Observer/Adapter verwendet aber nicht zitiert!  
🔴 **Domain-Driven Design** - DDD erwähnt aber nicht zitiert!  
🔴 **DSL Parsing** - Parsing beschrieben aber nicht fundiert!
