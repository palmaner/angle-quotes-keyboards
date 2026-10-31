# Build and verify

End users only need a release ZIP. These steps are for rebuilding the project.

## Requirements

- An x64 Windows PC with Windows PowerShell 5.1.
- Microsoft Keyboard Layout Creator 1.4 installed at its default location: `C:\Program Files (x86)\Microsoft Keyboard Layout Creator 1.4`.
- Any Windows/.NET components required by MSKLC itself. Those build-time requirements do not apply to people installing a finished keyboard package.

Run the following from the repository root:

```powershell
& .\scripts\native-keyboards\build.ps1
& .\scripts\native-keyboards\test.ps1
& .\scripts\native-keyboards\test-installers.ps1
& .\scripts\native-keyboards\distribute.ps1
```

To build one layout:

```powershell
& .\scripts\native-keyboards\build.ps1 -Only English-United-States
```

Run the character-table tests in 32-bit Windows PowerShell as well, once normally and once with `-Target wow64`. These tests read the layout DLLs; they do not install keyboards.

## Project files

- `scripts/native-keyboards/layouts.json`: layout identities, Windows bases and AltGr assignments.
- `scripts/native-keyboards/locales.json`: local instructions.
- `scripts/native-keyboards/readme-translations.json`: all 11 README translations, rendered by one shared generator.
- `sources/base/`: saved Windows-base KLC exports used to generate the layouts.
- `sources/*.klc`: generated KLC snapshots for this release.
- `outputs/`: generated installers and ZIPs; ignored by Git.
- `work/`: build intermediates and validation reports; ignored by Git.

The build uses saved base exports when available. It restores missing work caches from `sources/base/`, then applies `layouts.json`. If neither a saved base nor a cache exists, it uses MSKLC to export the current Windows base and unloads temporary keyboard layouts afterwards. Avoid exporting while testing an installer on the same PC.

The scripts use MSKLC's internal packaging functions, so they depend on version 1.4. Generated MSI identifiers and timestamps can vary between builds; byte-identical output is not promised. The source snapshots and character-table checks make the intended mappings inspectable.

Do not distribute the MSKLC compiler or Windows system DLLs with the project. See [third-party notices](../THIRD_PARTY_NOTICES.md).
