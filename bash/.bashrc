#!/usr/bin/env bash

export GPG_TTY="$(tty)"

export EDITOR="$(which vim)"
alias e="$EDITOR"

function d() {
  e $@ .
}

export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/Library/TeX/texbin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"

alias g=git
alias ls="ls -G"
alias vi=vim

if [ -x "$(which ssh-add)" ]; then
  ssh-add &> /dev/null
fi
