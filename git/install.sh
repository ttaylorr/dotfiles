#!/bin/bash

function main() {
  info "Attempting installation of git..."
  install_git
  source "./authors.sh"
  source "./aliases.sh"
  source "./configs.sh"
  source "./install_lfs.sh"
  copy_default_gitignore
  copy_commands
}

function copy_default_gitignore() {
  `cp ./assets/.gitignore ~`
  success "Copied over .gitignore succesfully!"
}

function copy_commands() {
  `sudo cp ./assets/git-update-master /usr/bin/`
  success "Copied over custom git commands"
}

function install_git() {
  `brew install git`
  if [ $? -eq 0 ]; then
    success "Installed git!"
  else
    fail "Could not install git :("
  fi
}

main
