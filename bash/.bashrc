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
    export GPG_AGENT_INFO="$(gpgconf --list-dirs agent-socket 2>/dev/null):0:1"
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)"
  fi
}
manage_gpg_agent

export EDITOR="$(which vim)"

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/go/bin"
if test -d "/Library/TeX"; then
  export PATH="$PATH:/Library/TeX/texbin"
fi
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/local/git/current/bin:$PATH"
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

for exe in mutt newsboat weechat
do
  if test -x "$(which $exe)"
  then
    alias $exe="TERM=screen-256color $(which $exe)"
  fi
done
alias news=newsboat

alias mgit="mutt -e 'push \"<limit>~y git.git<enter>\"'"
alias mgh="mutt -e 'push \"<limit>!~y git.git<enter>\"'"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if test "Linux" = "$(uname -s)"
then
  alias make="make -j$(lscpu | grep '^CPU(s):' | awk '{print $2}')"
else
  alias make="make -j$(sysctl -n hw.ncpu)"
fi
