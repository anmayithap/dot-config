# Prompt initialization

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# End prompt initialization

# Zplug activation

if [[ ! -d ~/.zplug ]];then
        git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source $HOME/.zplug/init.zsh

# End Zplug activation

# Theme configuration

zplug romkatv/powerlevel10k, as:theme, depth:1

[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# End theme configuration

# Build hooks

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# End build hooks
