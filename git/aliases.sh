#!/bin/bash

function main() {
  setup_aliases
}

function setup_aliases() {
  make_alias "st"  "status"
  make_alias "aa"  "add --all"
  make_alias "ci"  "commit"
  make_alias "br"  "branch"
  make_alias "co"  "checkout"
  make_alias "di"  "diff"
  make_alias "pom" "push origin master"
}

function make_alias() {
  `git config --global alias.$1 "$2"`
  info "Aliased 'git $1' to 'git $2'"
}

main
