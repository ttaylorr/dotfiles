export GOPATH=$HOME/dev/go

export EDITOR="$(which vim)"
alias e="$EDITOR"

d() { e $@ . }

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.rvm/bin:/Library/TeX/texbin"
export PATH="$PATH:/usr/local/sbin"

alias g=git
alias ls="ls -G"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
