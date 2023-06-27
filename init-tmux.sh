#!/bin/sh

old=`pwd`
cd

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s $old/tmux.conf .tmux.conf
ln -s $old/tmux.conf.local .tmux.conf.local

