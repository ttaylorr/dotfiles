#!/bin/bash

function main() {
  install_vim

  cp ./assets/.vimrc ~/.vimrc
  success 'Copied over .vimrc!'
}

function install_vim() {
  info 'Installing vim...'
  `brew install vim`
  success 'Installed vim!'
}

function install_mvim() {
  info 'Installing mvim...'
  `brew install macvim`
  success 'Installed mvim!'
}


main
