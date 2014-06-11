#!/bin/bash

function main() {
  write_alias "g" "git"
  write_alias "ls" "ls -G"
}

function write_alias() {
  echo "alias $1='$2'" >> ./tmp/.bashrc
  if [ $? -eq 0]; then
    info "Aliased '$1' to '$2' in new .bashrc"
  else
    fail "Could not make alias from '$1' to '$2'"
  fi
}

main
