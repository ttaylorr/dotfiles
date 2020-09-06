#!/usr/bin/env bash

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
    export GPG_AGENT_INFO="$(gpgconf --list-dirs agent-socket):0:1"
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  fi
}
manage_gpg_agent

export EDITOR="$(which vim)"

export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/Library/TeX/texbin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.bin:$PATH"

alias g=git
if test "Linux" = "$(uname -s)"
then
  alias ls="ls --color"
else
  alias ls="ls -G"
fi
alias grep="grep --color"
alias vi=vim
