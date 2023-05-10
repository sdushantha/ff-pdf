#!/usr/bin/env sh
#
# by Siddharth Dushantha
#
# Installation script for FF PDF
# https://github.com/sdushantha/ff-pdf
#

VERSION="1.0.0"

FF_PDF_BIN="$HOME/.local/bin/ff-pdf"
FF_PDF_DESKTOP="$HOME/.local/share/applications/ff-pdf.desktop"
FF_PDF_CONFIG="$HOME/.config/ff-pdf"
FF_PDF_ICON="$FF_PDF_CONFIG/icon.png"
FF_PDF_STARTPAGE="$FF_PDF_CONFIG/startpage.html"

GOOD="\033[92m✔\033[0m"

# Fancy-schmancy banner
echo -e "\e[1m  ___ ___   ___ ___  ___  
 | __| __| | _ \   \| __| 
 | _|| _|  |  _/ |) | _|  
 |_| |_|   |_| |___/|_|  v$VERSION\n\e[0m"


# We generate a new profile and fetch the profile's directory name by finding the
# newest directory in ~/.mozilla/firefox/
# This directory name is appended to the ~/.mozilla/firefox/ to get the profile's path
#
# Credits to u/ashutosharma97 on Reddit for showing how to create new
# Firefox profiles from the CLI: https://bit.ly/3MayLRu+
if [ -d "$HOME/.mozilla" ]; then
   profile_root_directory="$HOME/.mozilla/firefox/$(firefox -CreateProfile ff-pdf && ls -td | head -1)"
elif [ -d "$HOME/.librewolf" ]; then 
   profile_root_directory="$HOME/.librewolf/$(librewolf -CreateProfile ff-pdf && ls -td | head -1)"
fi


# The config directory for FF PDF is created and the config files
# are copied into it. 
#
# Config file explainations:
#   icon.png - This image file is used as the icon for the desktop app
#   startpage.html - This is the UI that the user sees if no PDF is selected
mkdir -p "$FF_PDF_CONFIG"
cp resources/icon.png "$FF_PDF_ICON"
cp resources/startpage.html "$FF_PDF_STARTPAGE"

# Copy our custom settings to FF PDF's Firefox profile and
# add the path to the startpage into the settings file
cp resources/user.js "$profile_root_directory/"
sed -i "s|STARTPAGE_PATH|$FF_PDF_STARTPAGE|" "$profile_root_directory/user.js"
printf "%b\n" "$GOOD Configured icon and startpage"


# The 'chrome' directory is created and 'userChrome.css' i copied into it
# 'userChrome.css' contains custom CSS that hides UI elements in Firefox that
# creates the illusion that FF PDF is just a PDF reader and not a web browser
mkdir -p "$profile_root_directory/chrome"
cp resources/userChrome.css "$profile_root_directory/chrome"
printf "%b\n" "$GOOD Configured UI using userChrome.css"


# Copy the 'ff-pdf' script into ~/.local/bin/ and swap the string FF_PROFILE
# for the path to FF PDF's Firefox profile
cp resources/ff-pdf "$FF_PDF_BIN"
chmod +x "$FF_PDF_BIN"
sed -i "s|FF_PROFILE|$profile_root_directory|" "$FF_PDF_BIN"
printf "%b\n" "$GOOD Added 'ff-pdf' command to ~/.local/bin/"


# Copy FF PDF's desktop application file into the directory
# which application launchers look for .desktop files.
# Then add the path to the ff-pdf script and the path to
# the icon that will be used for the desktop application
cp resources/ff-pdf.desktop "$FF_PDF_DESKTOP"
sed -i "s|FF_PDF_COMMAND|$FF_PDF_BIN|" "$FF_PDF_DESKTOP"
sed -i "s|ICON_FILE_PATH|$FF_PDF_ICON|" "$FF_PDF_DESKTOP"
update-desktop-database > /dev/null 2>&1
printf "%b\n" "$GOOD Installed FF PDF as a desktop application"
printf "%b\n" "$GOOD Installation complete!\n"


message="\033[1;4mWays to use FF PDF\033[0m
1. Launch FF PDF from your application launcher
2. Open a PDF from your file browser
3. Run 'ff-pdf' from the CLI
   Make sure ~/local/bin is in your \$PATH\n"

printf "%b\n" "$message"
