#! /bin/bash


# install vim plug
 curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy the config files
cp init.vim ~/.config/nvim/init.vim
cp coc-settings.json ~/.config/nvim/coc-settings.json

nvim # start nvim to finish installation
