#!/bin/bash

# This script installs and configures git!

function main() {
  echo "Installing git through homebrew!"

  install_git

  if [[ $? ]]; then
    echo "Git has been installed! Now configuring..."
    configure_git
  else
    echo "Could not install git :("
  fi
}

function install_git() {
  `brew install git`
}

function configure_git() {
  copy_user_details $name $email
}

# arg1 -> user.name
# arg2 -> user.email
function copy_user_details() {
  `git config --global user.name "$1"`
  `git config --global user.email "$2"`
}

main
