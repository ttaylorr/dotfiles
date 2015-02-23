#!/bin/bash

function main() {
  install_vim
  install_vim_plug

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

function install_vim_plug() {
  if [ ! -a "~/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  success "Installed vim-plug from (https://github.com/junegunn/vim-plug)"
}

main
