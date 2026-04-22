#!/bin/zsh
source $HOME/.bashrc

setopt PROMPT_SUBST

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
SAVEHIST=1000000
HISTSIZE=1000000

HISTFILE="$HOME/.zsh_history"

autoload -U colors && colors
autoload -Uz compinit && compinit # <- slow

bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '^[[Z' reverse-menu-complete

zstyle ':completion:*' menu select

fignore=(.o .gcda .gcov)

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
  local color=yellow
  test -n "$CODESPACES" && color=blue
  echo " [%{$fg[$color]%}$(hostname)%{$reset_color%}]"
}

parse_git_branch() {
  branch="$(git branch --show-current 2>/dev/null)"; test 0 -ne "$?" && return
  detached=
  rebasing=

  if test -z "$branch"; then
    branch="$(git rev-parse --short HEAD 2>/dev/null)"

    if test -d "$(git rev-parse --git-path rebase-merge 2>/dev/null)" ||
       test -d "$(git rev-parse --git-path rebase-apply 2>/dev/null)"
    then
      rebasing=t
    elif ! git symbolic-ref -q HEAD >/dev/null 2>&1
    then
      detached=t
    fi

    if test -z "$rebasing" && test -z "$detached"
    then
      return
    fi
  fi

  if test -n "$detached"; then
    branch="%{$fg[magenta]%}$branch"
  elif test -n "$rebasing"; then
    branch="%{$fg[red]%}$branch+"
  else
    branch="%{$fg[green]%}$branch"
  fi

  if test "false" = "$(git rev-parse --is-bare-repository)"
  then
    C="$(git rev-parse --show-toplevel 2>/dev/null)"
    if test -z "$C"
    then
      C="$(git -C .. rev-parse --show-toplevel 2>/dev/null)"
    fi

    if test "$HOME/github/github" != "$C" &&
       test -n "$(git -C "$C" status -s)"
    then
      branch="$branch%{$fg[red]%}!"
    fi
  fi

  echo " ($branch%{$reset_color%})"
}

export PS1='$(abbrev_path)$(on_host)$(parse_git_branch) $ '

test -n "$ALACRITTY_LOG" && printf "\e[?1042l"
