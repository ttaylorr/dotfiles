#!/bin/zsh
export GOPATH=/Users/ttaylorr/dev/go/

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

eval "$(pyenv init -)"

export PATH="$PATH:/Users/ttaylorr/dev/go/bin/"

alias g=git
alias ls="ls -G"

setopt PROMPT_SUBST

abbrev_path() {
  sed "s:\([^/]\)[^/]*/:\1/:g" <<<$(sed s:$HOME:\~:g <<<$PWD)
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='$fg[green]$(abbrev_path)$(parse_git_branch) $ '
