#!/bin/sh

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

EXPORT_TO="$1"
if [ -z "$EXPORT_TO" ]; then
  EXPORT_TO="$DIR/import.sh"
fi

KARABINER="/Applications/Karabiner.app/Contents/Library/bin/karabiner"
if [ ! -x "$KARABINER" ]; then
  echo "Could not find Karabiner.app installed on your system."
  echo ""
  echo "Without Karabiner installed, this script is unable to"
  echo "export your settings."
  echo ""
  echo "Have you installed the Brewfile located in ~/.dotfiles ?"

  exit 1
fi

echo "$($KARABINER export)" > "$EXPORT_TO"

echo "Successfully exported Karabiner settings to $EXPORT_TO"
exit 0
