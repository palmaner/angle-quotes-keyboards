# Vinkelanførselstegn til Windows

[Español](README.es.md) · [English](README.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Português](README.pt.md) · [Norsk bokmål](README.nb.md) · [Dansk](README.da.md) · [Русский](README.ru.md) · [Українська](README.uk.md) · [Беларуская](README.be.md)

Jeg har lavet disse 17 indbyggede tastaturlayouts for at skrive vinkelanførselstegn med AltGr, mens det oprindelige tastatur bevares. AutoHotkey og baggrundsprogrammer er ikke nødvendige.

Samlingen indeholder **15 oprindelige varianter og to eksperimentelle engelske varianter: USA og Storbritannien**.

**[Hent tastaturer](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · [Rapportér et problem](https://github.com/palmaner/angle-quotes-keyboards/issues)

## Vælg layout

Vælg efter dit normale tastatur, ikke kun din nationalitet. Linkene fører til lokale instruktioner med alle ændrede positioner.

| Layouts og instruktioner | Åbning | Lukning |
| --- | --- | --- |
| [Spansk (Spanien)](Spanish-Spain/README.txt), [Spansk (Latinamerika)](Spanish-Latin-America/README.txt), [Italiensk](Italian/README.txt), [Russisk](Russian/README.txt), [Ukrainsk](Ukrainian/README.txt), [Belarusisk](Belarusian/README.txt), [Belgisk fransk](Belgian-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| [Portugisisk (Portugal)](Portuguese-Portugal/README.txt), [Norsk](Norwegian/README.txt) | AltGr+5 → « | AltGr+6 → » |
| [Tysk (Tyskland)](German-Germany/README.txt), [Tysk (Østrig)](German-Austria/README.txt), [Dansk](Danish/README.txt) | AltGr+5 → » | AltGr+6 → « |
| [Schweizisk fransk](Swiss-French/README.txt), [Schweizisk tysk](Swiss-German/README.txt), [Luxembourg med schweizisk fransk](Luxembourg-Swiss-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| **Eksperimentelt:** [Engelsk (USA)](English-United-States/README.txt), [Engelsk (Storbritannien)](English-United-Kingdom/README.txt) | AltGr+5 → « | AltGr+7 → » |

De to engelske varianter er til afprøvning af vinkelanførselstegn, ikke et forslag om at ændre engelsk tegnsætning. De bruger standard US- og UK-layouts; højre Alt bliver AltGr. Det er ikke US-International eller UK Extended.

## Installation

Windows 10/11 på x86- eller x64-pc'er; ARM64 er ikke inkluderet. Du behøver hverken internet eller Keyboard Layout Creator installeret.

1. Pak hele ZIP-filen ud, og åbn mappen til dit layout. Hold filerne samlet.
2. Kør **setup.exe**, og godkend administratoranmodningen.
3. Tryk **Win+Mellemrum**, og vælg navnet, der slutter med **“- Angle Quotes”**.
4. Prøv AltGr (højre Alt) og den øverste talrække i Notesblok.

**Installationsprogrammet kan opføre sig uensartet. Det kan være nødvendigt at logge ud og ind igen, før layoutet vises eller virker.** Installation vælger ikke nødvendigvis layoutet. Hvis det mangler, tilføj det i tastaturindstillingerne for dit sprog i Indstillinger.

Hvis setup.exe ikke starter, åbn `_amd64.msi` til 64-bit Windows eller `_i386.msi` til 32-bit Windows. Installationsprogrammerne er usignerede; Windows kan vise en ukendt udgiver.

## Ændrede tegn

I Spanien, Italien, Portugal, Norge og Danmark erstatter AltGr+5 eurotegnet; **€ findes stadig på AltGr+E**. På belgisk fransk er **[ stadig tilgængelig med AltGr og tasten ^ ved siden af P**.

I de schweiziske varianter flyttes **§ til AltGr+8** og **den lodrette streg til AltGr+1**. Det erstatter ¢ og ¦, som i øjeblikket ikke har nye genveje. Læs de lokale instruktioner først.

Andre kontrollerede kombinationer og accenter bevares. Ctrl+Alt kan give de samme tegn som AltGr.

## Skift tilbage eller afinstaller

Brug **Win+Mellemrum** til at vende tilbage til det oprindelige layout. Vælg det først, kør installationsprogrammet for det tilpassede layout igen, og vælg **Remove**.

## Skriveøvelser

Jeg har tilføjet [øvelsestekster](practice/README.md) på projektets sprog. Kategorierne beskriver **hvert afsnit**, ikke filen eller historien: cirka 10–25 ord i short, 25–50 i medium og 80–120 i long. Tomme linjer adskiller afsnit; historien kan fortsætte. Indsæt et eller flere afsnit i **custom**-tilstand i Monkeytype. Hver enkelt ZIP indeholder `practice/short.txt`, `practice/medium.txt`, `practice/long.txt` og en samlet `practice.txt`.

**Disse opdigtede tekster er lavet med AI til øvelse og kan indeholde fejl.** De er ikke sproglige eller normative referencer. På engelsk bruges vinkelanførselstegn bevidst til afprøvning.

## Test og tilbagemeldinger

Jeg har prøvet fem oprindelige varianter på min bærbare pc. De virker, nogle gange efter nyt login. Jeg har ikke testet alle 17 manuelt, herunder de to eksperimentelle engelske varianter. Automatiske kontroller dækker tegntabeller, accenter og navne på x86, x64 og WOW64.

Jeg vedligeholder projektet. Opret en issue med Windows-version, layout, genvej, resultat og om nyt login hjalp.

Lavet med [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=102134). Min oprindelige kode og mine ændringer bruger [MIT-licensen](LICENSE). Microsoft-komponenter beholder deres vilkår; se [tredjepartsmeddelelser](THIRD_PARTY_NOTICES.md).

Til udvikling (dokumentation på engelsk): [byg og kontrollér](docs/BUILD.md) / [tilbagemeldinger og bidrag](CONTRIBUTING.md).
