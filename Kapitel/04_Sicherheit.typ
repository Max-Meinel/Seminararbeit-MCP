#import "../vendor/supercharged-dhbw/lib.typ": *

= IT-Sicherheit und MCP

== Bedrohungsmodell und Angriffsflächen

- Wer kann angreifen: böswilliger Server, kompromittierter Client
- Was kann angegriffen werden: Daten, Aktionen, das LLM selbst

== Authentifizierung, Autorisierung und Zugriffskontrolle

- Wie prüft man ob ein MCP-Server vertrauenswürdig ist
- Problem: momentan kaum Authentifizierung vorhanden
- OAuth-Support wird gerade eingebaut

== Prompt Injection und Tool Poisoning

- Prompt Injection: Server schickt böse Anweisungen ans LLM
- Tool Poisoning: Tool-Beschreibungen enthalten versteckte Befehle
- Konkrete Beispiele zeigen

== Sicherheitsempfehlungen und Best Practices

- Was Entwickler beim Bauen von MCP-Servern beachten sollen
- Wie man MCP sicher deployt (Sandboxing, Least Privilege)
