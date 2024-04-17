#!/bin/bash
echo "Lets setting up zsh..."

MARK="AnmayithapZSHRC"

function install_zsh() {
    if [[ -f /usr/bin/yum ]]; then
        sudo yum install zsh -y
    elif [[ -f /usr/bin/dnf ]]; then
        sudo dnf install zsh -y
    elif [[ -f /usr/bin/apt ]]; then
        sudo apt-get install zsh -y
    fi
}

function in_docker_install_zsh() {
    if [[ -f /usr/bin/yum ]]; then
        yum install zsh -y
    elif [[ -f /usr/bin/dnf ]]; then
        dnf install zsh -y
    elif [[ -f /usr/bin/apt ]]; then
        apt-get install zsh -y
    fi
}

if [[ ! -f /usr/bin/zsh ]]; then
    echo "ZSH is not installed. Lets try install..."
    if ! type sudo > /dev/null; then
        in_docker_install_zsh
    else
        install_zsh
    fi
fi

if [[ ! $SHELL == "/usr/bin/zsh" ]]; then
    echo "Changing shell to zsh..."
    chsh -s $(which zsh)
fi

if [[ -f ~/.zshrc ]]; then
    if grep -q $MARK ~/.zshrc; then
        while true; do
            read -p "ZSHRC already installed, re-install? [Y/n] " yn
            case $yn in
                [Yy]* ) break;;
                [Nn]* ) exit 0;;
                * ) echo "Please answer Y or N.";;
            esac
        done
    fi
fi

echo "ZSHRC not installed. installing..."
cp ./configs/.zshrc ~/.zshrc
echo "Done. Please restart your terminal to apply changes and run main.sh again"
exit 1
