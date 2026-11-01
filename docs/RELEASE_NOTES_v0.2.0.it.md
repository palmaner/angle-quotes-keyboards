# v0.2.0 — Scelta della tastiera predefinita

[Español](RELEASE_NOTES_v0.2.0.es.md) · [English](RELEASE_NOTES_v0.2.0.md) · [Français](RELEASE_NOTES_v0.2.0.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.0.de.md) · [Italiano](RELEASE_NOTES_v0.2.0.it.md) · [Português](RELEASE_NOTES_v0.2.0.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.0.nb.md) · [Dansk](RELEASE_NOTES_v0.2.0.da.md) · [Русский](RELEASE_NOTES_v0.2.0.ru.md) · [Українська](RELEASE_NOTES_v0.2.0.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.0.be.md)

## Nuovo programma di installazione

- Tutte le 17 disposizioni includono una finestra con la casella facoltativa **Usa come tastiera predefinita per il mio account**. Selezionala e installa o applica la modifica per salvare la preferenza di input predefinito di Windows.
- Riapri `setup.exe`, deseleziona la casella e premi **Applica** per ripristinare la preferenza precedente lasciando la tastiera installata. Se la tastiera precedente non è disponibile, il programma chiede di scegliere un altro metodo di input disponibile.
- La casella riflette la preferenza attuale di Windows. Le altre lingue e tastiere vengono conservate; attivazioni ripetute non sovrascrivono il dato originale di ripristino con la stessa disposizione.
- **Disinstalla** ripristina prima la preferenza precedente, se necessario, e poi rimuove la disposizione. La rimozione diretta tramite MSI o le app di Windows salta questo passaggio aggiuntivo.
- L’interfaccia segue la lingua di Windows: spagnolo, inglese, francese, tedesco, italiano, portoghese, norvegese bokmål, danese, russo, ucraino e bielorusso, con inglese come alternativa.
- Apri `setup.exe` normalmente, senza **Esegui come amministratore**. Solo le operazioni MSI richiedono privilegi elevati; le preferenze di input riguardano l’account che ha aperto il programma. Non vengono installate app in background né attività pianificate.

## Affidabilità e documentazione

- Il programma evita letture inutili delle preferenze all’avvio. Se la lettura Windows dell’input predefinito genera un’eccezione generica, consulta la preferenza memorizzata in sola lettura. Gli errori di accesso e i valori non validi restano errori.
- Gli errori di configurazione mostrano il comando e la posizione nello script e salvano un file diagnostico locale in `%LOCALAPPDATA%\AngleQuotes\logs`. I registri non vengono inviati automaticamente.
- Le istruzioni di installazione, ripristino e rimozione sono aggiornate nelle 11 lingue dei README e nelle cartelle delle 17 disposizioni. Sono inclusi sorgenti di compilazione, traduzioni e test isolati delle preferenze.

## Compatibilità e avvertenze

DLL delle tastiere, pacchetti MSI, assegnazioni dei caratteri e testi di pratica non cambiano rispetto a v0.1.0. Restano supportati Windows 10/11 su x86/x64; ARM64 non è incluso. Windows può richiedere disconnessione o riavvio prima che la tastiera compaia o funzioni correttamente.

SmartScreen: l’avviso «PC protetto da Windows», con «Autore sconosciuto», è stato osservato eseguendo setup.exe scaricato da GitHub sia in v0.1.0 sia in v0.2.0. I programmi di installazione restano privi di firma digitale. Se hai verificato l’origine del file e decidi di continuare, scegli «Ulteriori informazioni» e poi «Esegui comunque», se Windows offre questa opzione. Non occorre disattivare SmartScreen o Microsoft Defender.

## Verifica

- Superate 35 verifiche isolate delle preferenze in Windows PowerShell 5.1 sia a 32 sia a 64 bit, con impostazioni Windows e voci del registro simulate.
- Superate 204 verifiche di metadati degli installer, architetture, nomi visualizzati e risorse integrate. I rapporti delle tabelle coprono le 17 disposizioni, con 11 016 confronti di caratteri per ciascuna architettura x86, x64 e WOW64, oltre alle verifiche dei tasti morti.
- Le verifiche dei pacchetti controllano gli hash dei 18 ZIP, i contenuti delle cartelle individuali, le copie dei README, i collegamenti locali e la codifica. Anche il percorso reale di avvio è stato controllato in sola lettura con PowerShell a 32 e 64 bit.
- Ho provato con successo la candidata corretta **Spanish (Spain) - Angle Quotes** su Windows Home x64, versione 26H2, build 26300.9818. I singoli casi non sono stati registrati separatamente. Non è accertata la copertura manuale delle altre 16 disposizioni né di tutte le versioni Windows supportate. Le nuove traduzioni non hanno ricevuto una revisione linguistica indipendente.

Ho verificato anche la compatibilità: con una disposizione v0.1.0 già installata, il programma v0.2.0 ha riconosciuto l’installazione esistente e ha consentito di impostarla come tastiera predefinita. La prova verifica questo caso sul computer usato, senza attestare una disinstallazione e reinstallazione complete o la copertura di tutte le disposizioni.

## Download

Scegli `ANGLE_QUOTES_NATIVE_WINDOWS.zip` per tutte le disposizioni oppure lo ZIP individuale della tua. Estrai tutto lo ZIP e conserva insieme i file. `SHA256SUMS.txt` elenca gli hash SHA256 dei 18 ZIP scaricabili.

Gli archivi **Source code** ZIP/TAR.GZ di GitHub sono generati separatamente e non sono i pacchetti di installazione.
