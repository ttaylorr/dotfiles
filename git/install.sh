#!/bin/bash

function main() {
  info "Attempting installation of git..."
  install_git
  source "./authors.sh"
  source "./aliases.sh"
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
