#!/bin/bash

function main() {
  info "Attempting installation of git..."
  install_git
  source "./authors.sh"
  source "./aliases.sh"
  source "./configs.sh"
  copy_default_gitignore
}

function copy_default_gitignore() {
  `cp ./assets/.gitignore ~`
  success "Copied over .gitignore succesfully!"
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
