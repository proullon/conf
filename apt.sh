#!/bin/sh

apt-get update
apt-get upgrde -y
apt-get install nvim cmake gettext latexmk
cd ~/work/src; mkdir -p github.com/neovim; cd github.com/neovim; git clone git@github.com:neovim/neovim.git; cd neovim; make CMAKE_BUILD_TYPE=RelWithDebInfo; make install
nvim -v
