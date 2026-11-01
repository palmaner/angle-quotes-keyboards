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
& .\scripts\native-keyboards\test-setup.ps1
& .\scripts\native-keyboards\test-setup-msi.ps1
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
- `scripts/native-keyboards/release-notes-translations.json`: versioned release notes in the same 11 languages, rendered by `generate-release-notes.ps1`. Selectors use relative links; the optional release-page body links to files at the release tag.
- `scripts/native-keyboards/version.json`: shared release/setup version, used for the window title, executable version properties and release-note filenames and links.
- `sources/base/`: saved Windows-base KLC exports used to generate the layouts.
- `sources/*.klc`: generated KLC snapshots for this release.
- `outputs/`: generated installers and ZIPs; ignored by Git.
- `work/`: build intermediates and validation reports; ignored by Git.

The build uses saved base exports when available. It restores missing work caches from `sources/base/`, then applies `layouts.json`. If neither a saved base nor a cache exists, it uses MSKLC to export the current Windows base and unloads temporary keyboard layouts afterwards. Avoid exporting while testing an installer on the same PC.

The scripts use MSKLC's internal packaging functions, so they depend on version 1.4. Generated MSI identifiers and timestamps can vary between builds; byte-identical output is not promised. The source snapshots and character-table checks make the intended mappings inspectable.

Do not distribute the MSKLC compiler or Windows system DLLs with the project. See [third-party notices](../THIRD_PARTY_NOTICES.md).

## Default keyboard checkbox

`build.ps1` finishes by running `build-setup.ps1`. The latter can also rebuild only the launchers, using the existing MSI packages, without recompiling keyboard DLLs:

```powershell
& .\scripts\native-keyboards\build-setup.ps1 -PackageRoot .
```

The launcher is compiled with the Windows .NET Framework C# compiler and an `asInvoker` manifest. It embeds the PowerShell 5.1 WinForms interface, preference functions and translations. It runs only while setup is open. Only Windows Installer is elevated; user preferences are applied in the initiating account. Start setup normally, without **Run as administrator**. Extract the complete ZIP before running it.

The checkbox reads the registered keyboard DLL and the current default input preference, rather than assuming a fixed custom KLID. It preserves the user's language list, saves the preceding preference under `%LOCALAPPDATA%\AngleQuotes\defaults`, and uses the International module to set or restore the default. Clearing the checkbox keeps the keyboard installed. If the saved keyboard is unavailable, the user must choose another available input method. Uninstalling through this launcher restores the preference first; direct MSI maintenance and Windows Apps removal bypass this extra step. These preferences apply to the current account, not the sign-in screen or other users.

`test-setup.ps1` uses in-memory replacements for the Windows settings commands and keyboard registry. It tests preference restoration, repeated activation, multiple layouts, missing keyboards and rejected changes without installing or activating a keyboard. `test-installers.ps1` checks embedded identities, resources, translations and the non-elevated manifest as well as the existing MSI and DLL metadata.

Manual test scenarios for disposable x86/x64 Windows 10/11 systems: install with the checkbox both cleared and selected; reopen, select and clear it; change the default in Windows Settings and reopen; sign out and restart after activation and restoration; cancel UAC; enter a different administrator's credentials; uninstall while active; and remove the saved previous keyboard before restoring. Automated tests do not establish persistence across real sessions or reboots. I successfully tested the corrected Spanish (Spain) candidate on Windows Home x64, reported version 26H2, build 26300.9818. Individual scenarios were not recorded separately; this report does not establish complete coverage of this matrix or the other layouts.

Microsoft references: [default input method override](https://learn.microsoft.com/en-us/powershell/module/international/set-windefaultinputmethodoverride), [user language list](https://learn.microsoft.com/en-us/powershell/module/international/set-winuserlanguagelist), [registered keyboard identifiers](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-language-pack-default-values).

Setup failures show the failing command and script location and save detailed diagnostics under `%LOCALAPPDATA%\AngleQuotes\logs`. Logs remain local and are not uploaded; review them before sharing because they can contain local paths. A keyboard that is not registered is shown as not installed without querying user input preferences. When the International module throws a plain `System.Exception` while reading the default override, setup falls back to a read-only lookup of `InputMethodOverride`; a missing value means Windows language-list selection. Permission failures and malformed values remain errors.

For a read-only startup check, extract `setup-core.ps1`, `setup-msi.ps1`, `setup-ui.ps1` and `setup-config.json` from a launcher's embedded resources into a temporary work directory, and run Windows PowerShell 5.1 with `-NoProfile -STA -File setup-ui.ps1 -PackageRoot <layout-folder> -CheckStartup`. This constructs the real interface and reads its real initial state, then exits before showing the window or running MSI/preference changes. Preview mode instead uses simulated state and cannot establish that the real Windows settings commands work.

## MSI installation context correction

The updated launcher also embeds `setup-msi.ps1`. Include that resource when extracting a launcher for a read-only startup check. It inventories installed MSI products in the current-user and machine contexts, verifies the cached package's product code, keyboard DLL and product name, and removes that installed product by its actual code. A keyboard registration alone does not establish that the MSI from a downloaded ZIP is the product to remove. Missing or ambiguous product identities are reported before restoring any default-input preference.

Existing per-user products are uninstalled in the initiating user context, without explicitly relaunching msiexec under another administrator account. Machine products request elevation. Fresh installations explicitly use `ALLUSERS=1`, since these layouts register system DLLs; the default-input preference still belongs to the initiating account. Uninstalling a system keyboard can affect other accounts using it. Do not manually remove keyboard DLLs or registry keys to work around error 1605.

MSI operations save verbose `/L*V` logs and selected-product metadata under `%LOCALAPPDATA%\AngleQuotes\logs`; an unresolvable inventory is logged there as JSON. Logs are local and can contain account identifiers and paths. A successful zero exit is checked against the product inventory before reporting completion. Reboot-required exit 3010 remains distinct.

`test-setup-msi.ps1` uses simulated inventories and package metadata to check product-code mismatches, user/machine contexts, foreign users, duplicate matches, missing caches and completion checks without running msiexec. The 1605 case was traced to a per-user MSI registered in the original account, while the test account could see the shared keyboard DLL but had no matching MSI registration. An existing per-user installation is not migrated simply by opening the new installer: remove it from its original account before a fresh machine installation.

I successfully removed the old installation from the original account, installed and removed it from the test account, and then completed the Spanish (Spain) test in a newly created account: installation, enabling/disabling the default, persistence after sign-out or restart and uninstall. This is manual coverage of that tested scenario, not all Windows editions, account policies or layouts. The final build adds visible version information and file version properties to that tested logic; its rebuilt resources and startup are checked automatically.
