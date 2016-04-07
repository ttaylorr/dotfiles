#!/bin/zsh
source $HOME/.bash_profile

setopt PROMPT_SUBST

abbrev_path() {
  sed "s:\([^/]\)[^/]*/:\1/:g" <<<$(sed s:$HOME:\~:g <<<$PWD)
}

parse_git_branch() {
  branch="$(git branch 2>/dev/null | grep '*' | cut -d ' ' -f 2)"
  if [[ -z "$branch" ]]; then
    return
  fi

  if ! [[ -z "$(git status -s)" ]]; then
    branch="$branch!"
  fi

  echo " ($branch)"
}

export PS1='$fg[green]$(abbrev_path)$(parse_git_branch) $ '
