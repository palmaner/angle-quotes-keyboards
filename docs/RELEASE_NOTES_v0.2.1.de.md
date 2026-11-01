# v0.2.1 — Zuverlässige Deinstallation zwischen Windows-Konten

[Español](RELEASE_NOTES_v0.2.1.es.md) · [English](RELEASE_NOTES_v0.2.1.md) · [Français](RELEASE_NOTES_v0.2.1.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.1.de.md) · [Italiano](RELEASE_NOTES_v0.2.1.it.md) · [Português](RELEASE_NOTES_v0.2.1.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.1.nb.md) · [Dansk](RELEASE_NOTES_v0.2.1.da.md) · [Русский](RELEASE_NOTES_v0.2.1.ru.md) · [Українська](RELEASE_NOTES_v0.2.1.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.1.be.md)

## Neues Installationsprogramm

- Behebt Fehler **1605**, der entsteht, wenn eine systemweite Tastaturregistrierung mit einer MSI-Installation des aktuellen Kontos verwechselt wird.
- Die Deinstallation wählt das tatsächlich registrierte Produkt nach Prüfung von MSI-Cache, Namen und Tastatur-DLL, statt die Identität aus dem heruntergeladenen Paket anzunehmen.
- Bestehende Installationen pro Benutzer werden aus ihrem Eigentümerkonto entfernt. Installationen für den Computer fordern Administratorfreigabe an.
- Neue Installationen werden für den gesamten Computer registriert; die Standardtastatur bleibt eine Einstellung pro Konto.
- Fehlende, mehrdeutige oder nicht überprüfbare Produkte werden vor der Wiederherstellung einer Standardeinstellung gemeldet. Tastaturdateien und Registrierungseinträge werden nicht manuell gelöscht.
- Fenster und Dialoge zeigen jetzt **v0.2.1**. Die Dateieigenschaften zeigen dieselbe Version. Das Entfernen einer Systemtastatur kann andere Konten betreffen.

## Zuverlässigkeit und Dokumentation

- Neue MSI-Installationen verwenden ausdrücklich `ALLUSERS=1`. Deinstallationen pro Benutzer werden nicht als anderer Administrator neu gestartet.
- Ausführliche `/L*V`-Protokolle und Produkt-/Kontextdiagnosen werden lokal unter `%LOCALAPPDATA%\AngleQuotes\logs` gespeichert. Sie werden nicht automatisch hochgeladen und können Konto-IDs und Pfade enthalten.
- Der Erfolgscode `0` wird vor der Erfolgsmeldung mit dem MSI-Inventar abgeglichen. Der Neustartcode `3010` bleibt erhalten. Versionsdaten stammen aus einer gemeinsamen Quelle.

## Kompatibilität und Hinweise

Tastatur-DLLs, MSI-Pakete, Zeichenzuweisungen und Übungstexte bleiben gegenüber v0.2.0 unverändert. Unterstützt wird weiterhin Windows 10/11 auf x86/x64; ARM64 ist nicht enthalten. Windows kann Abmelden oder einen Neustart erfordern, bevor eine Tastatur erscheint oder richtig funktioniert.

SmartScreen: Die Warnung „Der Computer wurde durch Windows geschützt“ mit „Unbekannter Herausgeber“ wurde beim Start von setup.exe aus GitHub-Downloads sowohl bei v0.1.0 als auch bei v0.2.0 beobachtet. Die Installationsprogramme sind weiterhin unsigniert. Wenn du die Herkunft der Datei geprüft hast und fortfahren möchtest, wähle „Weitere Informationen“ und dann „Trotzdem ausführen“, sofern Windows diese Option anbietet. SmartScreen oder Microsoft Defender müssen nicht deaktiviert werden.

## Validierung

- 26 isolierte MSI-Identitäts-/Kontextprüfungen und die vorhandenen 35 Einstellungsprüfungen bestehen in Windows PowerShell 5.1 mit 32 und 64 Bit. Windows-Einstellungen und MSI-Vorgänge sind simuliert.
- 238 Prüfungen von Metadaten, Architekturen, Anzeigenamen, eingebetteten Ressourcen und Versionen decken alle 17 Belegungen ab. Tastatur-DLLs und MSI-Pakete bleiben unverändert.
- Hashes der 18 ZIP-Dateien, Ordnerinhalte, Dokumentationskopien, lokale Links und Kodierung werden geprüft. Nur lesende Prüfungen testen die native MSI-Erkennung und den echten Startpfad.
- Ich habe Spanish (Spain) in einem neu angelegten Konto erfolgreich getestet: Installation, Standard aktivieren/deaktivieren, Beibehaltung nach Abmelden oder Neustart und Deinstallation. Zuerst habe ich die ältere Benutzerinstallation entfernt. Die anderen 16 Belegungen und alle Windows-Konfigurationen habe ich nicht manuell getestet; die Übersetzungen wurden nicht unabhängig sprachlich geprüft. Der abschließende Build ergänzt die getestete Logik um die sichtbare Version.

Gehört eine ältere Installation zu einem anderen Konto, entferne sie zuerst aus diesem Ursprungskonto und installiere diese Version dann aus dem gewünschten Konto. Ein neues Konto oder das Öffnen des neuen Installationsprogramms migriert keine bestehende MSI-Benutzerregistrierung. Ich habe diese Migration erfolgreich abgeschlossen und anschließend den vollständigen Test in einem neuen Konto wiederholt.

## Downloads

Wähle `ANGLE_QUOTES_NATIVE_WINDOWS.zip` für alle Belegungen oder die einzelne ZIP-Datei deiner Belegung. Entpacke das gesamte ZIP und lasse die Dateien zusammen. `SHA256SUMS.txt` enthält SHA256-Hashes für die 18 herunterladbaren ZIP-Dateien.

Die **Source code**-Downloads ZIP/TAR.GZ von GitHub werden separat erzeugt und sind nicht die gepackten Installationsdownloads.
