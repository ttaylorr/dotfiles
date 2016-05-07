#!/bin/zsh
source $HOME/.bash_profile

setopt PROMPT_SUBST
autoload -U colors && colors

abbrev_path() {
  sed "s:\([^/]\)[^/]*/:\1/:g" <<<$(sed s:$HOME:\~:g <<<$PWD)
}

parse_git_branch() {
  branch="$(git branch 2>/dev/null | grep '*' | cut -d ' ' -f 2)"
  if [[ -z "$branch" ]]; then
    return
  else
    branch="$fg[green]$branch"
  fi

  if ! [[ -z "$(git status -s)" ]]; then
    branch="$branch$fg[red]!"
  fi

  echo " ($branch$reset_color)"
}

export PS1='$(abbrev_path)$(parse_git_branch) %{$ %}'
