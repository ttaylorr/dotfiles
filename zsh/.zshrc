#!/bin/zsh
source $HOME/.bashrc

setopt PROMPT_SUBST

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
SAVEHIST=1000000
HISTSIZE=1000000

if test -z "$HISTFILE"
then
  HISTFILE="$HOME/.zsh_history"
fi

if ! test -f "$HISTFILE"
then
  echo >&2 "NOTE: \$HISTFILE does not exist, creating it ..."

  mkdir -p "$(dirname "$HISTFILE")"
  touch $HISTFILE
fi


autoload -U colors && colors
autoload -Uz compinit && compinit

bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
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

on_host() {
  echo " [%{$fg[yellow]%}$(hostname)%{$reset_color%}]"
}

parse_git_branch() {
  branch="$(git branch 2>/dev/null | grep "*")"
  detached="$(echo "$branch" | grep -E "detached|no branch")"
  rebasing="$(echo "$branch" | grep "no branch, rebasing")"

  if [[ ! -z "$detached" ]] || [[ ! -z "$rebasing" ]]; then
    branch="$(git rev-parse --short HEAD)"
  else
    branch="$(echo "$branch" | awk '{ print $2 }')"
  fi

  if [[ -z "$branch" ]]; then
    return
  fi

  if [[ ! -z "$detached" ]]; then
    branch="%{$fg[red]%}$branch"
  elif [[ ! -z "$rebasing" ]]; then
    branch="%{$fg[red]%}$branch!"
  else
    branch="%{$fg[green]%}$branch"
  fi

  if test "false" = "$(git rev-parse --is-bare-repository)" &&
    test "$HOME/github/github" != "$(git rev-parse --show-toplevel)" &&
    test -n "$(git status -s)"; then
      branch="$branch%{$fg[red]%}!"
  fi

  echo " ($branch%{$reset_color%})"
}

export PS1='$(abbrev_path)$(on_host)$(parse_git_branch) $ '

test -n "$ALACRITTY_LOG" && printf "\e[?1042l"

export SHELL="$(which zsh)"
