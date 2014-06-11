#!/bin/bash

function main() {
  write_alias "g" "git"
}

function write_alias() {
  echo "alias $1='$2'" > ./tmp/.bashrc
}

main
