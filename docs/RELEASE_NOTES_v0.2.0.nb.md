# v0.2.0 — Valg av standardtastatur

[Español](RELEASE_NOTES_v0.2.0.es.md) · [English](RELEASE_NOTES_v0.2.0.md) · [Français](RELEASE_NOTES_v0.2.0.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.0.de.md) · [Italiano](RELEASE_NOTES_v0.2.0.it.md) · [Português](RELEASE_NOTES_v0.2.0.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.0.nb.md) · [Dansk](RELEASE_NOTES_v0.2.0.da.md) · [Русский](RELEASE_NOTES_v0.2.0.ru.md) · [Українська](RELEASE_NOTES_v0.2.0.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.0.be.md)

## Nytt installasjonsprogram

- Alle 17 oppsett har nå et installasjonsvindu med den valgfrie avmerkingen **Bruk som standardtastatur for kontoen min**. Merk av og installer eller bruk endringen for å lagre standard inndatametode i Windows.
- Åpne `setup.exe` igjen, fjern avmerkingen og klikk **Bruk** for å gjenopprette forrige innstilling mens tastaturet forblir installert. Hvis det forrige tastaturet ikke er tilgjengelig, ber programmet deg velge en annen tilgjengelig inndatametode.
- Avmerkingen viser gjeldende Windows-innstilling. Andre språk og tastaturer beholdes; gjentatt aktivering overskriver ikke den opprinnelige gjenopprettingsoppføringen med samme oppsett.
- **Avinstaller** gjenoppretter først forrige standard ved behov og fjerner deretter oppsettet. Direkte fjerning via MSI eller Windows-apper hopper over dette ekstra gjenopprettingstrinnet.
- Grensesnittet følger Windows-språket: spansk, engelsk, fransk, tysk, italiensk, portugisisk, norsk bokmål, dansk, russisk, ukrainsk og belarusisk, med engelsk som reserve.
- Åpne `setup.exe` normalt, uten **Kjør som administrator**. Bare MSI-operasjoner ber om administratorrettigheter; innstillingene gjelder kontoen som åpnet programmet. Ingen bakgrunnsapp eller planlagt oppgave installeres.

## Pålitelighet og dokumentasjon

- Programmet unngår unødvendige innstillingsspørringer ved oppstart. Hvis Windows-spørringen om standard inndatametode kaster et generelt unntak, leses den lagrede innstillingen med skrivebeskyttet tilgang. Tilgangsfeil og ugyldige verdier forblir feil.
- Konfigurasjonsfeil viser kommandoen og plasseringen i skriptet og lagrer en lokal diagnosefil under `%LOCALAPPDATA%\AngleQuotes\logs`. Logger lastes ikke opp automatisk.
- Installasjons-, gjenopprettings- og fjerningsinstruksjoner er oppdatert i alle 11 README-språk og mappene til de 17 oppsettene. Byggekilder, oversettelser og isolerte innstillingstester er inkludert.

## Kompatibilitet og advarsler

Tastatur-DLL-er, MSI-pakker, tegntilordninger og øvingstekster er uendret fra v0.1.0. Windows 10/11 på x86/x64 støttes fortsatt; ARM64 er ikke inkludert. Windows kan kreve avlogging eller omstart før tastaturet vises eller fungerer riktig.

SmartScreen: Advarselen «Windows beskyttet PC-en» med «Ukjent utgiver» er observert ved kjøring av setup.exe lastet ned fra GitHub i både v0.1.0 og v0.2.0. Installasjonsprogrammene er fortsatt usignerte. Hvis du har kontrollert filens opprinnelse og vil fortsette, velger du «Mer informasjon» og deretter «Kjør likevel», hvis Windows tilbyr dette. Du trenger ikke deaktivere SmartScreen eller Microsoft Defender.

## Validering

- 35 isolerte innstillingskontroller består i både 32- og 64-biters Windows PowerShell 5.1, med simulerte Windows-innstillinger og registeroppføringer.
- 204 kontroller av installasjonsmetadata, arkitekturer, visningsnavn og innebygde ressurser består. Tegntabellrapportene dekker alle 17 oppsett, med 11 016 tegnsammenligninger for hver av arkitekturene x86, x64 og WOW64, samt kontroller av dødtaster.
- Pakkegranskingen kontrollerer hashene til de 18 ZIP-filene, innholdet i de enkelte mappene, README-kopier, lokale lenker og tegnkoding. Den faktiske oppstarten er også kontrollert med skrivebeskyttet tilgang i 32- og 64-biters PowerShell.
- Brukeren rapporterer en samlet vellykket manuell test av den korrigerte **Spanish (Spain) - Angle Quotes**-kandidaten på Windows Home x64, oppgitt versjon 26H2, bygg 26300.9818. Enkelttilfellene ble ikke registrert separat. Dette dokumenterer ikke manuell dekning av de andre 16 oppsettene eller alle støttede Windows-versjoner. De nye oversettelsene er ikke gjennomgått av en uavhengig språkkyndig.

Ytterligere kompatibilitetstest rapportert av brukeren: Med et v0.1.0-oppsett installert gjenkjente v0.2.0-programmet den eksisterende installasjonen og kunne angi den som standardtastatur. Dette bekrefter dette tilfellet på den testede maskinen, uten å dokumentere en full avinstallasjon og nyinstallasjon eller dekning av alle oppsett.

## Nedlastinger

Velg `ANGLE_QUOTES_NATIVE_WINDOWS.zip` for alle oppsett, eller den enkelte ZIP-filen for ditt oppsett. Pakk ut hele ZIP-filen og behold filene samlet. `SHA256SUMS.txt` inneholder SHA256-hashene til de 18 nedlastbare ZIP-filene.

GitHubs **Source code**-nedlastinger i ZIP/TAR.GZ-format genereres separat og er ikke installasjonspakkene.
