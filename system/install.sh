#!/bin/bash

function main() {
  info "Installing system things (mainly .bashrc)"
  init_tmp_bashrc
  source "./aliases.sh"
  echo "export JAVA_HOME=$(/usr/libexec/java_home)" >> ./tmp/.bashrc
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
  cp "./assets/.bash_profile" "$HOME/.bash_profile"
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
