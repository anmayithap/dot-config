# pipx

export PATH="$PATH:$PIPX_BIN_DIR"

eval "$(register-python-argcomplete pipx)"

# pyenv

export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"

# goenv

export PATH="$GOENV_ROOT/bin:$PATH"

eval "$(goenv init -)"

export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
