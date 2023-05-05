#!/bin/sh

sudo apt-get update
sudo apt-get upgrade -y
# latex
sudo apt-get install net-tools tmux libssl-dev pkg-config curl htop cmake gettext latexmk texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
# python
sudo apt-get install python3 python3-pip
python3 -m pip install --user --upgrade pynvim
# rust
curl https://sh.rustup.rs -sSf | sh
# oh-my-posh
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-`uname -m` -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip
# neovim
curl -fLo ~/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd ~/work/src; mkdir -p github.com/neovim; cd github.com/neovim; git clone git@github.com:neovim/neovim.git; cd neovim; make CMAKE_BUILD_TYPE=RelWithDebInfo; sudo make install
nvim -v
# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
