#!/usr/bin/env python3
"""Wortzähler für den Fließtext der Seminararbeit.

Zählt den Abstract aus main.typ und den reinen Inhalt aus Kapitel/01_*.typ …
05_*.typ — also weder Inhaltsverzeichnis, Literaturverzeichnis noch Anhänge.
Typst-Syntax (Imports, Diagramm-Code, Figure-Caption-Aufrufe, Zitationen,
Labels) wird herausgestrippt, bevor gezählt wird.

Aufruf:
    python3 wordcount.py
"""
from __future__ import annotations
import pathlib
import re
import sys

CHAP_DIR = pathlib.Path(__file__).parent / "Kapitel"
MAIN_TYP = pathlib.Path(__file__).parent / "main.typ"

# Richtwerte aus CLAUDE.md
TARGETS = {
    "Abstract": 200,
    "01_Einleitung.typ": 350,
    "02_Grundlagen.typ": 550,
    "03_MCP.typ": 800,
    "04_Sicherheit.typ": 900,
    "05_Fazit.typ": 400,
}
TOTAL_TARGET = 3200


def strip_balanced(text: str, opener_re: str) -> str:
    """Entferne `<opener>(...)` inkl. Inhalt mit balancierten Klammern."""
    out: list[str] = []
    i = 0
    pat = re.compile(opener_re)
    while i < len(text):
        m = pat.search(text, i)
        if not m:
            out.append(text[i:])
            break
        out.append(text[i : m.start()])
        # m.end() steht direkt hinter der öffnenden Klammer
        j = m.end()
        depth = 1
        while j < len(text) and depth > 0:
            c = text[j]
            if c == "(":
                depth += 1
            elif c == ")":
                depth -= 1
            j += 1
        i = j
    return "".join(out)


def strip_typst(text: str) -> str:
    # Kommentare
    text = re.sub(r"//[^\n]*", "", text)
    # Importe und Show-/Set-Rules am Zeilenanfang
    text = re.sub(r"^\s*#import[^\n]*$", "", text, flags=re.M)
    # #figure(...) komplett entfernen (Caption ist nur ~8 Wörter Diff, der
    # Diagrammcode wäre sonst Müll). Muss VOR dem generischen #funktion-Strip
    # laufen, weil figure verschachtelte Funktionsaufrufe enthält.
    text = strip_balanced(text, r"#figure\s*\(")
    # Labels (Anker und Querverweis-Argumente wie `<grundlagen>`)
    text = re.sub(r"<[A-Za-z][A-Za-z0-9_\-]*>", "", text)
    # Zitationen `@key` (Keys dürfen `-` und `_` enthalten)
    text = re.sub(r"@[A-Za-z][A-Za-z0-9_\-]*", "", text)
    # Akronyme: bei #acr(...)/#acrpl(...)/#acrs(...)/#acrspl(...) das Kürzel
    # als ein Wort einsetzen. Das unterzählt Erstvorkommen leicht
    # ("Model Context Protocol (MCP)" ⇒ 1 Wort statt 4), passt aber für die
    # Größenordnung — alle weiteren Vorkommen sind ohnehin nur das Kürzel.
    text = re.sub(
        r"#acr(?:pl|spl|s)?\s*\(\s*\"([^\"]+)\"[^)]*\)",
        r"\1",
        text,
    )
    # Restliche #funktion(...) Aufrufe (z. B. #linebreak(), #text(...))
    # gefolgt von balancierten Klammern entfernen.
    while True:
        new = strip_balanced(text, r"#[A-Za-z][A-Za-z0-9_\-]*\s*\(")
        if new == text:
            break
        text = new
    # Verbleibende #marker ohne Klammern
    text = re.sub(r"#[A-Za-z][A-Za-z0-9_\-]*", "", text)
    # Heading-Marker am Zeilenanfang (= , ==, …) — Heading-Text zählt mit
    text = re.sub(r"^\s*=+\s*", "", text, flags=re.M)
    # Typst-Markup: Sterne, Unterstriche (kursiv/fett), Backticks
    text = re.sub(r"[*_`]", " ", text)
    # Eckige Klammern (Content-Blöcke) ⇒ als Wortgrenze behandeln
    text = re.sub(r"[\[\]]", " ", text)
    return text


def count_words(s: str) -> int:
    return len(s.split())


def extract_abstract(main_text: str) -> str | None:
    """Extrahiere den Inhalt des `abstract: [ ... ]`-Blocks aus main.typ.

    Sucht nach `abstract:` gefolgt von `[` und liest mit balancierten eckigen
    Klammern bis zum schließenden `]`. Gibt None zurück, falls der Block
    nicht gefunden wird.
    """
    m = re.search(r"abstract\s*:\s*\[", main_text)
    if not m:
        return None
    i = m.end()
    depth = 1
    start = i
    while i < len(main_text) and depth > 0:
        c = main_text[i]
        if c == "[":
            depth += 1
        elif c == "]":
            depth -= 1
            if depth == 0:
                return main_text[start:i]
        i += 1
    return None


def main() -> int:
    if not CHAP_DIR.is_dir():
        print(f"Kapitel-Ordner nicht gefunden: {CHAP_DIR}", file=sys.stderr)
        return 1

    files = sorted(CHAP_DIR.glob("*.typ"))
    if not files:
        print("Keine .typ-Dateien in Kapitel/ gefunden.", file=sys.stderr)
        return 1

    print(f"{'Abschnitt':<26}{'Wörter':>8}  {'Ziel':>6}  {'Auslastung':>11}")
    print("-" * 56)

    total = 0

    # Abstract aus main.typ
    if MAIN_TYP.is_file():
        abstract = extract_abstract(MAIN_TYP.read_text(encoding="utf-8"))
        if abstract is not None:
            n = count_words(strip_typst(abstract))
            target = TARGETS.get("Abstract", 0)
            pct = f"{100 * n / target:>3.0f} %" if target else "   —"
            print(f"{'Abstract':<26}{n:>8}  {target if target else '':>6}  {pct:>11}")
            total += n

    for path in files:
        raw = path.read_text(encoding="utf-8")
        n = count_words(strip_typst(raw))
        target = TARGETS.get(path.name, 0)
        pct = f"{100 * n / target:>3.0f} %" if target else "   —"
        print(f"{path.name:<26}{n:>8}  {target if target else '':>6}  {pct:>11}")
        total += n

    print("-" * 56)
    pct_total = f"{100 * total / TOTAL_TARGET:>3.0f} %"
    print(f"{'GESAMT':<26}{total:>8}  {TOTAL_TARGET:>6}  {pct_total:>11}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
