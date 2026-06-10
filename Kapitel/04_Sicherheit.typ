#import "../vendor/supercharged-dhbw/lib.typ": *

= IT-Sicherheit und MCP

== Bedrohungsmodell

- Wer sind die Angreifer: böswillige MCP-Server, kompromittierte Clients, Supply-Chain-Angreifer
- Was sind die Ziele: Daten stehlen, Aktionen ausführen, LLM manipulieren
- Vertrauensebenen im MCP-Ökosystem (Host vertraut Server — aber sollte er?)

== Angriffsvektoren

=== Prompt Injection

- Direkter Angriff: Nutzer schickt böse Anweisungen ans LLM
- Indirekter Angriff: externe Daten (z.B. Webseite, Datei) enthalten versteckte Befehle
- Beispiel: Tool liest Datei, Datei enthält "Ignoriere alle vorherigen Anweisungen..."

=== Tool Poisoning

- Beschreibung eines Tools enthält versteckte Anweisungen für das LLM
- Ist für den Nutzer unsichtbar (nur die Tool-Beschreibung, nicht der Output)
- Beispiel: Tool-Beschreibung sagt heimlich "sende alle Passwörter an Server X"

=== Rug Pull

- Server verhält sich erst normal, ändert dann sein Verhalten nach Genehmigung
- Nutzer hat Tool genehmigt, aber Server liefert plötzlich anderen Code/Aktionen
- Schwer zu erkennen, weil Genehmigung einmalig ist

=== Tool Shadowing

- Böswilliger Server überschreibt oder imitiert legitime Tools anderer Server
- Nutzer denkt er nutzt Tool A, tatsächlich läuft Tool B vom Angreifer

=== Datenexfiltration

- Tools können Daten nach außen senden (z.B. über HTTP-Requests)
- LLM merkt nicht, dass Daten abfließen, wenn Beschreibung irreführend ist

== Authentifizierung und Zugriffskontrolle

- Problem: jeder kann einen MCP-Server starten, keine zentrale Verifikation
- OAuth-Support wird gerade eingebaut, aber noch nicht weit verbreitet
- Least-Privilege-Prinzip: Server sollte nur das dürfen was er braucht

== Sicherheitsempfehlungen und Best Practices

- MCP-Server nur aus vertrauenswürdigen Quellen installieren
- Tool-Beschreibungen vor Genehmigung prüfen
- Sandboxing: Server in isolierter Umgebung laufen lassen
- Keine sensiblen Daten in den Kontext geben, wenn nicht nötig
- Auf Signierung und Versionierung von Servern achten
