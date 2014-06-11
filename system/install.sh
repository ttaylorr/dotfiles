#!/bin/bash

function main() {
  info "Installing system things (mainly .bashrc)"
  init_tmp_bashrc
  source "./aliases.sh"
  copy_bashrc
  cleanup
}

function init_tmp_bashrc() {
  cleanup
  info "Creating new /tmp directory"
  mkdir "./tmp"
  touch "./tmp/.bashrc"
}

function copy_bashrc() {
  cp "./tmp/.bashrc" "$HOME/.bashrc"
  if [ $? -eq 0 ]; then
    success "Copied over the new .bashrc!"
  else
    fail "Could not write out the new .bashrc"
  fi
}

function cleanup() {
  info "Cleaning out old dust"
  `rm -rf "./tmp"`
}

main
