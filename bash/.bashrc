#!/usr/bin/env bash

function manage_gpg_agent () {
  export GPG_TTY="$(tty)"

  if test "$SSH_AUTH_SOCK" = "/tmp/*"; then
    # Assume hosts with $SSH_AUTH_SOCK pointed at something in '/tmp'
    # know what they are doing, and don't manage their ssh-agent for
    # them.
    return
  fi

  if test -x "$(which gpg-agent)"; then
    eval $(gpg-agent --daemon -q 2>/dev/null)
    export GPG_AGENT_INFO="$(gpgconf --list-dirs agent-socket):0:1"
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  fi
}
manage_gpg_agent

function reset_gpg_tty () {
  if ! test -x "$(which gpg-connect-agent)"; then
    echo >&2 "error: gpg-connect-agent is not executable!"
    return
  fi
  echo "UPDATESTARTUPTTY" | gpg-connect-agent
}

export EDITOR="$(which vim)"
alias e="$EDITOR"

function d() {
  e $@ .
}

export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/Library/TeX/texbin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.bin:$PATH"

alias g=git
alias ls="ls -G"
alias grep="grep --color"
alias vi=vim
