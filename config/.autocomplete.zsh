# Autocomplete configuration

zstyle :compinstall filename '/home/$USER/.zshrc'

fpath+=~/.zfunc

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

# End autocomplete configuration
