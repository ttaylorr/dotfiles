#!/bin/bash

LOCAL_BIN_PATH=$HOME/.bin/

function main() {
  if [ ! -d "$LOCAL_BIN_PATH" ]; then
    create_local_bin_folder;
  fi
  place_in_path;

  for file in `ls`; do
    if [ $file != "install.sh" ];
    then
      cp $file $LOCAL_BIN_PATH
    fi
  done
}

function create_local_bin_folder() {
  mkdir "$LOCAL_BIN_PATH"
}

function place_in_path() {
  export PATH="$PATH:$LOCAL_BIN_PATH"
}

main
