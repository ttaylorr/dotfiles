#!/bin/bash

set -e

install_name="install.sh"
cd "$DOTFILES_ROOT"

function main() {
  while read line; do
    cd "$DOTFILES_ROOT/$line"
    source "./install.sh"
    cd ..
  done < "$DOTFILES_ROOT/scripts/utils/install_checklist"
}

main
