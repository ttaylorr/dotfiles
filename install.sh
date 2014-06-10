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
  echo "Please enter your name and hit [ENTER]"
  read name

  echo "Please enter your email and hit [ENTER]"
  read email
}

function do_install() {
  source "./scripts/install_homebrew.sh"
  source "./scripts/install_and_configure_git.sh"
}

main
