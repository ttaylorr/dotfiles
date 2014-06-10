#!/bin/bash

function main() {
  echo "Installing Homebrew... checking platform"

  platform_check;

  if [[ $? -eq 'Darwin' ]]; then
    echo "OS X found, beginning installation"
    if install_homebrew; then
      echo "Homebrew installed!"
    else
      echo "Homebrew installation failed... it may have already been installed."
    fi
  else
    echo "Misc. platform found... exiting installation"
  fi
}

function platform_check() {
  platform=`uname`
}

function install_homebrew() {
  return `ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"`
}

main
