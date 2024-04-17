#!/bin/bash

eval "$SUDO $PACKAGE_MANAGER install lsd"

curl https://pyenv.run | bash

git clone https://github.com/go-nv/goenv.git ~/.goenv
