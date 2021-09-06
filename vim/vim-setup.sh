#!/bin/bash

#
# vim installation && setup
#

# gitgutter
mkdir -p ~/.vim/pack/airblade/start
git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/pack/airblade/start/vim-gitgutter

# auto-pairs
mkdir -p ~/.vim/plugin/
git clone https://github.com/jiangmiao/auto-pairs.git
mv auto-pairs/plugin/auto-pairs.vim ~/.vim/plugin/
rm -rf auto-pairs/
# run :source % for this last command
vim ~/.vim/plugin/auto-pairs.git

# copy vimrc
cp ./vimrc ~/.vimrc
