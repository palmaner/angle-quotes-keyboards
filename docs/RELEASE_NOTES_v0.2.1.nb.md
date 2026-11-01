# v0.2.1 — Pålitelig avinstallering mellom Windows-kontoer

[Español](RELEASE_NOTES_v0.2.1.es.md) · [English](RELEASE_NOTES_v0.2.1.md) · [Français](RELEASE_NOTES_v0.2.1.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.1.de.md) · [Italiano](RELEASE_NOTES_v0.2.1.it.md) · [Português](RELEASE_NOTES_v0.2.1.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.1.nb.md) · [Dansk](RELEASE_NOTES_v0.2.1.da.md) · [Русский](RELEASE_NOTES_v0.2.1.ru.md) · [Українська](RELEASE_NOTES_v0.2.1.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.1.be.md)

## Nytt installasjonsprogram

- Retter feil **1605** som skyldes at en systemregistrert tastaturbelegging forveksles med en MSI-installasjon for gjeldende konto.
- Avinstalleringen velger det registrerte produktet etter kontroll av bufret MSI, navn og DLL, fremfor å anta identiteten fra den nedlastede pakken.
- Eksisterende installasjoner per bruker fjernes fra eierkontoen. Maskininstallasjoner ber om administratorgodkjenning.
- Nye installasjoner registreres for hele datamaskinen; standardtastaturet er fortsatt en egen innstilling per konto.
- Manglende, tvetydige eller ikke verifiserbare produkter meldes før standardinnstillingen gjenopprettes. Tastaturfiler og registeroppføringer slettes ikke manuelt.
- Vindu og dialoger viser **v0.2.1**. Filegenskapene viser samme versjon. Fjerning av et systemtastatur kan påvirke andre kontoer.

## Pålitelighet og dokumentasjon

- Nye MSI-installasjoner bruker uttrykkelig `ALLUSERS=1`. Fjerning per bruker starter ikke operasjonen på nytt som en annen administrator.
- Detaljerte `/L*V`-logger og produkt-/kontekstdiagnoser lagres lokalt under `%LOCALAPPDATA%\AngleQuotes\logs`. De lastes ikke opp automatisk og kan inneholde konto-ID-er og stier.
- Suksesskoden `0` kontrolleres mot MSI-oversikten før fullføring bekreftes. Omstartskoden `3010` beholdes. Versjonen kommer fra én felles kilde.

## Kompatibilitet og advarsler

Tastatur-DLL-er, MSI-pakker, tegntilordninger og øvingstekster er uendret fra v0.2.0. Windows 10/11 på x86/x64 støttes fortsatt; ARM64 er ikke inkludert. Windows kan kreve avlogging eller omstart før tastaturet vises eller fungerer riktig.

SmartScreen: Advarselen «Windows beskyttet PC-en» med «Ukjent utgiver» er observert ved kjøring av setup.exe lastet ned fra GitHub i både v0.1.0 og v0.2.0. Installasjonsprogrammene er fortsatt usignerte. Hvis du har kontrollert filens opprinnelse og vil fortsette, velger du «Mer informasjon» og deretter «Kjør likevel», hvis Windows tilbyr dette. Du trenger ikke deaktivere SmartScreen eller Microsoft Defender.

## Validering

- 26 isolerte MSI-identitets-/kontekstkontroller og de eksisterende 35 innstillingskontrollene består i 32- og 64-biters Windows PowerShell 5.1. Windows-innstillinger og MSI-operasjoner simuleres.
- 238 kontroller av metadata, arkitekturer, visningsnavn, innebygde ressurser og versjoner dekker alle 17 oppsett. DLL-er og MSI-pakker er uendret.
- Hashene til de 18 ZIP-filene, mappeinnhold, dokumentasjonskopier, lokale lenker og tegnkoding granskes. Skrivebeskyttede kontroller tester ekte MSI-oppdagelse og oppstart.
- Jeg har testet Spanish (Spain) i en ny konto med godt resultat: installasjon, aktivering/deaktivering av standard, bevaring etter avlogging eller omstart og avinstallering. Jeg fjernet den gamle brukerinstallasjonen først. Jeg har ikke testet de andre 16 oppsettene eller alle Windows-konfigurasjoner manuelt; oversettelsene har ikke fått uavhengig språklig gjennomgang. Siste bygg legger synlig versjon til den testede logikken.

Hvis en eldre installasjon tilhører en annen konto, fjern den først fra opprinnelig konto og installer denne versjonen fra ønsket konto. En ny konto eller åpning av det nye installasjonsprogrammet flytter ikke en eksisterende MSI-brukerregistrering. Jeg fullførte denne overgangen og gjentok deretter hele testen i en ny konto med godt resultat.

## Nedlastinger

Velg `ANGLE_QUOTES_NATIVE_WINDOWS.zip` for alle oppsett, eller den enkelte ZIP-filen for ditt oppsett. Pakk ut hele ZIP-filen og behold filene samlet. `SHA256SUMS.txt` inneholder SHA256-hashene til de 18 nedlastbare ZIP-filene.

GitHubs **Source code**-nedlastinger i ZIP/TAR.GZ-format genereres separat og er ikke installasjonspakkene.
