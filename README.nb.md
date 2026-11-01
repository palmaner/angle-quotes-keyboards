# Vinkelanførselstegn for Windows

[Español](README.es.md) · [English](README.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Português](README.pt.md) · [Norsk bokmål](README.nb.md) · [Dansk](README.da.md) · [Русский](README.ru.md) · [Українська](README.uk.md) · [Беларуская](README.be.md)

Jeg har laget disse 17 innebygde tastaturoppsettene for å skrive vinkelanførselstegn med AltGr, samtidig som det opprinnelige tastaturet beholdes. AutoHotkey og bakgrunnsprogrammer er ikke nødvendige.

Samlingen har **15 opprinnelige varianter og to eksperimentelle engelske varianter: USA og Storbritannia**.

**[Last ned tastaturer](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · [Meld fra om et problem](https://github.com/palmaner/angle-quotes-keyboards/issues)

## Velg oppsett

Velg etter tastaturet du bruker, ikke bare nasjonaliteten din. Lenkene går til lokale instruksjoner med alle endrede plasseringer.

| Oppsett og instruksjoner | Åpning | Lukking |
| --- | --- | --- |
| [Spansk (Spania)](Spanish-Spain/README.txt), [Spansk (Latin-Amerika)](Spanish-Latin-America/README.txt), [Italiensk](Italian/README.txt), [Russisk](Russian/README.txt), [Ukrainsk](Ukrainian/README.txt), [Belarusisk](Belarusian/README.txt), [Belgisk fransk](Belgian-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| [Portugisisk (Portugal)](Portuguese-Portugal/README.txt), [Norsk](Norwegian/README.txt) | AltGr+5 → « | AltGr+6 → » |
| [Tysk (Tyskland)](German-Germany/README.txt), [Tysk (Østerrike)](German-Austria/README.txt), [Dansk](Danish/README.txt) | AltGr+5 → » | AltGr+6 → « |
| [Sveitsisk fransk](Swiss-French/README.txt), [Sveitsisk tysk](Swiss-German/README.txt), [Luxembourg med sveitsisk fransk](Luxembourg-Swiss-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| **Eksperimentelt:** [Engelsk (USA)](English-United-States/README.txt), [Engelsk (Storbritannia)](English-United-Kingdom/README.txt) | AltGr+5 → « | AltGr+7 → » |

De to engelske variantene er til utprøving av vinkelanførselstegn, ikke et forslag om å endre engelsk tegnsetting. De bruker standard US- og UK-oppsett; høyre Alt blir AltGr. Dette er ikke US-International eller UK Extended.

## Installasjon

Windows 10/11 på x86- eller x64-PC-er; ARM64 er ikke inkludert. Du trenger verken Internett eller Keyboard Layout Creator installert.

1. Pakk ut hele ZIP-filen og åpne mappen for oppsettet ditt. Hold filene samlet.
2. Åpne **setup.exe** normalt, uten **Kjør som administrator**. Avmerkingen **«Bruk som standardtastatur for kontoen min»** er valgfri: merk av for å lagre innstillingen mellom økter. Bare installasjonen ber om administratorrettigheter.
3. Trykk **Win+Mellomrom** og velg navnet som slutter med **“- Angle Quotes”**.
4. Prøv AltGr (høyre Alt) og den øverste tallraden i Notisblokk.

**Installasjonsprogrammet kan oppføre seg ujevnt. Du må noen ganger logge ut og inn igjen før oppsettet vises eller virker.**

Hvis setup.exe ikke starter, åpne `_amd64.msi` for 64-biters Windows eller `_i386.msi` for 32-biters Windows. Installasjonsprogrammene er usignerte; Windows kan vise en ukjent utgiver. Hvis MSI åpnes direkte, er avmerkingen for standardtastatur ikke tilgjengelig.

SmartScreen: advarselen «Windows beskyttet PC-en» ble observert med v0.1.0, ikke i den vellykkede testen av v0.2.0-kandidaten. Installasjonsprogrammene i v0.2.0 er fortsatt usignerte og kan vise advarselen. Denne versjonen slår ikke av eller fjerner beskyttelsen.

## Endrede tegn

I Spania, Italia, Portugal, Norge og Danmark erstatter AltGr+5 eurotegnet; **€ er fortsatt på AltGr+E**. I belgisk fransk er **[ fortsatt tilgjengelig med AltGr og ^-tasten ved siden av P**.

I de sveitsiske variantene flyttes **§ til AltGr+8** og **den loddrette streken til AltGr+1**. Dette erstatter ¢ og ¦, som foreløpig ikke har nye snarveier. Les de lokale instruksjonene først.

Andre kontrollerte kombinasjoner og aksenter beholdes. Ctrl+Alt kan gi de samme tegnene som AltGr.

## Bytt tilbake eller avinstaller

For å slutte å bruke oppsettet som standard åpner du **setup.exe** igjen, fjerner avmerkingen og klikker **«Bruk»**. Forrige innstilling gjenopprettes, og tastaturet forblir installert. Hvis forrige tastatur ikke er tilgjengelig, velger du et annet. Klikk **«Avinstaller»** i samme vindu for å fjerne oppsettet; standardinnstillingen gjenopprettes først ved behov. Win+Mellomrom bytter valgt tastatur uten å fjerne denne innstillingen. Direkte fjerning via Windows-apper eller MSI utfører ikke denne gjenopprettingen.

## Skriveøvelser

Jeg har lagt ved [øvingstekster](practice/README.md) på prosjektets språk. Kategoriene beskriver **hvert avsnitt**, ikke filen eller historien: omtrent 10–25 ord i short, 25–50 i medium og 80–120 i long. Tomme linjer skiller avsnitt; historien kan fortsette. Lim inn ett eller flere avsnitt i **custom**-modus i Monkeytype. Hver enkelt ZIP inneholder `practice/short.txt`, `practice/medium.txt`, `practice/long.txt` og en samlet `practice.txt`.

**Disse oppdiktede tekstene er laget med KI for øving og kan inneholde feil.** De er ikke språklige eller normative referanser. På engelsk brukes vinkelanførselstegn bevisst til testing.

## Testing og tilbakemeldinger

Jeg har prøvd fem opprinnelige varianter på min bærbare PC. De virker, noen ganger etter ny innlogging. Jeg har ikke testet alle 17 manuelt, inkludert de to eksperimentelle engelske variantene. Automatiske kontroller dekker tegntabeller, aksenter og navn på x86, x64 og WOW64.

Jeg vedlikeholder prosjektet. Opprett en issue med Windows-versjon, oppsett, snarvei, resultat og om ny innlogging hjalp.

Den nye avmerkingen består simulerte automatiske tester og pakkekontroller. Brukeren rapporterer en samlet vellykket manuell test av Spanish (Spain) på Windows Home x64, oppgitt versjon 26H2, bygg 26300.9818. Enkelttilfellene ble ikke registrert separat; manuell dekning av andre oppsett eller systemer er ikke dokumentert. De nye oversettelsene er ikke gjennomgått av en uavhengig språkkyndig.

Laget med [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=102134). Min opprinnelige kode og mine endringer bruker [MIT-lisensen](LICENSE). Microsoft-komponenter beholder sine vilkår; se [tredjepartsmerknader](THIRD_PARTY_NOTICES.md).

For utvikling (dokumentasjon på engelsk): [bygg og kontroller](docs/BUILD.md) / [tilbakemeldinger og bidrag](CONTRIBUTING.md).
