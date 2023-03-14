#!/bin/sh

old=`pwd`
cd

# Bash
ln -s $old/bashrc .bashrc
ln -s $old/bash_aliases .bash_aliases
ln -s $old/bash_profile .bash_profile
# Nushell
ln -s $old/nushell .config/.
# Git
ln -s $old/git-prompt.sh .git-prompt.sh
ln -s $old/gitconfig .gitconfig
# WM
ln -s $old/ion3 .notion
ln -s $old/awesome ~/.config/awesome
ln -s $old/i3 .i3
# vim
ln -s $old/vim .vim
ln -s $old/vimrc .vimrc
mkdir -p .config/nvim
ln -s $old/init.vim .config/nvim/init.vim

# tmux
ln -s $old/tmux.conf .tmux.conf
ln -s $old/tmux.conf.local .tmux.conf.local

