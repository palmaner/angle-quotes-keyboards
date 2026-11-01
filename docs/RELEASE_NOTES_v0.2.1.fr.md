# v0.2.1 — Désinstallation fiable entre comptes Windows

[Español](RELEASE_NOTES_v0.2.1.es.md) · [English](RELEASE_NOTES_v0.2.1.md) · [Français](RELEASE_NOTES_v0.2.1.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.1.de.md) · [Italiano](RELEASE_NOTES_v0.2.1.it.md) · [Português](RELEASE_NOTES_v0.2.1.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.1.nb.md) · [Dansk](RELEASE_NOTES_v0.2.1.da.md) · [Русский](RELEASE_NOTES_v0.2.1.ru.md) · [Українська](RELEASE_NOTES_v0.2.1.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.1.be.md)

## Nouvel installateur

- Corrige l’erreur **1605** due à la confusion entre un clavier enregistré sur l’ordinateur et une installation MSI appartenant au compte actuel.
- La désinstallation choisit le produit réellement enregistré après vérification de son MSI en cache, de son nom et de sa DLL, sans supposer que le paquet téléchargé l’identifie.
- Les installations existantes par utilisateur se suppriment depuis leur compte propriétaire. Les installations pour l’ordinateur demandent l’autorisation administrateur.
- Les nouvelles installations sont enregistrées pour tout l’ordinateur ; la préférence de clavier par défaut reste propre à chaque compte.
- Les produits absents, ambigus ou non vérifiables sont signalés avant de rétablir une préférence par défaut. Aucun fichier de clavier ni entrée du registre n’est supprimé manuellement.
- La fenêtre et les dialogues affichent maintenant **v0.2.1**. Les propriétés du fichier indiquent la même version. Supprimer un clavier système peut affecter d’autres comptes.

## Fiabilité et documentation

- Les nouvelles installations MSI utilisent explicitement `ALLUSERS=1`. Les suppressions par utilisateur évitent de relancer l’opération sous un autre administrateur.
- Les journaux détaillés `/L*V` et les diagnostics du produit et du contexte sont conservés localement dans `%LOCALAPPDATA%\AngleQuotes\logs`. Ils ne sont pas envoyés automatiquement et peuvent contenir des identifiants de compte et des chemins.
- La sortie réussie `0` est confrontée à l’inventaire MSI avant d’annoncer le succès. Le code `3010`, demandant un redémarrage, est conservé. Les données de version ont une source unique.

## Compatibilité et avertissements

Les DLL de clavier, les paquets MSI, les affectations de caractères et les textes d’entraînement restent identiques à v0.2.0. Windows 10/11 sur x86/x64 reste pris en charge ; ARM64 n’est pas inclus. Windows peut demander une déconnexion ou un redémarrage avant que le clavier apparaisse ou fonctionne correctement.

SmartScreen : l’avertissement « Windows a protégé votre ordinateur », avec « Éditeur inconnu », a été observé en lançant setup.exe téléchargé depuis GitHub dans v0.1.0 et v0.2.0. Les installateurs restent non signés. Si vous avez vérifié l’origine du fichier et décidez de continuer, choisissez « Informations complémentaires », puis « Exécuter quand même », si Windows propose cette option. Il n’est pas nécessaire de désactiver SmartScreen ou Microsoft Defender.

## Validation

- 26 contrôles isolés d’identité et de contexte MSI et les 35 contrôles de préférences existants réussissent dans Windows PowerShell 5.1 en 32 et 64 bits. Les paramètres Windows et les opérations MSI sont simulés.
- 238 contrôles de métadonnées, architectures, noms affichés, ressources intégrées et versions couvrent les 17 dispositions. Les DLL de clavier et les paquets MSI restent inchangés.
- Les empreintes des 18 ZIP, les contenus des dossiers, copies de documentation, liens locaux et encodages sont audités. Les vérifications en lecture seule exercent la détection MSI native et le démarrage réel.
- J’ai testé avec succès Spanish (Spain) dans un compte nouvellement créé : installation, activation/désactivation du défaut, persistance après déconnexion ou redémarrage, et désinstallation. J’ai d’abord supprimé l’ancienne installation par utilisateur. Je n’ai pas testé manuellement les 16 autres dispositions ni toutes les configurations Windows ; les traductions n’ont pas reçu de révision linguistique indépendante. La compilation finale ajoute la version visible à la logique testée.

Si une ancienne installation appartient à un autre compte, désinstallez-la depuis ce compte d’origine avant d’installer cette version depuis le compte voulu. Créer un compte ou ouvrir le nouvel installateur ne migre pas un enregistrement MSI existant par utilisateur. J’ai effectué cette migration avec succès puis répété le test complet dans un nouveau compte.

## Téléchargements

Choisissez `ANGLE_QUOTES_NATIVE_WINDOWS.zip` pour toutes les dispositions, ou le ZIP individuel correspondant à votre clavier. Extrayez le ZIP complet et gardez les fichiers ensemble. `SHA256SUMS.txt` contient les empreintes SHA256 des 18 ZIP téléchargeables.

Les archives **Source code** ZIP/TAR.GZ de GitHub sont générées séparément et ne sont pas les paquets d’installation.
