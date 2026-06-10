#import "@preview/lilaq:0.5.0" as lq

= Beispiel-Diagramme für Bachelorarbeit

== Navigationskomplexität (Anforderungsanalyse)

=== Option 1: Vertikales Balkendiagramm (nur Kontextwechsel)

#figure(
  caption: [Kontextwechsel pro Szenario],
  lq.diagram(
    width: 11cm,
    height: 5cm,
    xaxis: (
      subticks: none,
      ticks: (
        (0, "Debug"),
        (1, "Auth"),
        (2, "Feld"),
        (3, "Verstehen"),
      ),
    ),
    yaxis: (lim: (0, 20), subticks: none),
    ylabel: [Kontextwechsel],
    lq.bar(
      (0, 1, 2, 3),
      (6, 7, 10, 16),
      width: 0.6,
      fill: (rgb("#10b981"), rgb("#84cc16"), rgb("#f59e0b"), rgb("#ef4444")),
    ),
    lq.place(0, 6, align: bottom, pad(bottom: 0.3em)[5–7]),
    lq.place(1, 7, align: bottom, pad(bottom: 0.3em)[6–8]),
    lq.place(2, 10, align: bottom, pad(bottom: 0.3em)[8–12]),
    lq.place(3, 16, align: bottom, pad(bottom: 0.3em)[12–20]),
  )
)

=== Option 2: Horizontales Balkendiagramm (Dateien + Kontextwechsel)

#figure(
  caption: [Navigationskomplexität pro Szenario],
  lq.diagram(
    width: 12cm,
    height: 6cm,
    legend: (position: right),
    yaxis: (
      subticks: none,
      ticks: (
        (0, "Handler debuggen"),
        (1, "Auth anpassen"),
        (2, "Feld hinzufügen"),
        (3, "Service verstehen"),
      ),
    ),
    xaxis: (lim: (0, 20), subticks: none),
    xlabel: [Anzahl],
    // Dateien (blau)
    lq.hbar(
      (3.5, 4.5, 6, 7.5),
      (0, 1, 2, 3),
      width: 0.35,
      offset: -0.22,
      fill: rgb("#3b82f6"),
      label: [Dateien],
    ),
    // Kontextwechsel (grün)
    lq.hbar(
      (6, 7, 10, 16),
      (0, 1, 2, 3),
      width: 0.35,
      offset: 0.22,
      fill: rgb("#10b981"),
      label: [Kontextwechsel],
    ),
    // Labels Dateien
    lq.place(3.5, -0.22, align: left, pad(left: 0.3em)[3–4]),
    lq.place(4.5, 0.78, align: left, pad(left: 0.3em)[4–5]),
    lq.place(6, 1.78, align: left, pad(left: 0.3em)[5–7]),
    lq.place(7.5, 2.78, align: left, pad(left: 0.3em)[6–9]),
    // Labels Kontextwechsel
    lq.place(6, 0.22, align: left, pad(left: 0.3em)[5–7]),
    lq.place(7, 1.22, align: left, pad(left: 0.3em)[6–8]),
    lq.place(10, 2.22, align: left, pad(left: 0.3em)[8–12]),
    lq.place(16, 3.22, align: left, pad(left: 0.3em)[12–20]),
  )
)

=== Option 3: Grouped Bar Chart (Dateien + Kontextwechsel)

#figure(
  caption: [Navigationskomplexität: Dateien und Kontextwechsel],
  lq.diagram(
    width: 12cm,
    height: 6cm,
    xaxis: (
      subticks: none,
      ticks: (
        (0, "Debug"),
        (1, "Auth"),
        (2, "Feld"),
        (3, "Verstehen"),
      ),
    ),
    yaxis: (lim: (0, 20), subticks: none),
    ylabel: [Anzahl],
    // Dateien (blau)
    lq.bar(
      (0, 1, 2, 3),
      (3.5, 4.5, 6, 7.5),
      width: 0.35,
      offset: -0.2,
      fill: rgb("#3b82f6"),
      label: [Dateien],
    ),
    // Kontextwechsel (orange)
    lq.bar(
      (0, 1, 2, 3),
      (6, 7, 10, 16),
      width: 0.35,
      offset: 0.2,
      fill: rgb("#f97316"),
      label: [Kontextwechsel],
    ),
  )
)

=== Option 4: Line Plot (Trend)

#figure(
  caption: [Navigationskomplexität als Trend],
  lq.diagram(
    width: 11cm,
    height: 5cm,
    xaxis: (
      subticks: none,
      ticks: (
        (0, "Debug"),
        (1, "Auth"),
        (2, "Feld"),
        (3, "Verstehen"),
      ),
    ),
    yaxis: (lim: (0, 20), subticks: none),
    ylabel: [Anzahl],
    // Dateien
    lq.plot(
      (0, 1, 2, 3),
      (3.5, 4.5, 6, 7.5),
      stroke: rgb("#3b82f6") + 2pt,
      label: [Dateien],
    ),
    // Kontextwechsel
    lq.plot(
      (0, 1, 2, 3),
      (6, 7, 10, 16),
      stroke: rgb("#f97316") + 2pt,
      label: [Kontextwechsel],
    ),
  )
)

#pagebreak()

== Nutzwertanalyse (Integrationsstrategien)

=== Option 1: Horizontales Balkendiagramm (Endergebnis)

#figure(
  caption: [Ergebnis der Nutzwertanalyse],
  lq.diagram(
    width: 11cm,
    height: 4.5cm,
    yaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    xaxis: (lim: (0, 5), subticks: none),
    xlabel: [Nutzwert],
    lq.hbar(
      (2.35, 3.05, 4.15),
      (0, 1, 2),
      width: 0.5,
      fill: (rgb("#ef4444"), rgb("#f59e0b"), rgb("#10b981")),
    ),
    lq.place(2.35, 0, align: left, pad(left: 0.3em)[*2.35*]),
    lq.place(3.05, 1, align: left, pad(left: 0.3em)[*3.05*]),
    lq.place(4.15, 2, align: left, pad(left: 0.3em)[#text(fill: rgb("#10b981"))[*4.15*]]),
  )
)

=== Option 2: Vertikales Balkendiagramm (Endergebnis)

#figure(
  caption: [Ergebnis der Nutzwertanalyse (vertikal)],
  lq.diagram(
    width: 10cm,
    height: 6cm,
    xaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    yaxis: (lim: (0, 5), subticks: none),
    ylabel: [Nutzwert],
    lq.bar(
      (0, 1, 2),
      (2.35, 3.05, 4.15),
      width: 0.6,
      fill: (rgb("#ef4444"), rgb("#f59e0b"), rgb("#10b981")),
    ),
    lq.place(0, 2.35, align: bottom, pad(bottom: 0.3em)[*2.35*]),
    lq.place(1, 3.05, align: bottom, pad(bottom: 0.3em)[*3.05*]),
    lq.place(2, 4.15, align: bottom, pad(bottom: 0.3em)[#text(fill: rgb("#10b981"))[*4.15*]]),
  )
)

=== Option 3: Grouped Bar Chart (alle Kriterien)

#figure(
  caption: [Punktevergleich nach Bewertungskriterien],
  lq.diagram(
    width: 13cm,
    height: 6cm,
    yaxis: (lim: (0, 5.5), subticks: none),
    xaxis: (
      subticks: none,
      ticks: (
        (0, "Semantik"),
        (1, "Position"),
        (2, "VS Code"),
        (3, "Aufwand"),
        (4, "Wartung"),
        (5, "Unabh."),
      ),
    ),
    ylabel: [Punkte],
    // Repository (rot)
    lq.bar(
      (0, 1, 2, 3, 4, 5),
      (2, 3, 2, 2, 2, 5),
      width: 0.25,
      offset: -0.28,
      fill: rgb("#ef4444"),
      label: [Repository],
    ),
    // CSN (orange)
    lq.bar(
      (0, 1, 2, 3, 4, 5),
      (5, 1, 3, 4, 3, 2),
      width: 0.25,
      offset: 0,
      fill: rgb("#f59e0b"),
      label: [CSN],
    ),
    // Language Server (grün)
    lq.bar(
      (0, 1, 2, 3, 4, 5),
      (5, 5, 5, 3, 4, 2),
      width: 0.25,
      offset: 0.28,
      fill: rgb("#10b981"),
      label: [Language Server],
    ),
  )
)

#pagebreak()

== Anforderungsabdeckung (Integrationsstrategien)

=== Option 1: Grouped Bar Chart (Erfüllungsgrad)

#figure(
  caption: [Anforderungserfüllung pro Strategie],
  lq.diagram(
    width: 13cm,
    height: 5cm,
    xaxis: (
      subticks: none,
      ticks: (
        (0, "FA1"), (1, "FA2"), (2, "FA3"), (3, "FA4"),
        (4, "NFA1"), (5, "NFA2"), (6, "NFA3"), (7, "NFA4"),
      ),
    ),
    yaxis: (
      lim: (0, 2.5),
      ticks: ((0, "○"), (1, "◐"), (2, "●")),
      subticks: none,
    ),
    ylabel: [Erfüllung],
    // Repository
    lq.bar(
      (0, 1, 2, 3, 4, 5, 6, 7),
      (1, 1, 2, 1, 0, 1, 0, 0),
      width: 0.25,
      offset: -0.28,
      fill: rgb("#ef4444"),
      label: [Repository],
    ),
    // CSN
    lq.bar(
      (0, 1, 2, 3, 4, 5, 6, 7),
      (2, 2, 0, 2, 1, 2, 2, 1),
      width: 0.25,
      offset: 0,
      fill: rgb("#f59e0b"),
      label: [CSN],
    ),
    // Language Server
    lq.bar(
      (0, 1, 2, 3, 4, 5, 6, 7),
      (2, 2, 2, 2, 2, 2, 2, 2),
      width: 0.25,
      offset: 0.28,
      fill: rgb("#10b981"),
      label: [Language Server],
    ),
  )
)

=== Option 2: Line Plot (Anforderungserfüllung)

#figure(
  caption: [Anforderungserfüllung als Linienverlauf],
  lq.diagram(
    width: 12cm,
    height: 5cm,
    xaxis: (
      subticks: none,
      ticks: (
        (0, "FA1"), (1, "FA2"), (2, "FA3"), (3, "FA4"),
        (4, "NFA1"), (5, "NFA2"), (6, "NFA3"), (7, "NFA4"),
      ),
    ),
    yaxis: (
      lim: (-0.5, 2.5),
      ticks: ((0, "○"), (1, "◐"), (2, "●")),
      subticks: none,
    ),
    ylabel: [Erfüllung],
    // Repository
    lq.plot(
      (0, 1, 2, 3, 4, 5, 6, 7),
      (1, 1, 2, 1, 0, 1, 0, 0),
      stroke: rgb("#ef4444") + 2pt,
      label: [Repository],
    ),
    // CSN
    lq.plot(
      (0, 1, 2, 3, 4, 5, 6, 7),
      (2, 2, 0, 2, 1, 2, 2, 1),
      stroke: rgb("#f59e0b") + 2pt,
      label: [CSN],
    ),
    // Language Server
    lq.plot(
      (0, 1, 2, 3, 4, 5, 6, 7),
      (2, 2, 2, 2, 2, 2, 2, 2),
      stroke: rgb("#10b981") + 2pt,
      label: [Language Server],
    ),
  )
)

=== Option 3: Summen-Balkendiagramm

#figure(
  caption: [Summe der voll erfüllten Anforderungen],
  lq.diagram(
    width: 10cm,
    height: 5cm,
    yaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    xaxis: (lim: (0, 8), subticks: none),
    xlabel: [Anzahl voll erfüllte Anforderungen (●)],
    lq.hbar(
      (1, 5, 8),
      (0, 1, 2),
      width: 0.5,
      fill: (rgb("#ef4444"), rgb("#f59e0b"), rgb("#10b981")),
    ),
    lq.place(1, 0, align: left, pad(left: 0.3em)[*1* von 8]),
    lq.place(5, 1, align: left, pad(left: 0.3em)[*5* von 8]),
    lq.place(8, 2, align: left, pad(left: 0.3em)[#text(fill: rgb("#10b981"))[*8* von 8]]),
  )
)

#pagebreak()

== Trade-off Visualisierung

=== Option 1: Scatter Plot (Unabhängigkeit vs. Nutzwert)

#figure(
  caption: [Trade-off: Unabhängigkeit vs. Funktionalität],
  lq.diagram(
    width: 10cm,
    height: 8cm,
    xaxis: (lim: (1.5, 5)),
    yaxis: (lim: (1, 5.5)),
    xlabel: [Nutzwert (Funktionalität)],
    ylabel: [Unabhängigkeit],
    // Repository
    lq.scatter(
      (2.35,),
      (5,),
      stroke: rgb("#ef4444") + 4pt,
    ),
    // CSN
    lq.scatter(
      (3.05,),
      (2,),
      stroke: rgb("#f59e0b") + 4pt,
    ),
    // Language Server
    lq.scatter(
      (4.15,),
      (2,),
      stroke: rgb("#10b981") + 4pt,
    ),
    lq.place(2.35, 5, align: bottom, pad(bottom: 0.5em)[#text(fill: rgb("#ef4444"))[Repository]]),
    lq.place(3.05, 2, align: top, pad(top: 0.5em)[#text(fill: rgb("#f59e0b"))[CSN]]),
    lq.place(4.15, 2, align: top, pad(top: 0.5em)[#text(fill: rgb("#10b981"))[Language Server]]),
  )
)

#pagebreak()

== Weitere Optionen

=== Stacked Bar Chart Beispiel

#figure(
  caption: [Anforderungserfüllung gestapelt],
  lq.diagram(
    width: 10cm,
    height: 5cm,
    xaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    yaxis: (lim: (0, 9), subticks: none),
    ylabel: [Anzahl Anforderungen],
    // Nicht erfüllt (basis)
    lq.bar(
      (0, 1, 2),
      (4, 1, 0),
      width: 0.6,
      fill: rgb("#fecaca"),
      label: [○ nicht erfüllt],
    ),
    // Teilweise erfüllt
    lq.bar(
      (0, 1, 2),
      (3, 2, 0),
      width: 0.6,
      base: (4, 1, 0),
      fill: rgb("#fde68a"),
      label: [◐ teilweise],
    ),
    // Voll erfüllt
    lq.bar(
      (0, 1, 2),
      (1, 5, 8),
      width: 0.6,
      base: (7, 3, 0),
      fill: rgb("#bbf7d0"),
      label: [● voll erfüllt],
    ),
  )
)

=== Einfache Übersicht (Nur Endergebnis)

#figure(
  caption: [Strategiebewertung - Übersicht],
  lq.diagram(
    width: 12cm,
    height: 4cm,
    yaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    xaxis: (lim: (0, 5), ticks: ((1, "1"), (2, "2"), (3, "3"), (4, "4"), (5, "5")), subticks: none),
    xlabel: [Bewertung (1-5)],
    lq.hbar(
      (2.35, 3.05, 4.15),
      (0, 1, 2),
      width: 0.4,
      fill: gradient.linear(rgb("#ef4444"), rgb("#f59e0b"), rgb("#10b981")),
    ),
  )
)

#pagebreak()

== NEUE Optionen (März 2026)

=== NEU Option 1: Liniendiagramm (Bewertungsprofile)

#figure(
  caption: [Bewertungsprofile der Integrationsstrategien],
  lq.diagram(
    width: 14cm,
    height: 7cm,
    legend: (position: right),
    xaxis: (
      subticks: none,
      ticks: (
        (0, "Semantik"),
        (1, "Position"),
        (2, "VS Code"),
        (3, "Aufwand"),
        (4, "Wartung"),
        (5, "Unabh."),
      ),
    ),
    yaxis: (lim: (0, 5.5), subticks: none),
    ylabel: [Punktwert],
    // Repository - Linie + Punkte
    lq.plot(
      (0, 1, 2, 3, 4, 5),
      (2, 3, 2, 2, 2, 5),
      stroke: rgb("#ef4444") + 2pt,
      label: [Repository],
    ),
    lq.scatter((0, 1, 2, 3, 4, 5), (2, 3, 2, 2, 2, 5), stroke: rgb("#ef4444") + 3pt),
    // CSN - Linie + Punkte
    lq.plot(
      (0, 1, 2, 3, 4, 5),
      (5, 1, 3, 4, 3, 2),
      stroke: rgb("#f59e0b") + 2pt,
      label: [CSN],
    ),
    lq.scatter((0, 1, 2, 3, 4, 5), (5, 1, 3, 4, 3, 2), stroke: rgb("#f59e0b") + 3pt),
    // Language Server - Linie + Punkte
    lq.plot(
      (0, 1, 2, 3, 4, 5),
      (5, 5, 5, 3, 4, 2),
      stroke: rgb("#10b981") + 2pt,
      label: [Language Server],
    ),
    lq.scatter((0, 1, 2, 3, 4, 5), (5, 5, 5, 3, 4, 2), stroke: rgb("#10b981") + 3pt),
  )
)

=== NEU Option 2: Scatter Plot (Trade-off Semantik vs. Position)

#figure(
  caption: [Trade-off: Semantische Genauigkeit vs. Positionsinformationen],
  lq.diagram(
    width: 10cm,
    height: 8cm,
    xaxis: (lim: (0, 6)),
    yaxis: (lim: (0, 6)),
    xlabel: [Semantische Genauigkeit],
    ylabel: [Positionsinformationen],
    // Ideallinie (diagonal)
    lq.plot((0, 6), (0, 6), stroke: (dash: "dashed", paint: gray)),
    // Repository
    lq.scatter((2,), (3,), stroke: rgb("#ef4444") + 5pt),
    lq.place(2.4, 3, align: left, [Repository]),
    // CSN
    lq.scatter((5,), (1,), stroke: rgb("#f59e0b") + 5pt),
    lq.place(5.4, 1, align: left, [CSN]),
    // Language Server (größer = besser)
    lq.scatter((5,), (5,), stroke: rgb("#10b981") + 6pt),
    lq.place(4, 5.3, align: left, [#text(fill: rgb("#10b981"), weight: "bold")[Language Server]]),
  )
)

=== NEU Option 3: Horizontales Balkendiagramm mit Benchmark-Linie

#figure(
  caption: [Nutzwertanalyse mit Mindestanforderung],
  lq.diagram(
    width: 11cm,
    height: 5cm,
    yaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    xaxis: (lim: (0, 5), subticks: none),
    xlabel: [Nutzwert],
    lq.hbar(
      (2.35, 3.05, 4.15),
      (0, 1, 2),
      width: 0.5,
      fill: (rgb("#ef4444"), rgb("#f59e0b"), rgb("#10b981")),
    ),
    // Mindestanforderung-Linie bei 3.5
    lq.plot((3.5, 3.5), (-0.5, 2.5), stroke: (dash: "dashed", paint: rgb("#6b7280"), thickness: 1.5pt)),
    lq.place(3.6, 2.3, align: left, text(size: 8pt, fill: rgb("#6b7280"))[Mindest-\ anforderung]),
    // Labels
    lq.place(2.35, 0, align: left, pad(left: 0.3em)[*2.35*]),
    lq.place(3.05, 1, align: left, pad(left: 0.3em)[*3.05*]),
    lq.place(4.15, 2, align: left, pad(left: 0.3em)[#text(fill: rgb("#10b981"))[*4.15*]]),
  )
)

=== NEU Option 4: Kombiniertes Diagramm (Balken + Scatter für Gewichtung)

#figure(
  caption: [Bewertung nach Kriterien mit Gewichtungsindikator],
  lq.diagram(
    width: 14cm,
    height: 7cm,
    legend: (position: top),
    xaxis: (
      subticks: none,
      ticks: (
        (0, [Semantik\ (25%)]),
        (1, [Position\ (25%)]),
        (2, [VS Code\ (20%)]),
        (3, [Aufwand\ (15%)]),
        (4, [Wartung\ (10%)]),
        (5, [Unabh.\ (5%)]),
      ),
    ),
    yaxis: (lim: (0, 5.5), subticks: none),
    ylabel: [Punktwert],
    // Repository (rot)
    lq.bar(
      (0, 1, 2, 3, 4, 5),
      (2, 3, 2, 2, 2, 5),
      width: 0.22,
      offset: -0.25,
      fill: rgb("#ef4444"),
      label: [Repository],
    ),
    // CSN (orange)
    lq.bar(
      (0, 1, 2, 3, 4, 5),
      (5, 1, 3, 4, 3, 2),
      width: 0.22,
      offset: 0,
      fill: rgb("#f59e0b"),
      label: [CSN],
    ),
    // Language Server (grün)
    lq.bar(
      (0, 1, 2, 3, 4, 5),
      (5, 5, 5, 3, 4, 2),
      width: 0.22,
      offset: 0.25,
      fill: rgb("#10b981"),
      label: [Language Server],
    ),
  )
)

=== NEU Option 5: Bullet Chart Style

#figure(
  caption: [Nutzwertanalyse als Bullet Chart],
  lq.diagram(
    width: 12cm,
    height: 5cm,
    yaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    xaxis: (lim: (0, 5), subticks: none, ticks: ((1, "1"), (2, "2"), (3, "3"), (4, "4"), (5, "5"))),
    xlabel: [Nutzwert],
    // Hintergrund-Bereiche (Zonen)
    lq.hbar((2.5, 2.5, 2.5), (0, 1, 2), width: 0.8, fill: rgb("#fecaca").lighten(50%)),
    lq.hbar((1.0, 1.0, 1.0), (0, 1, 2), width: 0.8, base: (2.5, 2.5, 2.5), fill: rgb("#fde68a").lighten(50%)),
    lq.hbar((1.5, 1.5, 1.5), (0, 1, 2), width: 0.8, base: (3.5, 3.5, 3.5), fill: rgb("#bbf7d0").lighten(50%)),
    // Tatsächliche Werte (schmal)
    lq.hbar((2.35, 3.05, 4.15), (0, 1, 2), width: 0.3, fill: rgb("#1f2937")),
    // Labels
    lq.place(2.35, 0, align: left, pad(left: 0.3em, top: 0.1em)[#text(fill: white, size: 8pt)[2.35]]),
    lq.place(3.05, 1, align: left, pad(left: 0.3em, top: 0.1em)[#text(fill: white, size: 8pt)[3.05]]),
    lq.place(4.15, 2, align: left, pad(left: 0.3em, top: 0.1em)[#text(fill: white, size: 8pt)[4.15]]),
  )
)

#text(size: 9pt)[Legende: #box(fill: rgb("#fecaca").lighten(50%), width: 1em, height: 0.8em) Unzureichend | #box(fill: rgb("#fde68a").lighten(50%), width: 1em, height: 0.8em) Ausreichend | #box(fill: rgb("#bbf7d0").lighten(50%), width: 1em, height: 0.8em) Gut]

#pagebreak()

=== NEU Option 6: Gewichteter Nutzwert aufgeschlüsselt

#figure(
  caption: [Zusammensetzung des Nutzwerts nach Kriterien],
  lq.diagram(
    width: 12cm,
    height: 5cm,
    yaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    xaxis: (lim: (0, 4.5), subticks: none),
    xlabel: [Gewichteter Nutzwert],
    // Semantik (25%): 2*0.25=0.5, 5*0.25=1.25, 5*0.25=1.25
    lq.hbar((0.50, 1.25, 1.25), (0, 1, 2), width: 0.5, fill: rgb("#3b82f6"), label: [Semantik]),
    // Position (25%): 3*0.25=0.75, 1*0.25=0.25, 5*0.25=1.25
    lq.hbar((0.75, 0.25, 1.25), (0, 1, 2), width: 0.5, base: (0.50, 1.25, 1.25), fill: rgb("#8b5cf6"), label: [Position]),
    // VS Code (20%): 2*0.2=0.4, 3*0.2=0.6, 5*0.2=1.0
    lq.hbar((0.40, 0.60, 1.00), (0, 1, 2), width: 0.5, base: (1.25, 1.50, 2.50), fill: rgb("#06b6d4"), label: [VS Code]),
    // Aufwand (15%): 2*0.15=0.3, 4*0.15=0.6, 3*0.15=0.45
    lq.hbar((0.30, 0.60, 0.45), (0, 1, 2), width: 0.5, base: (1.65, 2.10, 3.50), fill: rgb("#10b981"), label: [Aufwand]),
    // Wartung (10%): 2*0.1=0.2, 3*0.1=0.3, 4*0.1=0.4
    lq.hbar((0.20, 0.30, 0.40), (0, 1, 2), width: 0.5, base: (1.95, 2.70, 3.95), fill: rgb("#f59e0b"), label: [Wartung]),
    // Unabh (5%): 5*0.05=0.25, 2*0.05=0.1, 2*0.05=0.1
    lq.hbar((0.25, 0.10, 0.10), (0, 1, 2), width: 0.5, base: (2.15, 3.00, 4.35), fill: rgb("#ef4444"), label: [Unabh.]),
  )
)

=== NEU Option 7: Einfaches Fazit-Diagramm

#figure(
  caption: [Strategievergleich: Fazit],
  lq.diagram(
    width: 11cm,
    height: 4cm,
    yaxis: (
      subticks: none,
      ticks: ((0, "Repository"), (1, "CSN"), (2, "Language Server")),
    ),
    xaxis: (lim: (0, 5), subticks: none),
    xlabel: [Gesamtbewertung],
    lq.hbar(
      (2.35, 3.05, 4.15),
      (0, 1, 2),
      width: 0.6,
      fill: (rgb("#ef4444"), rgb("#f59e0b"), rgb("#10b981")),
    ),
    // Empfehlungs-Markierung
    lq.scatter((4.15,), (2,), stroke: rgb("#10b981") + 4pt),
    // Labels mit Bewertung
    lq.place(2.35, 0, align: left, pad(left: 0.3em)[2.35 — nicht empfohlen]),
    lq.place(3.05, 1, align: left, pad(left: 0.3em)[3.05 — bedingt geeignet]),
    lq.place(4.15, 2, align: left, pad(left: 0.3em)[#text(fill: rgb("#10b981"), weight: "bold")[4.15 — empfohlen]]),
  )
)

#pagebreak()

== TABELLEN-OPTIONEN (kompakt & schön)

=== Tabelle Option 1: Kompakte Matrix mit Symbolen

#figure(
  caption: [Strategievergleich - Kompakte Übersicht],
  table(
    columns: (1.8fr, 1fr, 1fr, 1fr),
    inset: 6pt,
    align: (left, center, center, center),
    stroke: none,
    fill: (x, y) => if y == 0 { rgb("#f1f5f9") } else if calc.odd(y) { rgb("#f8fafc") } else { white },
    table.hline(stroke: 1.5pt + rgb("#334155")),
    [*Kriterium*], [*Repo*], [*CSN*], [*LS*],
    table.hline(stroke: 0.5pt + rgb("#cbd5e1")),
    [Semantische Genauigkeit], [○○], [●●●●●], [●●●●●],
    [Positionsinformationen], [○○○], [○], [●●●●●],
    [VS Code Integration], [○○], [○○○], [●●●●●],
    [Implementierungsaufwand], [○○], [○○○○], [○○○],
    [Wartbarkeit], [○○], [○○○], [○○○○],
    [Unabhängigkeit], [●●●●●], [○○], [○○],
    table.hline(stroke: 1.5pt + rgb("#334155")),
    [*Nutzwert*], [*2.35*], [*3.05*], [#text(fill: rgb("#10b981"), weight: "bold")[*4.15*]],
    table.hline(stroke: 1.5pt + rgb("#334155")),
  )
)

#text(size: 8pt, fill: rgb("#64748b"))[Legende: ● = 1 Punkt (max. 5)]

=== Tabelle Option 2: Minimalistisch mit Farb-Highlighting

#figure(
  caption: [Nutzwertanalyse - Minimalistisch],
  table(
    columns: (2fr, 0.6fr, 0.8fr, 0.8fr, 0.8fr),
    inset: (x: 8pt, y: 5pt),
    align: (left, center, center, center, center),
    stroke: none,
    table.hline(stroke: 2pt + black),
    [], [*Gew.*], [*Repo*], [*CSN*], [*LS*],
    table.hline(stroke: 0.5pt + rgb("#e2e8f0")),
    [Semantik], [25%], [2], [5], table.cell(fill: rgb("#dcfce7"))[5],
    [Position], [25%], [3], [1], table.cell(fill: rgb("#dcfce7"))[5],
    [VS Code], [20%], [2], [3], table.cell(fill: rgb("#dcfce7"))[5],
    [Aufwand], [15%], [2], table.cell(fill: rgb("#dcfce7"))[4], [3],
    [Wartung], [10%], [2], [3], table.cell(fill: rgb("#dcfce7"))[4],
    [Unabh.], [5%], table.cell(fill: rgb("#dcfce7"))[5], [2], [2],
    table.hline(stroke: 2pt + black),
    [*Summe*], [100%], [2.35], [3.05], table.cell(fill: rgb("#22c55e"), text(fill: white, weight: "bold")[4.15]),
    table.hline(stroke: 2pt + black),
  )
)

=== Tabelle Option 3: Booktabs-Style (akademisch)

#figure(
  caption: [Bewertungsmatrix im wissenschaftlichen Stil],
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: (x: 10pt, y: 6pt),
    align: (left, center, center, center, center),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*Kriterium*], [*Gewicht*], [*Repository*], [*CSN*], [*Lang. Server*]
    ),
    table.hline(stroke: 0.75pt),
    [Sem. Genauigkeit], [25%], [2], [5], [5],
    [Positionsinfo], [25%], [3], [1], [5],
    [VS Code Integr.], [20%], [2], [3], [5],
    [Impl.-Aufwand], [15%], [2], [4], [3],
    [Wartbarkeit], [10%], [2], [3], [4],
    [Unabhängigkeit], [5%], [5], [2], [2],
    table.hline(stroke: 0.75pt),
    [*Nutzwert*], [], [*2.35*], [*3.05*], [*4.15*],
    table.hline(stroke: 1.5pt),
  )
)

=== Tabelle Option 4: Farbige Heatmap-Tabelle

#let score-color(score) = {
  if score >= 5 { rgb("#166534") }
  else if score >= 4 { rgb("#16a34a") }
  else if score >= 3 { rgb("#ca8a04") }
  else if score >= 2 { rgb("#ea580c") }
  else { rgb("#dc2626") }
}

#let score-cell(score) = table.cell(
  fill: score-color(score).lighten(70%),
  text(fill: score-color(score), weight: "bold")[#score]
)

#figure(
  caption: [Heatmap-Bewertung der Strategien],
  table(
    columns: (2fr, 0.8fr, 0.8fr, 0.8fr),
    inset: 6pt,
    align: (left, center, center, center),
    stroke: 0.5pt + rgb("#e2e8f0"),
    table.header(
      table.cell(fill: rgb("#1e293b"), text(fill: white)[*Kriterium*]),
      table.cell(fill: rgb("#1e293b"), text(fill: white)[*Repo*]),
      table.cell(fill: rgb("#1e293b"), text(fill: white)[*CSN*]),
      table.cell(fill: rgb("#1e293b"), text(fill: white)[*LS*]),
    ),
    [Semantik (25%)], score-cell(2), score-cell(5), score-cell(5),
    [Position (25%)], score-cell(3), score-cell(1), score-cell(5),
    [VS Code (20%)], score-cell(2), score-cell(3), score-cell(5),
    [Aufwand (15%)], score-cell(2), score-cell(4), score-cell(3),
    [Wartung (10%)], score-cell(2), score-cell(3), score-cell(4),
    [Unabh. (5%)], score-cell(5), score-cell(2), score-cell(2),
  )
)

=== Tabelle Option 5: Sehr kompakt mit Balken

#let bar(value, max: 5, color: rgb("#3b82f6")) = {
  let pct = value / max * 100%
  box(
    width: 2.5em,
    height: 0.8em,
    fill: rgb("#e2e8f0"),
    radius: 2pt,
    box(width: pct, height: 100%, fill: color, radius: 2pt)
  )
}

#figure(
  caption: [Kompakter Vergleich mit Inline-Balken],
  table(
    columns: (1.5fr, 1fr, 1fr, 1fr),
    inset: 5pt,
    align: (left, center, center, center),
    stroke: none,
    fill: (x, y) => if y == 0 { rgb("#0f172a") },
    table.hline(stroke: 0pt),
    text(fill: white, size: 9pt)[*Kriterium*],
    text(fill: white, size: 9pt)[*Repository*],
    text(fill: white, size: 9pt)[*CSN*],
    text(fill: white, size: 9pt)[*Lang.Srv*],
    table.hline(stroke: 0.5pt + rgb("#cbd5e1")),
    [Semantik], bar(2, color: rgb("#ef4444")), bar(5, color: rgb("#f59e0b")), bar(5, color: rgb("#10b981")),
    [Position], bar(3, color: rgb("#ef4444")), bar(1, color: rgb("#f59e0b")), bar(5, color: rgb("#10b981")),
    [VS Code], bar(2, color: rgb("#ef4444")), bar(3, color: rgb("#f59e0b")), bar(5, color: rgb("#10b981")),
    [Aufwand], bar(2, color: rgb("#ef4444")), bar(4, color: rgb("#f59e0b")), bar(3, color: rgb("#10b981")),
    [Wartung], bar(2, color: rgb("#ef4444")), bar(3, color: rgb("#f59e0b")), bar(4, color: rgb("#10b981")),
    [Unabh.], bar(5, color: rgb("#ef4444")), bar(2, color: rgb("#f59e0b")), bar(2, color: rgb("#10b981")),
    table.hline(stroke: 1pt + rgb("#334155")),
  )
)

#pagebreak()

=== Tabelle Option 6: Icons statt Zahlen

#let icon(level) = {
  if level >= 5 { text(fill: rgb("#166534"))[●●●●●] }
  else if level >= 4 { text(fill: rgb("#16a34a"))[●●●●○] }
  else if level >= 3 { text(fill: rgb("#ca8a04"))[●●●○○] }
  else if level >= 2 { text(fill: rgb("#ea580c"))[●●○○○] }
  else { text(fill: rgb("#dc2626"))[●○○○○] }
}

#figure(
  caption: [Icon-basierte Bewertungsübersicht],
  table(
    columns: (2fr, 1.2fr, 1.2fr, 1.2fr),
    inset: (x: 6pt, y: 4pt),
    align: (left, center, center, center),
    stroke: none,
    table.hline(stroke: 1.5pt + rgb("#1e293b")),
    [*Kriterium*], [*Repository*], [*CSN*], [*Language Server*],
    table.hline(stroke: 0.5pt + rgb("#94a3b8")),
    [Semantik], icon(2), icon(5), icon(5),
    [Position], icon(3), icon(1), icon(5),
    [VS Code], icon(2), icon(3), icon(5),
    [Aufwand], icon(2), icon(4), icon(3),
    [Wartung], icon(2), icon(3), icon(4),
    [Unabh.], icon(5), icon(2), icon(2),
    table.hline(stroke: 1.5pt + rgb("#1e293b")),
  )
)

=== Tabelle Option 7: Anforderungsmatrix (Check/X)

#let check = text(fill: rgb("#16a34a"), weight: "bold")[✓]
#let partial = text(fill: rgb("#ca8a04"))[◐]
#let cross = text(fill: rgb("#dc2626"))[✗]

#figure(
  caption: [Anforderungserfüllung - Übersicht],
  table(
    columns: (2.5fr, 1fr, 1fr, 1fr),
    inset: (x: 8pt, y: 5pt),
    align: (left, center, center, center),
    stroke: (x, y) => if y == 0 { (bottom: 1pt + black) } else { (bottom: 0.5pt + rgb("#e2e8f0")) },
    fill: (x, y) => if x == 3 { rgb("#f0fdf4") },
    [*Anforderung*], [*Repo*], [*CSN*], [*LS*],
    [FA1: Services identifizieren], partial, check, check,
    [FA2: Aggregierte Darstellung], partial, check, check,
    [FA3: Navigation zu Quellcode], check, cross, check,
    [FA4: Beziehungen darstellen], partial, check, check,
    [NFA1: VS Code Integration], cross, partial, check,
    [NFA2: CAP-Kompatibilität], partial, check, check,
    [NFA3: Performanz], cross, check, check,
    [NFA4: Aktualität], cross, partial, check,
    table.hline(stroke: 1pt + black),
    [*Voll erfüllt (✓)*], [*1*], [*5*], [#text(fill: rgb("#16a34a"), weight: "bold")[*8*]],
  )
)

=== Tabelle Option 8: Dreispaltige Zusammenfassung

#figure(
  caption: [Strategieempfehlung auf einen Blick],
  grid(
    columns: 3,
    gutter: 1em,
    // Repository
    rect(
      width: 100%,
      fill: rgb("#fef2f2"),
      stroke: 1pt + rgb("#fecaca"),
      radius: 4pt,
      inset: 10pt,
    )[
      #align(center)[
        #text(fill: rgb("#dc2626"), weight: "bold", size: 11pt)[Repository]
        #v(0.3em)
        #text(size: 24pt, weight: "bold")[2.35]
        #v(0.3em)
        #text(size: 9pt, fill: rgb("#991b1b"))[Nicht empfohlen]
      ]
    ],
    // CSN
    rect(
      width: 100%,
      fill: rgb("#fffbeb"),
      stroke: 1pt + rgb("#fde68a"),
      radius: 4pt,
      inset: 10pt,
    )[
      #align(center)[
        #text(fill: rgb("#d97706"), weight: "bold", size: 11pt)[CSN]
        #v(0.3em)
        #text(size: 24pt, weight: "bold")[3.05]
        #v(0.3em)
        #text(size: 9pt, fill: rgb("#92400e"))[Bedingt geeignet]
      ]
    ],
    // Language Server
    rect(
      width: 100%,
      fill: rgb("#f0fdf4"),
      stroke: 2pt + rgb("#22c55e"),
      radius: 4pt,
      inset: 10pt,
    )[
      #align(center)[
        #text(fill: rgb("#16a34a"), weight: "bold", size: 11pt)[Language Server]
        #v(0.3em)
        #text(size: 24pt, weight: "bold")[4.15]
        #v(0.3em)
        #text(size: 9pt, fill: rgb("#166534"))[✓ Empfohlen]
      ]
    ],
  )
)
