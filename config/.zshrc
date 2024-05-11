ENV_FILE=~/.zsh/.environments.zsh
MAIN_FILE=~/.zsh/.main.zsh
PLUGINS_FILE=~/.zsh/.plugins.zsh
HISTORY_FILE=~/.zsh/.history.zsh
DEFAULT_EDITOR_FILE=~/.zsh/.default-editor.zsh
AUTOCOMPLETE_FILE=~/.zsh/.autocomplete.zsh
ZPLUG_FILE=~/.zsh/.zplug.zsh
ALIASES_FILE=~/.zsh/.aliases.zsh
MISC_FILE=~/.zsh/.misc.zsh

declare -a FILES=(
    "$ENV_FILE"
    "$MAIN_FILE"
    "$PLUGINS_FILE"
    "$HISTORY_FILE"
    "$DEFAULT_EDITOR_FILE"
    "$AUTOCOMPLETE_FILE"
    "$ZPLUG_FILE"
    "$ALIASES_FILE"
    "$MISC_FILE"
)

for file in "${FILES[@]}"; do
    if [ -e "$file" ]; then
        if [ -r "$file" ]; then
            source "$file"
        else
            echo "Error: $file is not readable."
        fi
    else
        echo "404: $file not found."
    fi
done
