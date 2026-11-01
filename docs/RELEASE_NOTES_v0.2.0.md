# v0.2.0 — Default keyboard selection

[Español](RELEASE_NOTES_v0.2.0.es.md) · [English](RELEASE_NOTES_v0.2.0.md) · [Français](RELEASE_NOTES_v0.2.0.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.0.de.md) · [Italiano](RELEASE_NOTES_v0.2.0.it.md) · [Português](RELEASE_NOTES_v0.2.0.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.0.nb.md) · [Dansk](RELEASE_NOTES_v0.2.0.da.md) · [Русский](RELEASE_NOTES_v0.2.0.ru.md) · [Українська](RELEASE_NOTES_v0.2.0.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.0.be.md)

## New installer

- All 17 layouts now include a setup window with an optional **Use as the default keyboard for my account** checkbox. Select it and install or apply to save the Windows default-input preference.
- Reopen `setup.exe`, clear the checkbox and click **Apply** to restore the preceding preference while keeping the keyboard installed. If the previous keyboard is unavailable, setup asks you to choose another available input method.
- The checkbox reflects the current Windows preference. Other languages and keyboards are preserved, and repeated activation does not overwrite the original recovery record with the same layout.
- **Uninstall** restores the preceding default first when needed, then removes the layout. Direct removal through MSI or Windows Apps bypasses this extra restoration step.
- The interface follows the Windows UI language in Spanish, English, French, German, Italian, Portuguese, Norwegian Bokmål, Danish, Russian, Ukrainian and Belarusian, with English fallback.
- Start `setup.exe` normally, without **Run as administrator**. Only MSI operations request elevation; default-input preferences apply to the initiating account. No background application or scheduled task is installed.

## Reliability and documentation

- Setup avoids unnecessary preference queries at startup and handles a plain exception from the Windows default-input query with a read-only lookup of the stored preference. Access errors and malformed values remain errors.
- Setup configuration errors show the command and script location and write a local diagnostic file under `%LOCALAPPDATA%\AngleQuotes\logs`. Logs are not uploaded automatically.
- Installation, restoration and removal instructions have been updated across all 11 README languages and all 17 layout folders. Build sources, translations and isolated preference tests are included.

## Compatibility and warnings

Keyboard DLLs, MSI packages, character assignments and practice texts are unchanged from v0.1.0. Support remains Windows 10/11 on x86/x64; ARM64 is not included. Windows may require sign-out or restart before a keyboard appears or behaves correctly.

The installers remain unsigned. A **Windows protected your PC** SmartScreen warning was observed with v0.1.0; it was not reported in the successful v0.2.0 candidate test. An unsigned v0.2.0 installer may still trigger a warning. This release does not remove or disable SmartScreen protection.

## Validation

- 35 isolated preference assertions pass in both 32-bit and 64-bit Windows PowerShell 5.1, using simulated Windows settings and registry entries.
- 204 installer metadata, architecture, display-name and embedded-resource checks pass. Character-table reports cover all 17 layouts, with 11,016 character comparisons in each of x86, x64 and WOW64, plus dead-key checks.
- Package audits check the 18 ZIP hashes, individual-folder contents, README copies, local links and encoding. The actual setup startup path was also checked read-only in 32-bit and 64-bit PowerShell.
- The user reports successful overall manual testing of the corrected **Spanish (Spain) - Angle Quotes** candidate on Windows Home x64, reported version 26H2, OS build 26300.9818. Individual test cases were not recorded separately. This does not establish manual coverage of the other 16 layouts or all supported Windows versions. New translations have not received independent linguistic review.

Additional user-reported compatibility test: with a v0.1.0 layout already installed, the v0.2.0 setup correctly recognized the existing installation and successfully set it as the default keyboard. This verifies that scenario on the tested machine, rather than a full uninstall/reinstall or coverage of every layout.

## Downloads

Choose `ANGLE_QUOTES_NATIVE_WINDOWS.zip` for all layouts, or the individual ZIP for your layout. Extract the complete ZIP and keep its files together. `SHA256SUMS.txt` lists SHA256 hashes for the 18 downloadable ZIPs.

GitHub's **Source code** ZIP/TAR.GZ downloads are generated separately and are not the packaged installer downloads.
