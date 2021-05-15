#!/bin/bash

#
# vim installation && setup
#

# nerdtree
mkdir -p ~/.vim/pack/vendor/start
git clone --depth 1 https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree

# gitgutter
mkdir -p ~/.vim/pack/airblade/start
git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/pack/airblade/start/vim-gitgutter

# gruvbox theme
mkdir -p ~/.vim/pack/default/start
git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox

# auto-pairs
mkdir -p ~/.vim/plugin/
git clone https://github.com/jiangmiao/auto-pairs.git
mv auto-pairs/plugin/auto-pairs.vim ~/.vim/plugin/
rm -rf auto-pairs/
# run :source % for this last command
vim ~/.vim/plugin/auto-pairs.git

# synthwave theme
git clone https://github.com/yanlobkarev/synthwave.vim.git
mv synthwave.vim/colors/synthwave.vim ~/.vim/colors/
rm -rf synthwave.vim/

# copy vimrc
cp ./vimrc ~/.vimrc
