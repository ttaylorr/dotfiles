#!/bin/bash

set -e

INSTALL_SCRIPT="install.sh"

function main() {
  while read line; do
    cd "$DOTFILES_ROOT/$line"
    source "./$INSTALL_SCRIPT"
  done < "$DOTFILES_ROOT/scripts/utils/install_checklist"
}

main
