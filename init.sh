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
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s $old/tmux.conf .tmux.conf
ln -s $old/tmux.conf.local .tmux.conf.local

# alacritty
ln -s $old/alacritty ~/.config/alacritty

# zathura
ln -s $old/zathura ~/.config/zathura

# mpd
ln -s $old/mpd ~/.config/mpd
ln -s $old/pms ~/.config/pms
ln -s $old/beets ~/.config/beets

# cmus
ln -s $old/cmus/rc ~/.config/cmus/rc
ln -s $old/cmus/rose-pine.theme ~/.config/cmus/rose-pine.theme
