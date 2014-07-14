#!/bin/bash

function main() {
  info "Setting up all git config defaults..."
  set_val 'push.default' 'current'
  set_val 'branch.autosetuprebase' 'always'
  set_val 'core.excludesfile' '~/.gitignore'
  success "Configured all git defaults!"
}

function set_val() {
  `git config --global $1 $2`
  info "Set '$1' to '$2' globally"
}

main
