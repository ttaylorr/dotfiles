#!/bin/bash

function main() {
  if test ! $(which brew); then
    info "Now installing homebrew..."
    install_homebrew
  else
    success "Homebrew already installed"
  fi
}

function install_homebrew() {
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  if [ $? -eq 0 ]; then
    success "Homebrew installed!"
  else
    fail "Could not install homebrew :("
  fi
}

main
