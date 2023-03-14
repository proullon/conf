#!/bin/sh

apt-get update
apt-get upgrade -y
apt-get install nvim cmake gettext latexmk python3 python3-pip
python3 -m pip install --user --upgrade pynvim
curl -fLo ~/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~/work/src; mkdir -p github.com/neovim; cd github.com/neovim; git clone git@github.com:neovim/neovim.git; cd neovim; make CMAKE_BUILD_TYPE=RelWithDebInfo; sudo make install
nvim -v
