#!/bin/bash

function main() {
  setup_aliases
  success "Created all necessary git aliases!"
}

function setup_aliases() {
  make_alias "st"  "status"
  make_alias "a"   "add"
  make_alias "aa"  "add --all"
  make_alias "ci"  "commit"
  make_alias "br"  "branch"
  make_alias "co"  "checkout"
  make_alias "di"  "diff"
  make_alias "pom" "push origin master"
  make_alias "udm" "update-master"
  make_alias "sl"  "shortlog"
  make_alias "lb"  "checkout -"
}

function make_alias() {
  `git config --global alias.$1 "$2"`
  info "Aliased 'git $1' to 'git $2'"
}

main
