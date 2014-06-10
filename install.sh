#!/bin/bash

# This is the instalation script for ttaylorr's .dotfiles
function main() {
  do_greeting
  gather_details
  do_install
}

function do_greeting() {
  echo "Hello! You are installing ttaylorr's dotfiles."
}

function gather_details() {
  read -p "What is your name? " name
  read -p "What is your email? " email
}

function do_install() {
  source "./scripts/install_homebrew.sh"
  source "./scripts/install_and_configure_git.sh"
}

main
