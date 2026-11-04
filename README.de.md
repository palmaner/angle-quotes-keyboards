# Guillemets für Windows

[Español](README.es.md) · [English](README.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Português](README.pt.md) · [Norsk bokmål](README.nb.md) · [Dansk](README.da.md) · [Русский](README.ru.md) · [Українська](README.uk.md) · [Беларуская](README.be.md)

Ich habe diese 17 nativen Belegungen erstellt, um Guillemets (französische Anführungszeichen) mit AltGr zu tippen. Die ursprüngliche Tastatur bleibt erhalten; AutoHotkey oder Hintergrundprogramme sind nicht nötig.

Die Sammlung enthält **15 ursprüngliche Varianten und zwei experimentelle englische Varianten: USA und Vereinigtes Königreich**.

**[Tastaturen herunterladen](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · [Problem melden](https://github.com/palmaner/angle-quotes-keyboards/issues)

## Videoanleitung

Installation, ein Schreibbeispiel mit Anzeige der Tastendrücke und Deinstallation. Die Texte im Video sind auf Englisch (1 Min. 40 Sek.).

<https://github.com/user-attachments/assets/929ffdb1-1dc7-4a61-92c1-566bd14acf4a>

## Belegung auswählen

Wähle nach deiner bisherigen Tastatur, nicht nur nach deiner Nationalität. Die Links führen zu den lokalen Anleitungen mit allen geänderten Positionen.

| Belegungen und Anleitungen | Öffnend | Schließend |
| --- | --- | --- |
| [Spanisch (Spanien)](Spanish-Spain/README.txt), [Spanisch (Lateinamerika)](Spanish-Latin-America/README.txt), [Italienisch](Italian/README.txt), [Russisch](Russian/README.txt), [Ukrainisch](Ukrainian/README.txt), [Belarussisch](Belarusian/README.txt), [Belgisches Französisch](Belgian-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| [Portugiesisch (Portugal)](Portuguese-Portugal/README.txt), [Norwegisch](Norwegian/README.txt) | AltGr+5 → « | AltGr+6 → » |
| [Deutsch (Deutschland)](German-Germany/README.txt), [Deutsch (Österreich)](German-Austria/README.txt), [Dänisch](Danish/README.txt) | AltGr+5 → » | AltGr+6 → « |
| [Schweizer Französisch](Swiss-French/README.txt), [Schweizer Deutsch](Swiss-German/README.txt), [Luxemburg mit Schweizer Französisch](Luxembourg-Swiss-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| **Experimentell:** [Englisch (USA)](English-United-States/README.txt), [Englisch (Vereinigtes Königreich)](English-United-Kingdom/README.txt) | AltGr+5 → « | AltGr+7 → » |

Die beiden englischen Varianten dienen zum Ausprobieren von Guillemets, nicht als Vorschlag für eine neue englische Zeichensetzung. Sie verwenden die normalen US- und UK-Belegungen; die rechte Alt-Taste wird zu AltGr. Es handelt sich nicht um US-International oder UK Extended.

## Installation

Windows 10/11 auf x86- oder x64-PCs; ARM64 ist nicht enthalten. Internet und eine Installation von Keyboard Layout Creator sind nicht nötig.

1. Entpacke die gesamte ZIP-Datei und öffne den Ordner deiner Belegung. Lass die Dateien zusammen.
2. Öffne **setup.exe** normal, ohne **Als Administrator ausführen**. Das Kästchen **„Als Standardtastatur für mein Konto verwenden“** ist optional: Aktiviere es, um die Einstellung über Sitzungen hinweg zu speichern. Nur die Installation fordert Administratorrechte an.
3. Drücke **Win+Leertaste** und wähle den Namen mit **“- Angle Quotes”** am Ende.
4. Teste AltGr (rechte Alt-Taste) und die obere Zahlenreihe im Editor.

**Das Installationsprogramm kann sich uneinheitlich verhalten. Ab- und erneutes Anmelden kann nötig sein, bevor die Belegung erscheint oder funktioniert.**

Startet setup.exe nicht, öffne `_amd64.msi` für 64-Bit-Windows oder `_i386.msi` für 32 Bit. Die Installationsprogramme sind nicht signiert; Windows kann einen unbekannten Herausgeber anzeigen. Beim direkten Öffnen des MSI ist das Kästchen für die Standardtastatur nicht verfügbar.

Neue Installationen machen die Tastatur für den ganzen Computer verfügbar; die Standardeinstellung gilt nur für dein Konto. Das Entfernen kann andere Konten betreffen. Gehört eine ältere Installation zu einem anderen Konto, entferne sie dort vor der Neuinstallation; das neue Installationsprogramm migriert sie beim Öffnen nicht.

SmartScreen: Die Warnung „Der Computer wurde durch Windows geschützt“ mit „Unbekannter Herausgeber“ wurde beim Start von setup.exe aus GitHub-Downloads sowohl bei v0.1.0 als auch bei v0.2.0 beobachtet. Die Installationsprogramme sind weiterhin unsigniert. Wenn du die Herkunft der Datei geprüft hast und fortfahren möchtest, wähle „Weitere Informationen“ und dann „Trotzdem ausführen“, sofern Windows diese Option anbietet. SmartScreen oder Microsoft Defender müssen nicht deaktiviert werden.

## Zeichenänderungen

In Spanien, Italien, Portugal, Norwegen und Dänemark ersetzt AltGr+5 das Eurozeichen; **€ bleibt auf AltGr+E**. Bei belgischem Französisch bleibt **[ mit AltGr und der Taste ^ neben P** erreichbar.

Bei den Schweizer Varianten wandert **§ auf AltGr+8** und **der senkrechte Strich auf AltGr+1**. Dadurch werden ¢ und ¦ ersetzt; sie haben derzeit keine neue Tastenkombination. Lies vorher die lokale Anleitung.

Andere geprüfte Kombinationen und Akzente bleiben erhalten. Ctrl+Alt kann dieselben Zeichen wie AltGr erzeugen.

## Zurückwechseln oder deinstallieren

Um die Belegung nicht mehr als Standard zu verwenden, öffne **setup.exe** erneut, entferne das Häkchen und klicke auf **„Übernehmen“**. Die vorherige Einstellung wird wiederhergestellt; die Tastatur bleibt installiert. Ist die vorherige Tastatur nicht mehr verfügbar, wähle eine andere. Zum Entfernen klicke im selben Fenster auf **„Deinstallieren“**; bei Bedarf wird vorher der Standard wiederhergestellt. Win+Leertaste wechselt die ausgewählte Tastatur, hebt diese Einstellung aber nicht auf. Die direkte Entfernung über Windows-Apps oder MSI führt diese Wiederherstellung nicht aus.

## Tippübungen

Ich habe [Übungstexte](practice/README.md) in den Projektsprachen beigefügt. Die Kategorien beziehen sich auf **jeden Absatz**, nicht die Datei oder Geschichte: ungefähr 10–25 Wörter bei short, 25–50 bei medium und 80–120 bei long. Leerzeilen trennen Absätze; die Geschichte darf weitergehen. Füge einen oder mehrere Absätze im Modus **custom** von Monkeytype ein. Jede einzelne ZIP-Datei enthält `practice/short.txt`, `practice/medium.txt`, `practice/long.txt` und eine gemeinsame `practice.txt`.

**Diese erfundenen Texte wurden mit KI zum Üben erstellt und können Fehler enthalten.** Sie sind keine sprachlichen oder normativen Nachschlagewerke. Im Englischen werden Guillemets bewusst zu Testzwecken verwendet.

## Tests und Rückmeldungen

Ich habe fünf ursprüngliche Varianten auf meinem Laptop ausprobiert. Sie funktionieren, teilweise nach erneutem Anmelden. Ich habe nicht alle 17 manuell getestet, einschließlich der zwei experimentellen englischen Varianten. Automatische Prüfungen decken Zeichentabellen, Akzente und Namen unter x86, x64 und WOW64 ab.

Ich betreue dieses Projekt. Melde Probleme als Issue mit Windows-Version, Belegung, Tastenkombination, Ergebnis und der Information, ob erneutes Anmelden geholfen hat.

v0.2.1: Ich habe Spanish (Spain) in einem neu angelegten Konto erfolgreich getestet: Installation, Standard aktivieren/deaktivieren, Beibehaltung nach Abmelden oder Neustart und Deinstallation. Zuerst habe ich die ältere Benutzerinstallation entfernt. Die anderen 16 Belegungen und alle Windows-Konfigurationen habe ich nicht manuell getestet; die Übersetzungen wurden nicht unabhängig sprachlich geprüft. Der abschließende Build ergänzt die getestete Logik um die sichtbare Version.

Erstellt mit [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=102134). Mein ursprünglicher Code und meine Änderungen stehen unter der [MIT-Lizenz](LICENSE). Für Microsoft-Komponenten gelten weiterhin deren Bedingungen; siehe [Hinweise zu Drittanbietern](THIRD_PARTY_NOTICES.md).

Für die Entwicklung (Dokumentation auf Englisch): [kompilieren und prüfen](docs/BUILD.md) / [Rückmeldungen und Beiträge](CONTRIBUTING.md).
