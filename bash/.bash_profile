export GOPATH=$HOME/dev/go

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export PATH="$PATH:$GOPATH/bin:$HOME/.rvm/bin"

alias g=git
alias ls="ls -G"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
