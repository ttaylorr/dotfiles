#!/bin/zsh
source $HOME/.bash_profile

setopt PROMPT_SUBST

autoload -U colors && colors
autoload -Uz compinit && compinit

# Enable shift-tab reverse-menu-complete
# XXX(@ttaylorr) is '^[[Z' portable?
bindkey '^[[Z' reverse-menu-complete

zstyle ':completion:*' menu select

# Enable history-inc-pattern search in vi-mode
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^P" vi-up-line-or-history
bindkey "^N" vi-down-line-or-history

abbrev_path() {
  sed "s:\([^/]\)[^/]*/:\1/:g" <<<$(sed s:$HOME:\~:g <<<$PWD)
}

parse_git_branch() {
  branch="$(git branch 2>/dev/null | grep "*")"
  detached="$(echo "$branch" | grep "detached at")"

  if [[ ! -z "$detached" ]]; then
    branch="$(echo "$branch" | tr -d '()' | awk '{ print $5 }')"
  else
    branch="$(echo "$branch" | awk '{ print $2 }')"
  fi

  if [[ -z "$branch" ]]; then
    return
  else
    branch="%{$fg[green]%}$branch"
  fi

  if ! [[ -z "$(git status -s)" ]]; then
    branch="$branch%{$fg[red]%}!"
  fi

  echo " ($branch%{$reset_color%})"
}

export PS1='$(abbrev_path)$(parse_git_branch) $ '
