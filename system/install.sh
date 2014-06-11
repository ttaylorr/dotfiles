#!/bin/bash

function main() {
  init_tmp_bashrc
  source "./aliases.sh"
  copy_bashrc
  cleanup
}

function init_tmp_bashrc() {
  cleanup
  mkdir "./tmp"
  touch "./tmp/.bashrc"
}

function copy_bashrc() {
  cp "./tmp/.bashrc" "$HOME/.bashrc"
}

function cleanup() {
  `rm -rf "./tmp"`
}

main
