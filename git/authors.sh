#!/bin/bash

function main() {
  $(git config --global user.name "$github_name")
  $(git config --global user.email "$github_email")

  info "Set name in ~/.gitconfig to: $github_name"
  info "Set name in ~/.gitconfig to: $github_email"
}

main
