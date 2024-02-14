#!/usr/bin/env bash

test -d /opt/homebrew/bin && eval $(/opt/homebrew/bin/brew shellenv)

test -d "$HOME/cargo" && source "$HOME/cargo/env"

function manage_gpg_agent () {
  export GPG_TTY="$(tty)"

  if echo "$SSH_AUTH_SOCK" | grep -q "^/tmp/"; then
    # Assume hosts with $SSH_AUTH_SOCK pointed at something in '/tmp'
    # know what they are doing, and don't manage their ssh-agent for
    # them.
    return
  fi

  if test -x "$(which gpg-agent)"; then
    eval $(gpg-agent --daemon -q 2>/dev/null)
    export GPG_AGENT_INFO="$(gpgconf --list-dirs agent-socket 2>/dev/null):0:1"
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)"
  fi
}
manage_gpg_agent

export EDITOR="$(which vim)"

export LANG=en_US.UTF-8

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/local/git/current/bin:$PATH"
export PATH="$HOME/.bin:$PATH"

alias g=git
alias ls="ls --color=auto"
alias grep="grep --color"
alias vi=vim

alias mutt="TERM=screen-256color mutt"
alias weechat="TERM=screen-256color weechat"

function mgit () {
  local limit="~U"

  while test "$#" -gt 0
  do
    case "$1" in
      --today|-1)
        limit="$limit ~d <1d"
        shift
        ;;
    esac
  done

  mutt -F ~/.mutt/gitml -f ~/Mail/lei-q-git/ -e "push '<limit>$limit<enter>'"
}

alias mgh="mutt -e 'push \"<limit>!~y git.git<enter>\"'"
alias mtt="mutt -e 'source $HOME/.mutt/account/ttaylorr.com'"
alias mtoday="mgit --today"

alias maintlog='vi $(find ~/notes/maintlog -type f | sort -rn | head -1)'
alias ml="maintlog"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias make="make -j$(getconf _NPROCESSORS_ONLN)"
alias mkae="make"
