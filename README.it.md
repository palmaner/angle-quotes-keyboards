# Virgolette angolari per Windows

[Español](README.es.md) · [English](README.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Português](README.pt.md) · [Norsk bokmål](README.nb.md) · [Dansk](README.da.md) · [Русский](README.ru.md) · [Українська](README.uk.md) · [Беларуская](README.be.md)

Ho creato queste 17 disposizioni native per scrivere le virgolette angolari (« »), dette anche virgolette caporali, con AltGr, mantenendo la tastiera originale senza AutoHotkey né applicazioni in background.

La raccolta comprende **15 varianti originali e due inglesi sperimentali: Stati Uniti e Regno Unito**.

**[Scarica le tastiere](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · [Segnala un problema](https://github.com/palmaner/angle-quotes-keyboards/issues)

## Video tutorial

Installazione, esempio di scrittura con i tasti premuti visibili sullo schermo e disinstallazione. I testi del video sono in inglese (1 min 40 s).

<https://github.com/user-attachments/assets/929ffdb1-1dc7-4a61-92c1-566bd14acf4a>

## Scegli la disposizione

Scegli in base alla tastiera abituale, non soltanto alla nazionalità. I collegamenti portano alle istruzioni locali con tutte le posizioni modificate.

| Disposizioni e istruzioni | Apertura | Chiusura |
| --- | --- | --- |
| [Spagnolo (Spagna)](Spanish-Spain/README.txt), [Spagnolo (America Latina)](Spanish-Latin-America/README.txt), [Italiano](Italian/README.txt), [Russo](Russian/README.txt), [Ucraino](Ukrainian/README.txt), [Bielorusso](Belarusian/README.txt), [Francese belga](Belgian-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| [Portoghese (Portogallo)](Portuguese-Portugal/README.txt), [Norvegese](Norwegian/README.txt) | AltGr+5 → « | AltGr+6 → » |
| [Tedesco (Germania)](German-Germany/README.txt), [Tedesco (Austria)](German-Austria/README.txt), [Danese](Danish/README.txt) | AltGr+5 → » | AltGr+6 → « |
| [Francese svizzero](Swiss-French/README.txt), [Tedesco svizzero](Swiss-German/README.txt), [Lussemburgo con francese svizzero](Luxembourg-Swiss-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| **Sperimentale:** [Inglese (Stati Uniti)](English-United-States/README.txt), [Inglese (Regno Unito)](English-United-Kingdom/README.txt) | AltGr+5 → « | AltGr+7 → » |

Le due varianti inglesi servono a provare le virgolette angolari, non a proporre cambiamenti alla punteggiatura inglese. Usano le tastiere standard statunitense e britannica; Alt destro diventa AltGr. Non sono US-International o UK Extended.

## Installazione

Windows 10/11 su PC x86 o x64; ARM64 non è incluso. Non servono Internet né un'installazione di Keyboard Layout Creator.

1. Estrai tutto lo ZIP e apri la cartella della tua tastiera. Mantieni insieme i file.
2. Apri **setup.exe** normalmente, senza **Esegui come amministratore**. La casella **«Usa come tastiera predefinita per il mio account»** è facoltativa: selezionala per salvare la preferenza tra le sessioni. Solo l’installazione richiede i permessi di amministratore.
3. Premi **Win+Spazio** e seleziona il nome che termina con **“- Angle Quotes”**.
4. Prova AltGr (Alt destro) e la fila superiore dei numeri nel Blocco note.

**L'installer può comportarsi in modo irregolare: potrebbe essere necessario uscire dalla sessione e rientrare prima che la tastiera compaia o funzioni.**

Se setup.exe non parte, apri `_amd64.msi` per Windows a 64 bit oppure `_i386.msi` per 32 bit. Gli installer non sono firmati; Windows potrebbe indicare un autore sconosciuto. Aprire direttamente il MSI esclude la casella della tastiera predefinita.

Le nuove installazioni rendono la tastiera disponibile per tutto il computer; la preferenza predefinita riguarda solo il tuo account. Rimuoverla può interessare altri account. Se una vecchia installazione appartiene a un altro account, rimuovila da lì prima di reinstallare; aprire il nuovo programma non la migra.

SmartScreen: l’avviso «PC protetto da Windows», con «Autore sconosciuto», è stato osservato eseguendo setup.exe scaricato da GitHub sia in v0.1.0 sia in v0.2.0. I programmi di installazione restano privi di firma digitale. Se hai verificato l’origine del file e decidi di continuare, scegli «Ulteriori informazioni» e poi «Esegui comunque», se Windows offre questa opzione. Non occorre disattivare SmartScreen o Microsoft Defender.

## Modifiche ai caratteri

In Spagna, Italia, Portogallo, Norvegia e Danimarca, AltGr+5 sostituisce l'euro; **€ rimane su AltGr+E**. Nel francese belga, **[ resta disponibile con AltGr e il tasto ^ accanto a P**.

Nelle varianti svizzere, **§ passa ad AltGr+8** e **la barra verticale ad AltGr+1**. Vengono sostituiti ¢ e ¦, che attualmente non hanno nuove scorciatoie. Consulta prima le istruzioni locali.

Le altre combinazioni e gli accenti verificati restano invariati. Ctrl+Alt può produrre gli stessi caratteri di AltGr.

## Tornare alla tastiera precedente o disinstallare

Per non usarla più come predefinita, riapri **setup.exe**, deseleziona la casella e premi **«Applica»**. La preferenza precedente viene ripristinata e la tastiera resta installata. Se la tastiera precedente non è disponibile, scegline un’altra. Per rimuovere la disposizione, premi **«Disinstalla»** nella stessa finestra; se necessario viene prima ripristinata la preferenza precedente. Win+Spazio cambia la tastiera selezionata senza cancellare questa preferenza. La rimozione diretta tramite le app di Windows o MSI non esegue questo ripristino.

## Esercizi di digitazione

Ho incluso [testi di esercitazione](practice/README.md) nelle lingue del progetto. Le categorie indicano la lunghezza di **ogni paragrafo**, non del file o della storia: circa 10–25 parole per short, 25–50 per medium e 80–120 per long. Le righe vuote separano i paragrafi, ma la storia può continuare. Incollane uno o più nella modalità **custom** di Monkeytype. Ogni ZIP individuale include `practice/short.txt`, `practice/medium.txt`, `practice/long.txt` e un `practice.txt` combinato.

**Questi testi di fantasia sono stati generati con IA per esercitarsi e possono contenere errori.** Non sono riferimenti linguistici o normativi. In inglese le virgolette angolari vengono usate intenzionalmente per le prove.

## Test e segnalazioni

Ho provato cinque varianti originali sul mio portatile e funzionano, talvolta dopo un nuovo accesso. Non ho verificato manualmente tutte le 17 varianti, comprese le due inglesi sperimentali. I controlli automatici coprono tabelle dei caratteri, accenti e nomi in x86, x64 e WOW64.

Mi occupo del progetto. Per segnalare un problema, apri un'issue con versione di Windows, tastiera, scorciatoia, risultato e indicazione se un nuovo accesso ha aiutato.

v0.2.1: Ho provato con successo Spanish (Spain) in un account nuovo: installazione, attivazione/disattivazione del predefinito, persistenza dopo disconnessione o riavvio e disinstallazione. Prima ho rimosso la vecchia installazione per utente. Non ho testato manualmente le altre 16 disposizioni né tutte le configurazioni Windows; le traduzioni non hanno ricevuto una revisione linguistica indipendente. La compilazione finale aggiunge la versione visibile alla logica provata.

Creato con [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=102134). Il mio codice originale e le mie modifiche usano la [licenza MIT](LICENSE). I componenti Microsoft mantengono le proprie condizioni; consulta gli [avvisi sulle terze parti](THIRD_PARTY_NOTICES.md).

Per lo sviluppo (documentazione in inglese): [compilare e verificare](docs/BUILD.md) / [segnalazioni e contributi](CONTRIBUTING.md).
