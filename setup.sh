#!/bin/bash

# initial opts
set -eEu
set -o pipefail

# enable debug
# set -x


# install ubuntu packages
echo '[*] Installing Ubuntu Packages'
sudo apt-get install -y $(awk '{print $1}' packages.list)

# pip install requirements
echo "[*] Installing Pip3 Packages"
#pip3 install -r requirements.txt

# install snaps
#snap install code
snap install spotify
snap install xmind
snap install pre-commit --classic

# special packages

# clone and copy bin repo contents into /usr/local/bin
git clone git@github.com:spiffycell/bin.git
sudo cp -r bin/local-bins/* /usr/local/bin/
rm -rf bin

#
# vim setup
#
cp vim/vimrc ~/.vim/vimrc

#
# tmux setup
#
cp tmux/tmux.conf ~/.tmux.conf

#
# add zsh as default, and alias vim to nvim
#
echo 'exec zsh' >> ~/.bashrc
echo 'alias vim="nvim"' >> ~/.zshrc

# oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

