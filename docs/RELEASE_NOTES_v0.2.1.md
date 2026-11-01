# v0.2.1 — Reliable uninstall across Windows accounts

[Español](RELEASE_NOTES_v0.2.1.es.md) · [English](RELEASE_NOTES_v0.2.1.md) · [Français](RELEASE_NOTES_v0.2.1.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.1.de.md) · [Italiano](RELEASE_NOTES_v0.2.1.it.md) · [Português](RELEASE_NOTES_v0.2.1.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.1.nb.md) · [Dansk](RELEASE_NOTES_v0.2.1.da.md) · [Русский](RELEASE_NOTES_v0.2.1.ru.md) · [Українська](RELEASE_NOTES_v0.2.1.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.1.be.md)

## New installer

- Fixes error **1605** caused by confusing a system keyboard registration with an MSI installation belonging to the current account.
- Uninstallation selects the actual registered product after checking its cached MSI, name and keyboard DLL, rather than assuming that the downloaded package identifies it.
- Existing per-user installations are removed in their owning account. Machine installations request administrator authorization.
- New installations are registered for the whole computer; the default-keyboard preference remains separate for each account.
- Missing, ambiguous or unverifiable products are reported before restoring a default preference. No keyboard files or registry entries are deleted manually.
- The setup window and dialogs now show **v0.2.1**. File properties identify the same version. Removing a system keyboard may affect other accounts.

## Reliability and documentation

- Fresh MSI installation explicitly uses `ALLUSERS=1`. User-context removals avoid relaunching the operation as another administrator.
- Verbose `/L*V` logs and product/context diagnostics are saved locally under `%LOCALAPPDATA%\AngleQuotes\logs`. They are not uploaded automatically and may contain account identifiers and paths.
- Successful exit `0` is checked against the MSI inventory before reporting completion. Restart-required exit `3010` is preserved. Version metadata comes from one shared source.

## Compatibility and warnings

Keyboard DLLs, MSI packages, character assignments and practice texts are unchanged from v0.2.0. Support remains Windows 10/11 on x86/x64; ARM64 is not included. Windows may require sign-out or restart before a keyboard appears or behaves correctly.

SmartScreen: the “Windows protected your PC” warning with “Unknown publisher” has been observed when running setup.exe downloaded from GitHub in both v0.1.0 and v0.2.0. The installers remain unsigned. If you have checked the file’s origin and decide to continue, select “More info” and then “Run anyway”, if Windows offers that option. You do not need to disable SmartScreen or Microsoft Defender.

## Validation

- 26 isolated MSI identity/context checks and the existing 35 preference checks pass in both 32-bit and 64-bit Windows PowerShell 5.1. Windows settings and MSI operations are simulated.
- 238 installer metadata, architecture, display-name, embedded-resource and version checks cover all 17 layouts. Keyboard DLLs and MSI packages remain unchanged.
- The 18 ZIP hashes, folder contents, documentation copies, local links and encoding are audited. Read-only checks exercise native MSI discovery and the real setup startup path.
- I successfully tested Spanish (Spain) in a newly created account: installation, enabling/disabling the default, persistence after sign-out or restart, and uninstall. I removed the older per-user installation first. I have not manually tested the other 16 layouts or every Windows configuration; the translations have not received independent linguistic review. The final rebuild adds visible version information to the tested logic.

For an older installation owned by another account, first uninstall from that original account, then install this version from the intended account. Creating a new account or merely opening the new installer does not migrate an existing per-user MSI registration. I successfully completed this migration and then repeated the full test in a fresh account.

## Downloads

Choose `ANGLE_QUOTES_NATIVE_WINDOWS.zip` for all layouts, or the individual ZIP for your layout. Extract the complete ZIP and keep its files together. `SHA256SUMS.txt` lists SHA256 hashes for the 18 downloadable ZIPs.

GitHub's **Source code** ZIP/TAR.GZ downloads are generated separately and are not the packaged installer downloads.
