#!/bin/bash

set -eEu
set -o pipefail

# os codes
DEBIAN=100
FEDORA=200

# determine os
function determine_os() {
    
    # check if system supports uname
    if command uname > /dev/null; then
        sysinfo="$(uname -a)"
    else
        printf "`uname` not enabled on system\n"
        exit 1
    fi

    # check if linux
    if [[ "$sysinfo" =~ "Linux" ]]; then
        
        # determine Linux distro
        if [[ "$sysinfo" =~ "Debian" ]] || [[ "$sysinfo" =~ "Ubuntu" ]]; then

            ostype=$DEBIAN
            echo $ostype

        elif [[ "$sysinfo" =~ "Fedora" ]] || [[ "$sysinfo" =~ "CentOS" ]]; then
        
            ostype=$FEDORA
            echo $ostype
        else
            printf "[-] Sorry, this script is only for Linux distros!"
            exit 1
        fi
    fi
}

function add_gpg_key() {

    # add Docker's official GPG key
    printf "[*] Adding official docker GPG key\n"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
}


function install() {
    
    # pass argv[1] as os type
    systype=$1

    if [[ "$systype" == "$DEBIAN" ]]; then
        printf "[+] OS: Linux, Distribution: Debian-based\n\n"        
        
        # set up stable repo
        printf "[*] Setting up stable repo...\n"
        echo "deb [arch=$(dpkg --print-architecture) \
            signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
            https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
            | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        # update the package index
        printf "[*] Updating the package index...\n"
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    elif [[ "$systype" == "Fedora" ]]; then
        printf "[+] OS: Linux, Distribution: Fedora-based\n\n"        
   
        # install dnf-plugins-core
        printf "[*] Installing `dnf-plugins-core`\n"
        sudo dnf -y install dnf-plugins-core
        
        # set up stable repository
        printf "[*] Setting up stable repo...\n"
        sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
        
        # install docker engine
        printf "[*] Installing Docker Engine...\n"
        sudo dnf install -y docker-ce docker-ce-cli containerd.io
    else
        printf "[-] An unexpected error occurred\n"
        printf "DEBUG: os type - $systype"
        exit 1
    fi
}

# determine os
os=$(determine_os)

# run the install function
add_gpg_key
install $os

