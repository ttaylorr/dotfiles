#!/usr/bin/env bash
if [ -x "$(which ssh-add)" ]; then
  ssh-add &> /dev/null
fi
eval `ssh-agent`
