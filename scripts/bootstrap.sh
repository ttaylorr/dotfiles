#!/bin/bash

DOTFILES_ROOT="`pwd`"
set -e

# Thanks to @holman for these neat one-liners
function info ()   { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
function success() { printf "\r\033[2K  [ \033[00;32m✔\033[0m ] $1\n"; }
function fail()    { printf "\r\033[2K  [\033[0;31m ✖ \033[0m] $1\n"; exit; }

function main() {
  link_utils
  info "Installing ttaylorr's dotfiles from: $DOTFILES_ROOT"

  read -p "Enter your GitHub name: " github_name
  read -p "Enter your GitHub email: " github_email

  source "$DOTFILES_ROOT/scripts/install.sh"
  unlink_utils
}

function link_utils() {
  export -f info
  export -f success
  export -f fail
}

function unlink_utils() {
  unset info
  unset success
  unset fail
}

main
