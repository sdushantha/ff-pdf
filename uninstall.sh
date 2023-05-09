#!/usr/bin/env bash
#
# by Siddharth Dushantha
#
# Uninstall script for FF PDF
# https://github.com/sdushantha/ff-pdf
#

printf "%b\n" "\nSorry to see you go (o︵o)\n"

GOOD="\033[92m✔\033[0m"

printf "%b\n" "$GOOD Removed config files"
rm -rf "$HOME/.config/ff-pdf"

printf "%b\n" "$GOOD Removed CLI program"
rm -f $HOME/.local/bin/ff-pdf

printf "%b\n" "$GOOD Removed desktop application\n"
rm -f $HOME/.local/share/applications/ff-pdf.desktop
update-desktop-database > /dev/null 2>&1

printf "%b\n" "A new Firefox window has been launched"
printf "%b\n" "Manually remove the \033[1mff-pdf\033[0m profile"
firefox --new-window "about:profiles"