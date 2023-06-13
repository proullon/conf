#!/bin/sh

old=`pwd`
cd

# vim
ln -s $old/vim .vim
ln -s $old/vimrc .vimrc
mkdir -p .config/nvim
ln -s $old/init.vim .config/nvim/init.vim
