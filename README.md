<p align=center>
    <img src="resources/banner.png" width="65%" height="65%">
</p>

https://github.com/sherlock-project/sherlock/assets/27065646/441ed266-ef4f-4219-8271-8c63b57f960d

## What is this?
Firefox comes with a great built-in PDF viewer and editor, but using it solely as a PDF reader may not be visually appealing due to its web browser user interface. Fortunately, the FF PDF installation script can create a separate profile dedicated to reading and editing PDFs. Additionally, the script adds custom CSS to hide the browser's UI elements, giving the appearance of a dedicated PDF reader.

## Installation
```console
$ git clone https://github.com/sdushantha/ff-pdf
$ cd ff-pdf
$ bash install.sh
```
Notice: Only tested on Linux with i3wm. Can't guarantee this will visualy pleasing on other OS or on systems with a desktop environment. But feel free to send PRs if you have a a solution on supporting other OS and DEs
## Usage
1. Launch it from your application launcher
2. Open a PDF from your file browser by right clicking and selecting FF PDF
3. Execute `ff-pdf FILE`

## Highly customizable!
FF PDF stores it's config files in `~/.config/ff-pdf/` and contains the following files

- [`icon.png`](resoureces/icon.png) - The icon of app when you launch it from your application launcher or right click in file explorer to open a PDF
- [`startpage.html`](resources/startpage.html) - This is the UI you see when you open FF PDF without opening a PDF file
