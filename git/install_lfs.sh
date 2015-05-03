#!/bin/bash

function main() {
  install_location='./tmp';
  artifact_id='git-lfs-darwin-386-0.5.1';
  artifact_tag='0.5.1';

  $(git lfs &> /dev/null);
  if [ $? -ne 0 ]; then
    make_tmp_dir $install_location;

    download_lfs_extension $install_location;
    unpack_lfs_extension $install_location;

    ext_to_bin $install_location;

    destroy_tmp_dir $install_location;

    git lfs init;
  fi
}

function make_tmp_dir() {
  mkdir -p "$1";
}

function download_lfs_extension() {
  wget -O "$1/$artifact_id.tar.gz" "https://github.com/github/git-lfs/releases/download/v$artifact_tag/$artifact_id.tar.gz" &> /dev/null
}

function unpack_lfs_extension() {
  tar xvf "$1/$artifact_id.tar.gz" -C $1 &> /dev/null
}

function ext_to_bin() {
  cp "$1/git-lfs-$artifact_tag/git-lfs" /usr/local/bin
}

function destroy_tmp_dir() {
  rm -rf "$1"
}

main;
