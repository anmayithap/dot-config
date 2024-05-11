# Aliases
alias ls="lsd --color=auto"
alias up="sudo dnf upgrade --refresh --best --allowerasing -y && flatpak update -y && zplug update && pyenv update"
alias cc="sudo dnf autoremove && dnf clean all && flatpak uninstall --unused -y && flatpak remove --delete-data && sudo journalctl --vacuum-time=1weeks && zplug clean"
alias zshrc="vim ~/.zshrc"
alias ~="cd ~"
alias dev="cd ~/dev"
alias job="cd ~/dev/job"
# End aliases
