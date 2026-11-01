# Angle Quotes for Windows

[Español](README.es.md) · [English](README.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Português](README.pt.md) · [Norsk bokmål](README.nb.md) · [Dansk](README.da.md) · [Русский](README.ru.md) · [Українська](README.uk.md) · [Беларуская](README.be.md)

I created these 17 native Windows keyboard layouts to make «angle quotes» easy to type with AltGr. Each package keeps its original keyboard and adds the combinations below, without AutoHotkey or an app running in the background.

The collection includes **15 original variants and two experimental English variants: United States and United Kingdom**.

**[Download keyboards](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · [Report a problem](https://github.com/palmaner/angle-quotes-keyboards/issues)

## Choose your layout

Choose by your existing keyboard layout, rather than nationality. The linked instructions use the corresponding language and list every changed position and displaced symbol.

| Layouts and local instructions | Opening | Closing |
| --- | --- | --- |
| [Spanish (Spain)](Spanish-Spain/README.txt), [Spanish (Latin America)](Spanish-Latin-America/README.txt), [Italian](Italian/README.txt), [Russian](Russian/README.txt), [Ukrainian](Ukrainian/README.txt), [Belarusian](Belarusian/README.txt), [Belgian French](Belgian-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| [Portuguese (Portugal)](Portuguese-Portugal/README.txt), [Norwegian](Norwegian/README.txt) | AltGr+5 → « | AltGr+6 → » |
| [German (Germany)](German-Germany/README.txt), [German (Austria)](German-Austria/README.txt), [Danish](Danish/README.txt) | AltGr+5 → » | AltGr+6 → « |
| [Swiss French](Swiss-French/README.txt), [Swiss German](Swiss-German/README.txt), [Luxembourg using Swiss French](Luxembourg-Swiss-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| **Experimental:** [English (United States)](English-United-States/README.txt), [English (United Kingdom)](English-United-Kingdom/README.txt) | AltGr+5 → « | AltGr+7 → » |

The two English variants are for trying angle quotes, not a proposal to change standard English punctuation. They use the standard US and UK layouts; right Alt becomes AltGr. They are not US-International or UK Extended.

## Install

Windows 10/11 on x86 or x64 PCs. ARM64 is not included. No Internet connection or Keyboard Layout Creator installation is needed.

1. Extract the whole downloaded ZIP and open your layout's folder. Keep its files together.
2. Open **setup.exe** normally, without **Run as administrator**. The **“Use as the default keyboard for my account”** checkbox is optional: select it to save this preference between sessions. Only installation requests administrator permission.
3. Press **Windows+Space** and select the name ending in **“- Angle Quotes”**.
4. Test it in Notepad using right Alt and the top number row.

**The installer can behave inconsistently, and Windows may require you to sign out and back in before the layout appears or works correctly.**

If setup.exe does not start, open `_amd64.msi` for 64-bit Windows or `_i386.msi` for 32-bit Windows. The installers are unsigned, so Windows may show “Unknown publisher”. Opening the MSI directly bypasses the default-keyboard checkbox.

New installations make the keyboard available to the whole computer; the default preference applies only to your account. Removing the keyboard can affect other accounts. If an older installation belongs to another account, remove it there before reinstalling; opening the new installer alone does not migrate it.

SmartScreen: the “Windows protected your PC” warning with “Unknown publisher” has been observed when running setup.exe downloaded from GitHub in both v0.1.0 and v0.2.0. The installers remain unsigned. If you have checked the file’s origin and decide to continue, select “More info” and then “Run anyway”, if Windows offers that option. You do not need to disable SmartScreen or Microsoft Defender.

## Character changes

In Spain, Italy, Portugal, Norway and Denmark, AltGr+5 replaces the euro; **€ remains on AltGr+E**. In Belgian French, **[ remains on AltGr+the ^ key** beside P.

In the Swiss variants, **§ moves to AltGr+8** and **the vertical bar moves to AltGr+1**. This replaces ¢ and ¦, which currently have no replacement shortcut. Read the local instructions before choosing these variants.

Other tested character combinations and accents are preserved. Native Ctrl+Alt combinations may produce the same characters as AltGr.

## Switch back or uninstall

To stop using it as default, reopen **setup.exe**, clear the checkbox and click **“Apply”**. This restores your previous preference and leaves the keyboard installed. If the previous keyboard is unavailable, choose another. To remove the layout, click **“Uninstall”** in the same window; the default is restored first if needed. Windows+Space switches the selected keyboard but does not clear this preference. Removing directly through Windows Apps or MSI bypasses this restoration.

## Practise typing

I have included [practice collections](practice/README.md) in the supported languages, with angle quotes used in complete sentences. The categories describe **paragraph length**, not file size or story length: short paragraphs are usually around 10–25 words, medium paragraphs 25–50, and long paragraphs 80–120. Blank lines separate paragraphs; several may belong to the same story. Paste one paragraph or a whole collection into Monkeytype's **custom** mode. Each individual ZIP includes `practice/short.txt`, `practice/medium.txt`, `practice/long.txt` and a combined `practice.txt`.

**These fictional texts were generated with AI for practice and may contain errors.** They are exercises, not language or punctuation references. The English examples deliberately use angle quotes for testing.

## Testing and feedback

I have tried five of the original layouts on my laptop and they work, although signing out was sometimes necessary. I have not manually tested all 17 layouts, including the two experimental English variants. Automated checks cover character tables, accents and display names across x86, x64 and WOW64.

I maintain this project. To report a problem, open an issue with your Windows version, the layout name, the shortcut, what happened and whether signing out helped.

v0.2.1: I successfully tested Spanish (Spain) in a newly created account: installation, enabling/disabling the default, persistence after sign-out or restart, and uninstall. I removed the older per-user installation first. I have not manually tested the other 16 layouts or every Windows configuration; the translations have not received independent linguistic review. The final rebuild adds visible version information to the tested logic.

Built with [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=102134). My original code and modifications are available under the [MIT License](LICENSE). Microsoft components retain their own terms; see [third-party notices](THIRD_PARTY_NOTICES.md).

For maintainers: [build and verify](docs/BUILD.md) / [feedback and contributions](CONTRIBUTING.md).
