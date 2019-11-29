#! /bin/bash


# install vim plug
 curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy the config file
cp init.vim ~/.config/nvim/init.vim
nvim # start nvim to finish installation
