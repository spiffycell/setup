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
pip3 install -r requirements.txt

# install snaps
#snap install code
snap install spotify

# special packages

# oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# gef -- gdb enhanced framework
sh -c "$(wget http://gef.blah.cat/sh -O -)"

# mitra -- polyglot file creation
if [[ -d "/opt/mitra" ]]; then
    echo "/opt/mitra: already exists"
    continue
else
    sudo git clone https://github.com/corkami/mitra /opt/mitra
fi

# ghidra -- reverse engineering
wget -O /opt/ghidra.zip https://ghidra-sre.org/ghidra_9.2_PUBLIC_20201113.zip
unzip /opt/ghidra.zip -d /opt/
rm /opt/ghidra.zip

# clone and copy bin repo contents into /usr/local/bin
git clone git@github.com:sp1ffyc3ll/bin.git ..
sudo cp -r ../bin/local-bins/* /usr/local/bin/

# clone dotfiles/configs
# use GNU stow to link dotfiles
git clone git@github.com:sp1ffyc3ll/dotfiles.git ..

PACKAGES=$(ls ../dotfiles | awk -F ' ' $0)

read -t array <<<$PACKAGES

for i in ${array[@]};
do
	stow $i
done

#
# recon tools
#

(cd /opt/; sudo git clone https://github.com/laramies/metagoofil)
(cd /opt/; sudo git clone https://github.com/leapsecurity/InSpy)

#
# vim installation && setup
#

./vim/vim-setup.sh

#
# tmux setup
#

cp tmux/tmux.conf ~/.tmux.conf
