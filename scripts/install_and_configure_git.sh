#!/bin/bash

# This script installs and configures git!

function main() {
  echo "Installing git through homebrew!"

  install_git

  if [[ $? ]]; then
    echo "Git has been installed! Now configuring..."
  else
    echo "Could not install git :("
  fi
}

function install_git() {
  `brew install git`
}

main
