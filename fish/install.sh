#!/bin/bash

fish_dir="/usr/local/bin/fish"

function main() {
  install_fish
  add_to_shells
  set_default_shell
  symlink_bashrc
}

function install_fish() {
  info "Installing fish"
  `brew install fish`
  success "Installed fish!"
}

function add_to_shells() {
  `echo "$fish_dir" | sudo tee -a /etc/shells`
  info 'Added fish to shells'
}

function set_default_shell() {
  if [[ "$fish_dir" != "$SHELL" ]]; then
    `chsh -s $fish_dir`
  fi
}

function symlink_bashrc() {
  fishrc_path="~/.config/fish/config.fish"
  if [ -e "$fishrc_path" ]; then
    rm $fishrc_path
  fi
  ln -s "$fishrc_path" "~/.bashrc" 
}

main
