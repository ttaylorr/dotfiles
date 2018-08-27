#!/usr/bin/env bash

export GOPATH="$HOME/go"
export GPG_TTY="$(tty)"

export EDITOR="$(which vim)"
alias e="$EDITOR"

function d() {
  e $@ .
}

export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/Library/TeX/texbin"
export PATH="$PATH:/usr/local/sbin"

alias g=git
alias ls="ls -G"

if [ -x "$(which ssh-add)" ]; then
  ssh-add &> /dev/null
fi
