# Delphi Editor With Ligatures

<p align="center">
    <img src="/Screenshots/ligatures-on-off-cascadia.gif">    
</p>
<p align="center"><sub><i>Cascadia font, default colors, light theme</i></sup></p>

## Disclaimer

> [!WARNING]
> - This is a sample code, not a production-ready solution. Please read [Bugs](#known-bugs) section before using this extension.
> - This addon is developed for RAD Studio Athens 12, and I am not sure whether it works in previous versions or not.

There are multiple free programming fonts created and designed for writing and reading code efficiently. Many of these fonts offer [ligatures](https://en.wikipedia.org/wiki/Ligature_(writing)) to improve symbols appearance, such as [Cascadia Code](https://github.com/microsoft/cascadia-code), [Fira Code](https://github.com/tonsky/FiraCode), [Iosevka](https://typeof.net/Iosevka/), [JetBrains Mono](https://www.jetbrains.com/lp/mono/), and [many more](https://www.programmingfonts.org/).

Unfortunately, RAD Studio editor does not support rendering font ligatures, so even if you install any of the fonts above, you won't see their true value. This add-on is addressed to fix this and move RAD Studio editor one step forward on the long road to excellence.

The package enhances the RAD Studio editor by utilizing Open Tools API to replace the default font rendering process, enabling it to display ligated characters when the selected font supports them. This code is an adopted version of the sample package from the ToolsAPI [PaintText Event Demo](https://github.com/Embarcadero/RADStudio12Demos/tree/main/Object%20Pascal/ToolsAPI/Editor%20Demos/PaintText%20Event%20Demo). It was created to show just how *incredibly difficult* it is to get ligature-enabled fonts working in the IDE.

> [!NOTE]
> Fonts like Lucida Console, Courier New, and Consolas do not support ligatures. This extension will not show any effect when you use such fonts.

## Installation

Download the repository, open project `EditorLigatures.dproj`, and compile it. Right click on `EditorLigatures.bpl` project in the **Projects** window and choose **Install** option from the menu.

### To remove extension from IDE

Go to menu **Component** -> **Install packages...**, find `EditorLigatures.bpl` and disable or remove it from the packages list.

## Screenshots
Below are sample screenshots of how some popular fonts can look in RAD Studio IDE with ligatures enabled.

<details>
<summary><h3>Default colors, Light theme</h3></summary>
  
|BEFORE<br>Ligatures Off 😖|AFTER<br>Ligatures On 🤩|
|-|-|
|||
|Cascadia|Cascadia|
|![](/Screenshots/default-light-off-cascadia.png)<br><p align="center"><sup><i>Cascadia Code, Default colors, Light theme</i></sup></p>|![](/Screenshots/default-light-on-cascadia.png)<br><p align="center"><sup><i>Cascadia Code, Default colors, Light theme</i></sup></p>|
|FiraCode|FiraCode|
|![](/Screenshots/default-light-off-firacode.png)|![](/Screenshots/default-light-on-firacode.png)|
|Iosevka|Iosevka|
|![](/Screenshots/default-light-off-iosevka.png)|![](/Screenshots/default-light-on-iosevka.png)|
|Mono|Mono|
|![](/Screenshots/default-light-off-mono.png)|![](/Screenshots/default-light-on-mono.png)|
</details>
<details>
<summary><h3>Default colors, Dark theme</h3></summary>

|BEFORE<br>Ligatures Off 😖|AFTER<br>Ligatures On 🤩|
|-|-|
|Cascadia|Cascadia|
|![](/Screenshots/default-dark-off-cascadia.png)|![](/Screenshots/default-dark-on-cascadia.png)|
|FiraCode|FiraCode|
|![](/Screenshots/default-dark-off-firacode.png)|![](/Screenshots/default-dark-on-firacode.png)|
|Iosevka|Iosevka|
|![](/Screenshots/default-dark-off-iosevka.png)|![](/Screenshots/default-dark-on-iosevka.png)|
|Mono|Mono|
|![](/Screenshots/default-dark-off-mono.png)|![](/Screenshots/default-dark-on-mono.png)|
</details>

<details>
<summary><h3>Default colors, Light theme (Gif)</h3></summary>

![](/Screenshots/ligatures-default.gif)
</details>

<details>
<summary><h3>Default colors, Dark theme (Gif)</h3></summary>

![](/Screenshots/ligatures-default-dark.gif)
</details>

## Monako Theme
I prefer [Monaco Editor](https://microsoft.github.io/monaco-editor/) over the default color scheme shipped with RAD Studio. There are registry files [monako-theme.reg](Themes/monako-theme.reg.txt) and [monako-theme-dark.reg](Themes/monako-theme-dark.reg.txt) if you want to add this color set to your RAD Studio IDE.

<details>
<summary><h3>Monako colors, Light theme (Gif)</h3></summary>

![](/Screenshots/ligatures-monako-light.gif)
</details>

<details>
<summary><h3>Monako colors, Dark theme (Gif)</h3></summary>

![](/Screenshots/ligatures-monako-dark.gif)
</details>

## Known Bugs
- [ ] Color SpeedSetting doesn't display selected color scheme in editor's options dialog
- [ ] Highlighting the same words sometimes works incorrectly
- [ ] There are glitches with rendering some fonts (Lucida Console)

## Further improvements
- [ ] Transparent selection with syntax highlighting (the editor doesn't highlight syntax while code is in a selected state) - now it's not possible to implement due to lack of necessary OTAPI functions.
