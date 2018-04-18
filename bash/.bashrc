#!/usr/bin/env bash

export GOPATH="$HOME/go"
export GPG_TTY="$(tty)"

export EDITOR="$(which vim)"
alias e="$EDITOR"

function d() {
  e $@ .
}

export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:./bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.rvm/bin:/Library/TeX/texbin"
export PATH="$PATH:/usr/local/sbin"

if [ -d "$HOME/.multirust" ]; then
  export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
fi

alias g=git
alias ls="ls -G"
