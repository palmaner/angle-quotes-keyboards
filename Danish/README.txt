Danish - Angle Quotes

Jeg har lavet dette tastaturlayout for at tilføje vinkelanførselstegn direkte i Windows uden AutoHotkey eller baggrundsprogrammer.

ÆNDREDE KOMBINATIONER (FØR → EFTER)

AltGr+5: € → »
AltGr+6: ikke tildelt → «

Eurotegnet (€) fjernes fra AltGr+5, men er stadig tilgængeligt med AltGr+E. Denne genvej fandtes allerede.

Windows 10/11 på x86- eller x64-pc'er; ARM64 er ikke inkluderet. Du behøver hverken internet eller Keyboard Layout Creator installeret.

1. Pak hele ZIP-filen ud, og åbn mappen til dit layout. Hold filerne samlet.
2. Åbn setup.exe normalt uden Kør som administrator. Afkrydsningsfeltet »Brug som standardtastatur for min konto« er valgfrit: markér det for at gemme indstillingen mellem sessioner. Kun installationen beder om administratorrettigheder.
3. Tryk Win+Mellemrum, og vælg navnet, der slutter med “- Angle Quotes”.
4. Prøv AltGr (højre Alt) og den øverste talrække i Notesblok.

Installationsprogrammet kan opføre sig uensartet. Det kan være nødvendigt at logge ud og ind igen, før layoutet vises eller virker.

Hvis setup.exe ikke starter, åbn _amd64.msi til 64-bit Windows eller _i386.msi til 32-bit Windows. Installationsprogrammerne er usignerede; Windows kan vise en ukendt udgiver. Hvis MSI åbnes direkte, er afkrydsningsfeltet for standardtastatur ikke tilgængeligt.

For at stoppe med at bruge layoutet som standard skal du åbne setup.exe igen, fjerne markeringen og klikke på »Anvend«. Den tidligere indstilling gendannes, og tastaturet forbliver installeret. Hvis det tidligere tastatur ikke er tilgængeligt, vælger du et andet. Klik på »Afinstaller« i samme vindue for at fjerne layoutet; standardindstillingen gendannes først, hvis nødvendigt. Win+Mellemrum skifter det valgte tastatur uden at fjerne denne indstilling. Direkte fjernelse via Windows-apps eller MSI udfører ikke denne gendannelse.

Nye installationer gør tastaturet tilgængeligt for hele computeren; standardindstillingen gælder kun din konto. Fjernelse kan påvirke andre konti. Hvis en ældre installation tilhører en anden konto, fjern den der før geninstallation; åbning af det nye program migrerer den ikke.

SmartScreen: Advarslen »Windows beskyttede din pc« med »Ukendt udgiver« er observeret ved kørsel af setup.exe hentet fra GitHub i både v0.1.0 og v0.2.0. Installationsprogrammerne er stadig usignerede. Hvis du har kontrolleret filens oprindelse og vil fortsætte, vælger du »Flere oplysninger« og derefter »Kør alligevel«, hvis Windows tilbyder dette. Du behøver ikke deaktivere SmartScreen eller Microsoft Defender.

ØVELSE: Kopiér practice.txt til custom-tilstand i Monkeytype eller et andet skriveværktøj. Disse opdigtede tekster er lavet med AI til øvelse og kan indeholde fejl.
practice/: short.txt, medium.txt, long.txt.

Windows x86/x64; ARM64 er ikke inkluderet. Installationsprogrammet er ikke signeret. Jeg har kontrolleret tegntabeller og accenter automatisk; en fuld installation på en ren pc er endnu ikke testet.
