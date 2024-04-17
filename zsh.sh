#!/bin/bash

echo "Lets setting up zsh..."

MARK="AnmayithapZSHRC"

if [[ ! -f /usr/bin/zsh ]]; then
    echo "ZSH is not installed. Lets try install..."
    
    eval "$SUDO $PACKAGE_MANAGER install zsh -y"
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

./packages.sh

echo "ZSHRC not installed. installing..."

echo "\
export TERM="xterm-256color"
export ZPLUG_HOME=$HOME/.zplug
export PIPX_HOME=$HOME/.pipx
export PIPX_BIN_DIR=$PIPX_HOME/bin
export PIPX_MAN_DIR=$PIPX_HOME/man
export POETRY_HOME=$HOME/.pypoetry
export POETRY_CONFIG_DIR=$POETRY_HOME
export POETRY_CACHE_DIR=$POETRY_HOME
export POETRY_VIRTUALENVS_PATH=$POETRY_HOME/.virtualenvs
export PYENV_ROOT=$HOME/.pyenv
export GOENV_ROOT=$HOME/.goenv
" >> ~/.zshrc

echo "Done. Please restart your terminal to apply changes and run main.sh again"

cat ~/.zshrc

exit 1
