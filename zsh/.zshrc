#!/bin/zsh
source $HOME/.bash_profile

setopt PROMPT_SUBST

abbrev_path() {
  sed "s:\([^/]\)[^/]*/:\1/:g" <<<$(sed s:$HOME:\~:g <<<$PWD)
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='$fg[green]$(abbrev_path)$(parse_git_branch) $ '
