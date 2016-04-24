export GOPATH=/Users/ttaylorr/dev/go/

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

eval "$(pyenv init -)"

export PATH="$PATH:/Users/ttaylorr/dev/go/bin/:$HOME/.rvm/bin"

alias g=git
alias ls="ls -G"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
