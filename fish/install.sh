#!/bin/bash

function main() {
  install_fish
  add_to_shells
}

function install_fish() {
  info "Installing fish"
  `brew install fish`
  success "Installed fish!"
}

function add_to_shells() {
  `echo "/usr/local/bin/fish" | sudo tee -a /etc/shells`
  info 'Added fish to shells'
}

main
