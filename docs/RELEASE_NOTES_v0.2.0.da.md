# v0.2.0 — Valg af standardtastatur

[Español](RELEASE_NOTES_v0.2.0.es.md) · [English](RELEASE_NOTES_v0.2.0.md) · [Français](RELEASE_NOTES_v0.2.0.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.0.de.md) · [Italiano](RELEASE_NOTES_v0.2.0.it.md) · [Português](RELEASE_NOTES_v0.2.0.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.0.nb.md) · [Dansk](RELEASE_NOTES_v0.2.0.da.md) · [Русский](RELEASE_NOTES_v0.2.0.ru.md) · [Українська](RELEASE_NOTES_v0.2.0.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.0.be.md)

## Nyt installationsprogram

- Alle 17 layouts har nu et installationsvindue med det valgfrie felt **Brug som standardtastatur for min konto**. Markér det, og installer eller anvend ændringen for at gemme Windows' standardinputmetode.
- Åbn `setup.exe` igen, fjern markeringen, og klik på **Anvend** for at gendanne den tidligere indstilling, mens tastaturet forbliver installeret. Hvis det tidligere tastatur ikke er tilgængeligt, beder programmet dig vælge en anden tilgængelig inputmetode.
- Feltet afspejler den aktuelle Windows-indstilling. Andre sprog og tastaturer bevares; gentagen aktivering overskriver ikke den oprindelige gendannelsesoplysning med samme layout.
- **Afinstaller** gendanner først den tidligere standard efter behov og fjerner derefter layoutet. Direkte fjernelse via MSI eller Windows-apps springer dette ekstra gendannelsestrin over.
- Grænsefladen følger Windows-sproget: spansk, engelsk, fransk, tysk, italiensk, portugisisk, norsk bokmål, dansk, russisk, ukrainsk og belarusisk, med engelsk som reserve.
- Åbn `setup.exe` normalt uden **Kør som administrator**. Kun MSI-handlinger beder om administratorrettigheder; indstillingerne gælder den konto, der åbnede programmet. Der installeres ingen baggrundsapp eller planlagt opgave.

## Pålidelighed og dokumentation

- Programmet undgår unødvendige forespørgsler om indstillinger ved opstart. Hvis Windows-forespørgslen om standardinput giver en generel undtagelse, læses den gemte indstilling med skrivebeskyttet adgang. Adgangsfejl og ugyldige værdier er fortsat fejl.
- Konfigurationsfejl viser kommandoen og placeringen i scriptet og gemmer en lokal diagnosefil under `%LOCALAPPDATA%\AngleQuotes\logs`. Logfiler uploades ikke automatisk.
- Vejledninger til installation, gendannelse og fjernelse er opdateret på alle 11 README-sprog og i mapperne til de 17 layouts. Kildekode til bygning, oversættelser og isolerede indstillingstests er inkluderet.

## Kompatibilitet og advarsler

Tastatur-DLL'er, MSI-pakker, tegntildelinger og øvelsestekster er uændrede fra v0.1.0. Windows 10/11 på x86/x64 understøttes fortsat; ARM64 er ikke inkluderet. Windows kan kræve aflogning eller genstart, før tastaturet vises eller fungerer korrekt.

SmartScreen: Advarslen »Windows beskyttede din pc« med »Ukendt udgiver« er observeret ved kørsel af setup.exe hentet fra GitHub i både v0.1.0 og v0.2.0. Installationsprogrammerne er stadig usignerede. Hvis du har kontrolleret filens oprindelse og vil fortsætte, vælger du »Flere oplysninger« og derefter »Kør alligevel«, hvis Windows tilbyder dette. Du behøver ikke deaktivere SmartScreen eller Microsoft Defender.

## Validering

- 35 isolerede indstillingskontroller består i både 32- og 64-bit Windows PowerShell 5.1 med simulerede Windows-indstillinger og registreringsdatabaseposter.
- 204 kontroller af installationsmetadata, arkitekturer, viste navne og integrerede ressourcer består. Tegntabelrapporterne dækker alle 17 layouts med 11 016 tegnsammenligninger for hver arkitektur x86, x64 og WOW64 samt kontrol af døde taster.
- Pakkekontrollerne verificerer hashene for de 18 ZIP-filer, indholdet af de enkelte mapper, README-kopier, lokale links og tegnkodning. Den faktiske opstart er også kontrolleret med skrivebeskyttet adgang i 32- og 64-bit PowerShell.
- Jeg har testet den rettede kandidat **Spanish (Spain) - Angle Quotes** på Windows Home x64, version 26H2, build 26300.9818, med godt resultat. De enkelte tilfælde blev ikke registreret separat. Dette dokumenterer ikke manuel dækning af de øvrige 16 layouts eller alle understøttede Windows-versioner. De nye oversættelser har ikke fået uafhængig sproglig gennemgang.

Jeg har også kontrolleret kompatibiliteten: Med et v0.1.0-layout installeret genkendte v0.2.0-programmet den eksisterende installation og kunne angive det som standardtastatur. Det bekræfter dette tilfælde på den testede maskine uden at dokumentere en fuld afinstallation og geninstallation eller dækning af alle layouts.

## Downloads

Vælg `ANGLE_QUOTES_NATIVE_WINDOWS.zip` til alle layouts eller den enkelte ZIP-fil til dit layout. Pak hele ZIP-filen ud, og behold filerne samlet. `SHA256SUMS.txt` indeholder SHA256-hashene for de 18 ZIP-filer, der kan downloades.

GitHubs **Source code**-downloads i ZIP/TAR.GZ-format genereres separat og er ikke installationspakkerne.
