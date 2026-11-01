# v0.2.0 — Choix du clavier par défaut

[Español](RELEASE_NOTES_v0.2.0.es.md) · [English](RELEASE_NOTES_v0.2.0.md) · [Français](RELEASE_NOTES_v0.2.0.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.0.de.md) · [Italiano](RELEASE_NOTES_v0.2.0.it.md) · [Português](RELEASE_NOTES_v0.2.0.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.0.nb.md) · [Dansk](RELEASE_NOTES_v0.2.0.da.md) · [Русский](RELEASE_NOTES_v0.2.0.ru.md) · [Українська](RELEASE_NOTES_v0.2.0.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.0.be.md)

## Nouvel installateur

- Les 17 dispositions incluent désormais une fenêtre d’installation avec la case facultative **Utiliser comme clavier par défaut pour mon compte**. Cochez-la puis installez ou appliquez le changement pour enregistrer la préférence de saisie par défaut de Windows.
- Rouvrez `setup.exe`, décochez la case et cliquez sur **Appliquer** pour rétablir la préférence précédente tout en gardant le clavier installé. Si l’ancien clavier n’est plus disponible, l’installateur demande de choisir une autre méthode de saisie disponible.
- La case reflète la préférence actuelle de Windows. Les autres langues et claviers sont conservés ; les activations répétées ne remplacent pas la préférence de récupération originale par cette même disposition.
- **Désinstaller** rétablit d’abord le clavier par défaut précédent si nécessaire, puis supprime la disposition. La suppression directe par MSI ou les applications Windows contourne cette restauration supplémentaire.
- L’interface suit la langue de Windows : espagnol, anglais, français, allemand, italien, portugais, norvégien bokmål, danois, russe, ukrainien et biélorusse, avec l’anglais par défaut si nécessaire.
- Ouvrez `setup.exe` normalement, sans **Exécuter en tant qu’administrateur**. Seules les opérations MSI demandent une élévation ; les préférences de saisie s’appliquent au compte ayant ouvert l’installateur. Aucune application en arrière-plan ni tâche planifiée n’est installée.

## Fiabilité et documentation

- L’installateur évite les requêtes de préférences inutiles au démarrage. Si la requête Windows du clavier par défaut lève une exception générique, il consulte la préférence enregistrée en lecture seule. Les erreurs d’accès et les valeurs mal formées restent des erreurs.
- Les erreurs de configuration affichent la commande et l’emplacement dans le script et créent un diagnostic local dans `%LOCALAPPDATA%\AngleQuotes\logs`. Les journaux ne sont pas envoyés automatiquement.
- Les instructions d’installation, de restauration et de suppression ont été mises à jour dans les 11 langues des README et les dossiers des 17 dispositions. Les sources de compilation, les traductions et les tests isolés de préférences sont inclus.

## Compatibilité et avertissements

Les DLL de clavier, les paquets MSI, les affectations de caractères et les textes d’entraînement restent identiques à v0.1.0. Windows 10/11 sur x86/x64 reste pris en charge ; ARM64 n’est pas inclus. Windows peut demander une déconnexion ou un redémarrage avant que le clavier apparaisse ou fonctionne correctement.

SmartScreen : l’avertissement « Windows a protégé votre ordinateur », avec « Éditeur inconnu », a été observé en lançant setup.exe téléchargé depuis GitHub dans v0.1.0 et v0.2.0. Les installateurs restent non signés. Si vous avez vérifié l’origine du fichier et décidez de continuer, choisissez « Informations complémentaires », puis « Exécuter quand même », si Windows propose cette option. Il n’est pas nécessaire de désactiver SmartScreen ou Microsoft Defender.

## Validation

- 35 vérifications isolées des préférences réussissent dans Windows PowerShell 5.1 en 32 et 64 bits, avec des paramètres Windows et des entrées du registre simulés.
- 204 contrôles des métadonnées des installateurs, architectures, noms affichés et ressources intégrées réussissent. Les rapports de tables de caractères couvrent les 17 dispositions, avec 11 016 comparaisons de caractères pour chacune des architectures x86, x64 et WOW64, ainsi que des contrôles des touches mortes.
- Les audits vérifient les empreintes des 18 ZIP, le contenu des dossiers individuels, les copies des README, les liens locaux et l’encodage. Le démarrage réel de l’installateur a également été vérifié en lecture seule dans PowerShell 32 et 64 bits.
- L’utilisateur rapporte un essai manuel global réussi du candidat corrigé **Spanish (Spain) - Angle Quotes** sur Windows Home x64, version indiquée 26H2, build 26300.9818. Les cas individuels n’ont pas été consignés séparément. Cela n’établit pas une couverture manuelle des 16 autres dispositions ni de toutes les versions Windows prises en charge. Les nouvelles traductions n’ont pas reçu de révision linguistique indépendante.

Essai de compatibilité supplémentaire rapporté par l’utilisateur : avec une disposition v0.1.0 déjà installée, l’installateur v0.2.0 a reconnu l’installation existante et a permis de la définir comme clavier par défaut. Cet essai confirme ce cas sur la machine testée, sans établir une désinstallation et réinstallation complètes ni la couverture de toutes les dispositions.

## Téléchargements

Choisissez `ANGLE_QUOTES_NATIVE_WINDOWS.zip` pour toutes les dispositions, ou le ZIP individuel correspondant à votre clavier. Extrayez le ZIP complet et gardez les fichiers ensemble. `SHA256SUMS.txt` contient les empreintes SHA256 des 18 ZIP téléchargeables.

Les archives **Source code** ZIP/TAR.GZ de GitHub sont générées séparément et ne sont pas les paquets d’installation.
