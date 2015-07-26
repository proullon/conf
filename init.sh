#!/bin/sh

old=`pwd`
cd

ln -s $old/bash_aliases .bash_aliases
ln -s $old/bash_profile .bash_profile
ln -s $old/gitconfig .gitconfig
ln -s $old/ion3 .notion
ln -s $old/awesome ~/.config/awesome

ln -s $old/vim .vim
ln -s $old/vimrc .vimrc


echo "if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi
" >> .bashrc

cd $old
