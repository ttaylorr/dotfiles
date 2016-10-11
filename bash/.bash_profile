export GOPATH="$HOME/dev/go"
export GPG_TTY="$(tty)"

export EDITOR="$(which vim)"
alias e="$EDITOR"

function d() {
  e $@ .
}

export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.rvm/bin:/Library/TeX/texbin"
export PATH="$PATH:/usr/local/sbin"

alias g=git
alias ls="ls -G"

# macOS Sierra does not auto-load your `ssh-agent` like all previous versions of
# OS X.
if [ -x "$(which ssh-add)" ]; then
  ssh-add -A &> /dev/null
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
