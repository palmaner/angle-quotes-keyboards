# v0.2.1 — Pålidelig afinstallation mellem Windows-konti

[Español](RELEASE_NOTES_v0.2.1.es.md) · [English](RELEASE_NOTES_v0.2.1.md) · [Français](RELEASE_NOTES_v0.2.1.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.1.de.md) · [Italiano](RELEASE_NOTES_v0.2.1.it.md) · [Português](RELEASE_NOTES_v0.2.1.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.1.nb.md) · [Dansk](RELEASE_NOTES_v0.2.1.da.md) · [Русский](RELEASE_NOTES_v0.2.1.ru.md) · [Українська](RELEASE_NOTES_v0.2.1.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.1.be.md)

## Nyt installationsprogram

- Retter fejl **1605**, der skyldes forveksling af et systemregistreret tastatur med en MSI-installation for den aktuelle konto.
- Afinstallationen vælger det registrerede produkt efter kontrol af cachelagret MSI, navn og DLL i stedet for at antage identiteten fra den hentede pakke.
- Eksisterende installationer pr. bruger fjernes fra ejerkontoen. Installationer for computeren beder om administratorgodkendelse.
- Nye installationer registreres for hele computeren; standardtastaturet er fortsat en selvstændig indstilling pr. konto.
- Manglende, tvetydige eller ikke verificerbare produkter meldes, før standardindstillingen gendannes. Tastaturfiler og registreringsdatabaseposter slettes ikke manuelt.
- Vindue og dialoger viser **v0.2.1**. Filegenskaberne viser samme version. Fjernelse af et systemtastatur kan påvirke andre konti.

## Pålidelighed og dokumentation

- Nye MSI-installationer bruger udtrykkeligt `ALLUSERS=1`. Fjernelse pr. bruger genstarter ikke handlingen som en anden administrator.
- Detaljerede `/L*V`-logfiler og produkt-/kontekstdiagnoser gemmes lokalt under `%LOCALAPPDATA%\AngleQuotes\logs`. De uploades ikke automatisk og kan indeholde konto-ID’er og stier.
- Successtatus `0` kontrolleres mod MSI-oversigten før bekræftelse. Genstartskoden `3010` bevares. Versionen har én fælles kilde.

## Kompatibilitet og advarsler

Tastatur-DLL'er, MSI-pakker, tegntildelinger og øvelsestekster er uændrede fra v0.2.0. Windows 10/11 på x86/x64 understøttes fortsat; ARM64 er ikke inkluderet. Windows kan kræve aflogning eller genstart, før tastaturet vises eller fungerer korrekt.

SmartScreen: Advarslen »Windows beskyttede din pc« med »Ukendt udgiver« er observeret ved kørsel af setup.exe hentet fra GitHub i både v0.1.0 og v0.2.0. Installationsprogrammerne er stadig usignerede. Hvis du har kontrolleret filens oprindelse og vil fortsætte, vælger du »Flere oplysninger« og derefter »Kør alligevel«, hvis Windows tilbyder dette. Du behøver ikke deaktivere SmartScreen eller Microsoft Defender.

## Validering

- 26 isolerede MSI-identitets-/kontekstkontroller og de eksisterende 35 indstillingskontroller består i 32- og 64-bit Windows PowerShell 5.1. Windows-indstillinger og MSI-handlinger simuleres.
- 238 kontroller af metadata, arkitekturer, viste navne, integrerede ressourcer og versioner dækker alle 17 layouts. DLL’er og MSI-pakker er uændrede.
- Hashene for de 18 ZIP-filer, mappeindhold, dokumentationskopier, lokale links og tegnkodning kontrolleres. Skrivebeskyttede kontroller tester den faktiske MSI-registrering og opstart.
- Jeg har testet Spanish (Spain) i en ny konto med godt resultat: installation, aktivering/deaktivering af standard, bevarelse efter aflogning eller genstart og afinstallation. Jeg fjernede den gamle brugerinstallation først. Jeg har ikke testet de øvrige 16 layouts eller alle Windows-konfigurationer manuelt; oversættelserne har ikke fået uafhængig sproglig gennemgang. Det endelige build tilføjer synlig version til den testede logik.

Hvis en ældre installation tilhører en anden konto, fjern den først fra den oprindelige konto, og installer denne version fra den ønskede konto. En ny konto eller åbning af det nye installationsprogram migrerer ikke en eksisterende MSI-brugerregistrering. Jeg gennemførte denne overgang og gentog derefter hele testen i en ny konto med godt resultat.

## Downloads

Vælg `ANGLE_QUOTES_NATIVE_WINDOWS.zip` til alle layouts eller den enkelte ZIP-fil til dit layout. Pak hele ZIP-filen ud, og behold filerne samlet. `SHA256SUMS.txt` indeholder SHA256-hashene for de 18 ZIP-filer, der kan downloades.

GitHubs **Source code**-downloads i ZIP/TAR.GZ-format genereres separat og er ikke installationspakkerne.
