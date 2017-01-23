export GOPATH="$HOME/go"
export GPG_TTY="$(tty)"

export EDITOR="$(which vim)"
alias e="$EDITOR"

function d() {
  e $@ .
}

export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:./bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.rvm/bin:/Library/TeX/texbin"
export PATH="$PATH:/usr/local/sbin"

if [ -d "$HOME/.multirust" ]; then
  export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
fi

alias g=git
alias ls="ls -G"

tmux-status-right() {
  local battery="$(
    pmset -g batt \
      | tail -1 \
      | sed 's/;/ /g' \
      | awk '{print $2 " (" $3 ")"}'
  )";

  echo "$battery";
}

# macOS Sierra does not auto-load your `ssh-agent` like all previous versions of
# OS X.
if [ -x "$(which ssh-add)" ]; then
  ssh-add &> /dev/null
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
