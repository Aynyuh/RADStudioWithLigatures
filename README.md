# Delphi Editor With Ligatures

> In writing and typography, a ligature occurs where two or more graphemes or letters are joined to form a single glyph. [Wikipedia](https://en.wikipedia.org/wiki/Ligature_(writing))

There are multiple free programming fonts created and designed for writing and reading code efficiently. Many of these fonts offer ligatures to improve symbols appearance, such as [Cascadia Code](https://github.com/microsoft/cascadia-code), [Fira Code](https://github.com/tonsky/FiraCode), [Iosevka](https://typeof.net/Iosevka/), [JetBrains Mono](https://www.jetbrains.com/lp/mono/), and [many more](https://www.programmingfonts.org/).

> [!NOTE]
> This extension is useless with fonts like Lucida Console, Courier New, and Consolas as they do not support ligatures.

|BEFORE<br>Ligatures Off 😖|AFTER<br>Ligatures On 🤩|
|-|-|
|![](/Screenshots/default-light-off-cascadia.png)<br><p align="center"><sup><i>Cascadia Code, Default colors, Light theme</i></sup></p>|![](/Screenshots/default-light-on-cascadia.png)<br><p align="center"><sup><i>Cascadia Code, Default colors, Light theme</i></sup></p>|

Unfortunately, RAD Studio editor does not support rendering font ligatures, so even if you install any of the fonts above, you won't see their true value. This add-on is addressed to fix this and move RAD Studio editor one step forward on the long road to excellence.

The package enhances the RAD Studio editor by utilizing Open Tools API to replace the default font rendering process, enabling it to display ligated characters when the selected font supports them. This code is an adopted version of the sample package from the ToolsAPI [PaintText Event Demo](https://github.com/Embarcadero/RADStudio12Demos/tree/main/Object%20Pascal/ToolsAPI/Editor%20Demos/PaintText%20Event%20Demo). It was created to show just how *incredibly difficult* it is to get ligature-enabled fonts working in the IDE.

## Requirements & Installation

> [!IMPORTANT]
> This addon is developed for RAD Studio Athens 12, and I don't know for sure whether it works in previous versions or not.

Download the repository, open `EditorLigatures.dproj` file and compile the project. Right click on `EditorLigatures.bpl` project in Projects window and choose "Install" option from the menu.

## Fonts Examples

<details>
<summary><h3>Default colors, Light theme</h3></summary>
  
|BEFORE<br>Ligatures Off 😖|AFTER<br>Ligatures On 🤩|
|-|-|
|||
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
I prefer [Monaco Editor](https://microsoft.github.io/monaco-editor/)'s color scheme than the default color scheme shipped with RAD Studio. There are registry files [monako-theme.reg](Themes/monako-theme.reg.txt) and [monako-theme-dark.reg](Themes/monako-theme-dark.reg.txt) if you would like to add this color set to your RAD Studio.

<details>
<summary><h3>Monako colors, Light theme (Gif)</h3></summary>

![](/Screenshots/ligatures-monako-light.gif)
</details>

<details>
<summary><h3>Monako colors, Dark theme (Gif)</h3></summary>

![](/Screenshots/ligatures-monako-dark.gif)
</details>
