#!/bin/bash

echo "\
  _      __    __                     __         ___  ____  ______    _________  _  _________________
 | | /| / /__ / /______  __ _  ___   / /____    / _ \/ __ \/_  __/___/ ___/ __ \/ |/ / __/  _/ ___/ /
 | |/ |/ / -_) / __/ _ \/  ' \/ -_) / __/ _ \  / // / /_/ / / / /___/ /__/ /_/ /    / _/_/ // (_ /_/
 |__/|__/\__/_/\__/\___/_/_/_/\__/  \__/\___/ /____/\____/ /_/      \___/\____/_/|_/_/ /___/\___(_)

"

SUDO=""
PACKAGE_MANAGER=""

if [[ $(uname -s) != "Linux" ]]; then
    echo "Not supported OS: $(uname -s)"
    exit 1
fi

function set_package_manager() {
    if [[ -f /usr/bin/yum ]]; then
        PACKAGE_MANAGER="yum"
    elif [[ -f /usr/bin/dnf ]]; then
        PACKAGE_MANAGER="dnf"
    elif [[ -f /usr/bin/apt ]]; then
        PACKAGE_MANAGER="apt-get"
    fi
}

function set_sudo() {
    if type sudo > /dev/null; then
        SUDO="sudo"
    fi
}

set_sudo
set_package_manager

export SUDO
export PACKAGE_MANAGER

# Installing or prepare zsh config
./zsh.sh

# check zsh.sh status. 0 - ok, 1 - need restart
if [[ $? -eq 1 ]]; then
    exit 0
fi
