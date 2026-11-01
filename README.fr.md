# Guillemets pour Windows

[Español](README.es.md) · [English](README.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Português](README.pt.md) · [Norsk bokmål](README.nb.md) · [Dansk](README.da.md) · [Русский](README.ru.md) · [Українська](README.uk.md) · [Беларуская](README.be.md)

J’ai créé ces 17 dispositions natives pour saisir des guillemets avec AltGr, en conservant le clavier d’origine, sans AutoHotkey ni application en arrière-plan.

La collection comprend **15 variantes originales et deux variantes anglaises expérimentales : États-Unis et Royaume-Uni**.

**[Télécharger les claviers](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · [Signaler un problème](https://github.com/palmaner/angle-quotes-keyboards/issues)

## Choisir une disposition

Choisissez selon votre clavier habituel, pas seulement votre nationalité. Les liens donnent accès aux instructions locales et à toutes les positions modifiées.

| Dispositions et instructions | Ouverture | Fermeture |
| --- | --- | --- |
| [Espagnol (Espagne)](Spanish-Spain/README.txt), [Espagnol (Amérique latine)](Spanish-Latin-America/README.txt), [Italien](Italian/README.txt), [Russe](Russian/README.txt), [Ukrainien](Ukrainian/README.txt), [Biélorusse](Belarusian/README.txt), [Français belge](Belgian-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| [Portugais (Portugal)](Portuguese-Portugal/README.txt), [Norvégien](Norwegian/README.txt) | AltGr+5 → « | AltGr+6 → » |
| [Allemand (Allemagne)](German-Germany/README.txt), [Allemand (Autriche)](German-Austria/README.txt), [Danois](Danish/README.txt) | AltGr+5 → » | AltGr+6 → « |
| [Français suisse](Swiss-French/README.txt), [Allemand suisse](Swiss-German/README.txt), [Luxembourg avec français suisse](Luxembourg-Swiss-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| **Expérimental:** [Anglais (États-Unis)](English-United-States/README.txt), [Anglais (Royaume-Uni)](English-United-Kingdom/README.txt) | AltGr+5 → « | AltGr+7 → » |

Les deux variantes anglaises servent à essayer les guillemets, sans proposer de modifier la ponctuation anglaise. Elles utilisent les claviers américain et britannique standard ; Alt droit devient AltGr. Il ne s’agit pas de US-International ni de UK Extended.

## Installation

Windows 10/11 sur PC x86 ou x64 ; ARM64 n’est pas inclus. Aucune connexion Internet ni installation de Keyboard Layout Creator n’est nécessaire.

1. Extrayez tout le ZIP et ouvrez le dossier de votre clavier. Gardez les fichiers ensemble.
2. Ouvrez **setup.exe** normalement, sans **Exécuter en tant qu’administrateur**. La case **« Utiliser comme clavier par défaut pour mon compte »** est facultative : cochez-la pour enregistrer cette préférence entre les sessions. Seule l’installation demande les droits administrateur.
3. Appuyez sur **Win+Espace** et choisissez le nom se terminant par **“- Angle Quotes”**.
4. Testez AltGr (Alt droit) et la rangée supérieure des chiffres dans le Bloc-notes.

**L’installateur peut se comporter de façon irrégulière : une déconnexion puis reconnexion peut être nécessaire pour que le clavier apparaisse ou fonctionne.**

Si setup.exe ne démarre pas, ouvrez `_amd64.msi` pour Windows 64 bits ou `_i386.msi` pour 32 bits. Les installateurs ne sont pas signés ; Windows peut afficher « Éditeur inconnu ». L’ouverture directe du MSI contourne la case du clavier par défaut.

SmartScreen : l’avertissement « Windows a protégé votre ordinateur », avec « Éditeur inconnu », a été observé en lançant setup.exe téléchargé depuis GitHub dans v0.1.0 et v0.2.0. Les installateurs restent non signés. Si vous avez vérifié l’origine du fichier et décidez de continuer, choisissez « Informations complémentaires », puis « Exécuter quand même », si Windows propose cette option. Il n’est pas nécessaire de désactiver SmartScreen ou Microsoft Defender.

## Changements de caractères

En Espagne, Italie, Portugal, Norvège et au Danemark, AltGr+5 remplace l’euro ; **€ reste sur AltGr+E**. En français belge, **[ reste accessible avec AltGr et la touche ^ à côté de P**.

Dans les variantes suisses, **§ passe à AltGr+8** et **la barre verticale passe à AltGr+1**. Cela remplace ¢ et ¦, qui n’ont actuellement aucun nouveau raccourci. Consultez les instructions locales avant de les choisir.

Les autres combinaisons et accents vérifiés sont conservés. Ctrl+Alt peut produire les mêmes caractères qu’AltGr.

## Revenir au clavier d’origine ou désinstaller

Pour ne plus l’utiliser par défaut, rouvrez **setup.exe**, décochez la case et cliquez sur **« Appliquer »**. La préférence précédente est rétablie et le clavier reste installé. Si l’ancien clavier n’est plus disponible, choisissez-en un autre. Pour supprimer la disposition, cliquez sur **« Désinstaller »** dans la même fenêtre ; le clavier par défaut est d’abord rétabli si nécessaire. Win+Espace change le clavier sélectionné sans effacer cette préférence. La suppression directe depuis les applications Windows ou le MSI ne réalise pas cette restauration.

## Entraînement

J’ai inclus des [textes d’entraînement](practice/README.md) dans les langues du projet. Les catégories décrivent **chaque paragraphe**, pas le fichier ni l’histoire : environ 10–25 mots pour short, 25–50 pour medium et 80–120 pour long. Les lignes vides séparent les paragraphes ; une histoire peut continuer. Collez un ou plusieurs paragraphes dans le mode **custom** de Monkeytype. Chaque ZIP individuel contient `practice/short.txt`, `practice/medium.txt`, `practice/long.txt` et un `practice.txt` combiné.

**Ces textes fictifs ont été générés par IA pour la pratique et peuvent contenir des erreurs.** Ce ne sont pas des références linguistiques ou normatives. L’anglais utilise volontairement des guillemets pour les essais.

## Tests et retours

J’ai essayé cinq variantes originales sur mon portable ; elles fonctionnent, parfois après une déconnexion. Je n’ai pas testé manuellement les 17, notamment les deux variantes anglaises expérimentales. Les vérifications automatiques couvrent les tables de caractères, les accents et les noms en x86, x64 et WOW64.

Je maintiens ce projet. Pour signaler un problème, ouvrez une issue avec la version de Windows, le clavier, le raccourci, le résultat et l’effet éventuel d’une déconnexion.

La nouvelle case réussit les tests automatisés simulés et les contrôles des paquets. L’utilisateur rapporte un essai manuel global réussi de Spanish (Spain) sur Windows Home x64, version indiquée 26H2, build 26300.9818. Les cas individuels n’ont pas été consignés séparément ; la couverture manuelle des autres dispositions ou systèmes n’est pas établie. Les nouvelles traductions n’ont pas reçu de révision linguistique indépendante.

Créé avec [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=102134). Mon code original et mes modifications sont sous [licence MIT](LICENSE). Les composants Microsoft conservent leurs conditions ; voir les [avis de tiers](THIRD_PARTY_NOTICES.md).

Pour le développement (documentation en anglais) : [compiler et vérifier](docs/BUILD.md) / [retours et contributions](CONTRIBUTING.md).
