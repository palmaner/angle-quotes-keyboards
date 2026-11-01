# v0.2.1 — Disinstallazione affidabile tra account Windows

[Español](RELEASE_NOTES_v0.2.1.es.md) · [English](RELEASE_NOTES_v0.2.1.md) · [Français](RELEASE_NOTES_v0.2.1.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.1.de.md) · [Italiano](RELEASE_NOTES_v0.2.1.it.md) · [Português](RELEASE_NOTES_v0.2.1.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.1.nb.md) · [Dansk](RELEASE_NOTES_v0.2.1.da.md) · [Русский](RELEASE_NOTES_v0.2.1.ru.md) · [Українська](RELEASE_NOTES_v0.2.1.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.1.be.md)

## Nuovo programma di installazione

- Corregge l’errore **1605** dovuto alla confusione tra una tastiera registrata nel sistema e un’installazione MSI dell’account attuale.
- La disinstallazione seleziona il prodotto realmente registrato verificandone MSI in cache, nome e DLL, senza dedurne l’identità dal pacchetto scaricato.
- Le installazioni esistenti per utente si rimuovono dall’account proprietario. Quelle del computer richiedono l’autorizzazione di amministratore.
- Le nuove installazioni vengono registrate per tutto il computer; la tastiera predefinita resta una preferenza per account.
- Prodotti mancanti, ambigui o non verificabili vengono segnalati prima di ripristinare la preferenza. File di tastiera e voci del registro non vengono eliminati manualmente.
- Finestra e messaggi mostrano **v0.2.1**. Le proprietà del file indicano la stessa versione. Rimuovere una tastiera di sistema può interessare altri account.

## Affidabilità e documentazione

- Le nuove installazioni MSI usano esplicitamente `ALLUSERS=1`. Le rimozioni per utente non rilanciano l’operazione come un altro amministratore.
- I registri dettagliati `/L*V` e i dati diagnostici di prodotto e contesto sono salvati localmente in `%LOCALAPPDATA%\AngleQuotes\logs`. Non vengono inviati automaticamente e possono contenere identificativi degli account e percorsi.
- Il codice di successo `0` viene verificato nell’inventario MSI prima della conferma. Il codice di riavvio `3010` viene conservato. La versione proviene da un’unica fonte.

## Compatibilità e avvertenze

DLL delle tastiere, pacchetti MSI, assegnazioni dei caratteri e testi di pratica non cambiano rispetto a v0.2.0. Restano supportati Windows 10/11 su x86/x64; ARM64 non è incluso. Windows può richiedere disconnessione o riavvio prima che la tastiera compaia o funzioni correttamente.

SmartScreen: l’avviso «PC protetto da Windows», con «Autore sconosciuto», è stato osservato eseguendo setup.exe scaricato da GitHub sia in v0.1.0 sia in v0.2.0. I programmi di installazione restano privi di firma digitale. Se hai verificato l’origine del file e decidi di continuare, scegli «Ulteriori informazioni» e poi «Esegui comunque», se Windows offre questa opzione. Non occorre disattivare SmartScreen o Microsoft Defender.

## Verifica

- Superate 26 verifiche isolate di identità e contesto MSI e le 35 verifiche delle preferenze in Windows PowerShell 5.1 a 32 e 64 bit. Impostazioni Windows e operazioni MSI sono simulate.
- 238 controlli di metadati, architetture, nomi visualizzati, risorse integrate e versioni coprono le 17 disposizioni. DLL e pacchetti MSI restano invariati.
- Si verificano hash dei 18 ZIP, contenuti delle cartelle, copie della documentazione, collegamenti locali e codifica. Le prove in sola lettura controllano rilevamento MSI nativo e avvio reale.
- Ho provato con successo Spanish (Spain) in un account nuovo: installazione, attivazione/disattivazione del predefinito, persistenza dopo disconnessione o riavvio e disinstallazione. Prima ho rimosso la vecchia installazione per utente. Non ho testato manualmente le altre 16 disposizioni né tutte le configurazioni Windows; le traduzioni non hanno ricevuto una revisione linguistica indipendente. La compilazione finale aggiunge la versione visibile alla logica provata.

Se una vecchia installazione appartiene a un altro account, rimuovila prima dall’account originale e poi installa questa versione da quello desiderato. Creare un account o aprire il nuovo programma non migra una registrazione MSI per utente esistente. Ho completato questa migrazione con successo e poi ripetuto il test completo in un account nuovo.

## Download

Scegli `ANGLE_QUOTES_NATIVE_WINDOWS.zip` per tutte le disposizioni oppure lo ZIP individuale della tua. Estrai tutto lo ZIP e conserva insieme i file. `SHA256SUMS.txt` elenca gli hash SHA256 dei 18 ZIP scaricabili.

Gli archivi **Source code** ZIP/TAR.GZ di GitHub sono generati separatamente e non sono i pacchetti di installazione.
