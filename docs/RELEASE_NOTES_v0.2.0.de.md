# v0.2.0 — Auswahl der Standardtastatur

[Español](RELEASE_NOTES_v0.2.0.es.md) · [English](RELEASE_NOTES_v0.2.0.md) · [Français](RELEASE_NOTES_v0.2.0.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.0.de.md) · [Italiano](RELEASE_NOTES_v0.2.0.it.md) · [Português](RELEASE_NOTES_v0.2.0.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.0.nb.md) · [Dansk](RELEASE_NOTES_v0.2.0.da.md) · [Русский](RELEASE_NOTES_v0.2.0.ru.md) · [Українська](RELEASE_NOTES_v0.2.0.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.0.be.md)

## Neues Installationsprogramm

- Alle 17 Belegungen enthalten jetzt ein Installationsfenster mit dem optionalen Kästchen **Als Standardtastatur für mein Konto verwenden**. Aktiviere es und installiere oder übernimm die Änderung, um die Windows-Standardeingabe zu speichern.
- Öffne `setup.exe` erneut, entferne das Häkchen und klicke auf **Übernehmen**, um die vorherige Einstellung wiederherzustellen und die Tastatur installiert zu lassen. Ist die vorherige Tastatur nicht mehr verfügbar, musst du eine andere verfügbare Eingabemethode auswählen.
- Das Kästchen zeigt die aktuelle Windows-Einstellung. Andere Sprachen und Tastaturen bleiben erhalten; wiederholtes Aktivieren überschreibt die ursprüngliche Wiederherstellungseinstellung nicht mit derselben Belegung.
- **Deinstallieren** stellt bei Bedarf zuerst den vorherigen Standard wieder her und entfernt dann die Belegung. Die direkte Entfernung über MSI oder Windows-Apps umgeht diesen zusätzlichen Wiederherstellungsschritt.
- Die Oberfläche folgt der Windows-Sprache: Spanisch, Englisch, Französisch, Deutsch, Italienisch, Portugiesisch, Norwegisch Bokmål, Dänisch, Russisch, Ukrainisch und Belarussisch. Falls erforderlich wird Englisch verwendet.
- Öffne `setup.exe` normal, ohne **Als Administrator ausführen**. Nur MSI-Vorgänge fordern erhöhte Rechte an; Eingabeeinstellungen gelten für das Konto, das das Installationsprogramm geöffnet hat. Es werden keine Hintergrundanwendung und keine geplante Aufgabe installiert.

## Zuverlässigkeit und Dokumentation

- Das Installationsprogramm vermeidet unnötige Einstellungsabfragen beim Start. Löst die Windows-Abfrage der Standardeingabe eine allgemeine Ausnahme aus, wird die gespeicherte Einstellung nur lesend abgefragt. Zugriffsfehler und ungültige Werte bleiben Fehler.
- Konfigurationsfehler zeigen den Befehl und die Skriptposition und speichern eine lokale Diagnosedatei unter `%LOCALAPPDATA%\AngleQuotes\logs`. Protokolle werden nicht automatisch hochgeladen.
- Installations-, Wiederherstellungs- und Deinstallationsanleitungen wurden in allen 11 README-Sprachen und den Ordnern aller 17 Belegungen aktualisiert. Build-Quellen, Übersetzungen und isolierte Einstellungstests sind enthalten.

## Kompatibilität und Hinweise

Tastatur-DLLs, MSI-Pakete, Zeichenzuweisungen und Übungstexte bleiben gegenüber v0.1.0 unverändert. Unterstützt wird weiterhin Windows 10/11 auf x86/x64; ARM64 ist nicht enthalten. Windows kann Abmelden oder einen Neustart erfordern, bevor eine Tastatur erscheint oder richtig funktioniert.

Die Installationsprogramme bleiben unsigniert. Die SmartScreen-Warnung **Der Computer wurde durch Windows geschützt** wurde bei v0.1.0 beobachtet, nicht beim erfolgreichen Test des v0.2.0-Kandidaten gemeldet. Ein unsigniertes v0.2.0-Installationsprogramm kann weiterhin eine Warnung auslösen. Diese Version entfernt oder deaktiviert den SmartScreen-Schutz nicht.

## Validierung

- 35 isolierte Einstellungsprüfungen bestehen in Windows PowerShell 5.1 mit 32 und 64 Bit, mit simulierten Windows-Einstellungen und Registrierungseinträgen.
- 204 Prüfungen von Installationsmetadaten, Architekturen, Anzeigenamen und eingebetteten Ressourcen bestehen. Die Zeichentabellenberichte decken alle 17 Belegungen ab, mit 11 016 Zeichenvergleichen je Architektur x86, x64 und WOW64 sowie Prüfungen toter Tasten.
- Paketprüfungen kontrollieren die Hashes der 18 ZIP-Dateien, die einzelnen Ordnerinhalte, README-Kopien, lokalen Links und die Kodierung. Der echte Startpfad wurde auch unter 32- und 64-Bit-PowerShell nur lesend geprüft.
- Der Nutzer berichtet einen insgesamt erfolgreichen manuellen Test des korrigierten Kandidaten **Spanish (Spain) - Angle Quotes** unter Windows Home x64, gemeldete Version 26H2, Build 26300.9818. Einzelne Fälle wurden nicht gesondert protokolliert. Das belegt keine manuelle Abdeckung der anderen 16 Belegungen oder aller unterstützten Windows-Versionen. Die neuen Übersetzungen wurden nicht unabhängig sprachlich geprüft.

Zusätzlicher vom Nutzer gemeldeter Kompatibilitätstest: Bei bereits installierter v0.1.0-Belegung erkannte das v0.2.0-Installationsprogramm die vorhandene Installation und konnte sie als Standardtastatur festlegen. Dies bestätigt diesen Fall auf dem getesteten Rechner, ohne eine vollständige Deinstallation und Neuinstallation oder die Abdeckung aller Belegungen zu belegen.

## Downloads

Wähle `ANGLE_QUOTES_NATIVE_WINDOWS.zip` für alle Belegungen oder die einzelne ZIP-Datei deiner Belegung. Entpacke das gesamte ZIP und lasse die Dateien zusammen. `SHA256SUMS.txt` enthält SHA256-Hashes für die 18 herunterladbaren ZIP-Dateien.

Die **Source code**-Downloads ZIP/TAR.GZ von GitHub werden separat erzeugt und sind nicht die gepackten Installationsdownloads.
