#!/bin/bash

# Source the user's .bashrc, if available
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Make the current git bash available in the prompt 
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Source RVM, so everything works normally
source ~/.rvm/scripts/rvm
