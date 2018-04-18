#!/bin/zsh
source $HOME/.bash_profile
source $HOME/.bashrc
source $HOME/.opam_init

setopt PROMPT_SUBST

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
SAVEHIST=1000000
HISTSIZE=1000000

if [[ -z "$HISTFILE" ]]; then
  HISTFILE="$HOME/.zsh_history"
fi

if [[ ! -f "$HISTFILE" ]]; then
  echo >&2 "NOTE: \$HISTFILE does not exist, creating it ..."

  mkdir -p "$(dirname "$HISTFILE")"
  touch $HISTFILE
fi


autoload -U colors && colors
autoload -Uz compinit && compinit

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Enable shift-tab reverse-menu-complete
# XXX(@ttaylorr) is '^[[Z' portable?
bindkey '^[[Z' reverse-menu-complete

zstyle ':completion:*' menu select

# Enable history-inc-pattern search in vi-mode
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^P" vi-up-line-or-history
bindkey "^N" vi-down-line-or-history

# Bind backspace to delete keys outside of last insert operation.
bindkey '^?' backward-delete-char

abbrev_path() {
  sed "s:\([^/]\)[^/]*/:\1/:g" <<<$(sed s:$HOME:\~:g <<<$PWD)
}

parse_git_branch() {
  branch="$(git branch 2>/dev/null | grep "*")"
  detached="$(echo "$branch" | grep "detached at")"
  rebasing="$(echo "$branch" | grep "no branch, rebasing")"

  if [[ ! -z "$detached" ]] || [[ ! -z "$rebasing" ]]; then
    branch="$(echo "$branch" | tr -d '()' | awk '{ print $5 }')"
  else
    branch="$(echo "$branch" | awk '{ print $2 }')"
  fi

  if [[ -z "$branch" ]]; then
    return
  fi

  if [[ ! -z "$detached" ]]; then
    branch="%{$fg[red]%}$branch"
  elif [[ ! -z "$rebasing" ]]; then
    branch="%{$fg[red]%}~$branch"
  else
    branch="%{$fg[green]%}$branch"
  fi

  if ! [[ -z "$(git status -s)" ]]; then
    branch="$branch%{$fg[red]%}!"
  fi

  echo " ($branch%{$reset_color%})"
}

function exec_after_prompt() {
  set -e

  exec 1>/dev/null
  exec 2>/dev/null

  if ! [[ -z $TMUX ]]; then
    local pane_count="$(tmux list-panes | wc -l | awk '{ print $1 }')"
    if [[ $pane_count -gt 1 ]]; then
      exit 0
    fi

    local pane_id="${TMUX_PANE}"
    local dir="$PWD"

    if [ "$HOME" = "$dir" ]; then
      local window_title="~"
    else
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if ! [ -z "$git_root" ]; then
        dir="$git_root"
      fi

      local window_title="$(basename $dir)"
    fi

    tmux rename-window -t "$pane_id" "$window_title"
  fi
}

export PS1='$(abbrev_path)$(parse_git_branch) $ $(exec_after_prompt)'
