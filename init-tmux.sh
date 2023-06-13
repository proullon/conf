#!/bin/sh

old=`pwd`
cd

# tmux
ln -s $old/tmux.conf .tmux.conf
ln -s $old/tmux.conf.local .tmux.conf.local

