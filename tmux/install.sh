#!/bin/bash

function main() {
  install_tmux:
  install tmux_conf;
}

function install_tmux() {
  info "Installing tnux..."
  brew install tmux
  success "Installed tnux"
}

function install_tmux_conf() {
  cp ./.tmux.conf ~/.tmux.conf
}

main;
