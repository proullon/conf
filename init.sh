#!/bin/sh

old=`pwd`
cd

ln -s $old/bash_aliases .bash_aliases
ln -s $old/bash_profile .bash_profile
ln -s $old/git-prompt.sh .git-prompt.sh
ln -s $old/gitconfig .gitconfig
ln -s $old/ion3 .notion
ln -s $old/awesome ~/.config/awesome

ln -s $old/vim .vim
ln -s $old/vimrc .vimrc
ln -s $old/i3 .i3

ln -s $old/bashrc .bashrc
ln -s $old/tmux.conf .tmux.conf
ln -s $old/tmux.conf.local .tmux.conf.local


