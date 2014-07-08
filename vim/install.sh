#!/bin/bash

function main() {
  cp ./assets/.vimrc ~/.vimrc
  success 'Copied over .vimrc!'
}

main
