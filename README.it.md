# Virgolette angolari per Windows

[Español](README.es.md) · [English](README.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Português](README.pt.md) · [Norsk bokmål](README.nb.md) · [Dansk](README.da.md) · [Русский](README.ru.md) · [Українська](README.uk.md) · [Беларуская](README.be.md)

Ho creato queste 17 disposizioni native per scrivere le virgolette angolari con AltGr, mantenendo la tastiera originale senza AutoHotkey né applicazioni in background.

La raccolta comprende **15 varianti originali e due inglesi sperimentali: Stati Uniti e Regno Unito**.

**[Scarica le tastiere](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · [Segnala un problema](https://github.com/palmaner/angle-quotes-keyboards/issues)

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

SmartScreen: l’avviso «PC protetto da Windows» è stato osservato con v0.1.0, non durante la prova riuscita della candidata v0.2.0. I programmi di installazione v0.2.0 restano privi di firma digitale e potrebbero mostrarlo. Questa versione non disattiva né rimuove tale protezione.

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

La nuova casella supera i test automatici simulati e le verifiche dei pacchetti. L’utente segnala una prova manuale complessivamente riuscita di Spanish (Spain) su Windows Home x64, versione indicata 26H2, build 26300.9818. I singoli casi non sono stati registrati separatamente; non è accertata la copertura manuale delle altre disposizioni o dei sistemi. Le nuove traduzioni non hanno ricevuto una revisione linguistica indipendente.

Creato con [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=102134). Il mio codice originale e le mie modifiche usano la [licenza MIT](LICENSE). I componenti Microsoft mantengono le proprie condizioni; consulta gli [avvisi sulle terze parti](THIRD_PARTY_NOTICES.md).

Per lo sviluppo (documentazione in inglese): [compilare e verificare](docs/BUILD.md) / [segnalazioni e contributi](CONTRIBUTING.md).
