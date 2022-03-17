#!/bin/bash

# initial opts
set -eEu
set -o pipefail

# enable debug
# set -x


# install ubuntu packages
echo '[*] Installing Ubuntu Packages'
sudo apt-get install -y $(awk '{print $1}' packages.list)

# move zshrc
cp zshrc ~/.zshrc

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install \
docker-ce \
docker-ce-cli \
containerd.io

# update packages
sudo apt autoremove

# adjust docker group membership
sudo usermod -aG docker $(whoami)

# pip install requirements
echo "[*] Installing Pip3 Packages"
pip3 install -r requirements.txt
pip3 install --upgrade pip
pip install --upgrade pip

# install snaps
#snap install code
snap install spotify
snap install xmind

# special packages
# clone and copy bin repo contents into /usr/local/bin
git clone git@github.com:spiffycell/bin.git
sudo cp -r bin/local-bins/* /usr/local/bin/
rm -rf bin

#
# vim setup
#
cp vim/vimrc $HOME/.vim/vimrc
mkdir -p $HOME/.config/nvim; ln -s $HOME/.vim/vimrc $HOME/.config/nvim/init.vim

#
# tmux setup
#
cp tmux/tmux.conf ~/.tmux.conf

#
# vim-plug
#
sh -c 'curl -fLo /home/spiffycell/.local/share/nvim/site/autoload/plug.vim --create-dirs        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#
# add zsh as default, and alias vim to nvim
#
echo 'exec zsh' >> ~/.bashrc
echo 'alias vim="nvim"' >> ~/.zshrc

# oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir -p ~/.config/nvim; ln -s ~/.vimrc ~/.config/nvim/init.vim
