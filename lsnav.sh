open_ls() {
    # Use eza (or ls) for listing files and folders
    local selected=$(eza -1 --icons | fzf --height=40% --border --prompt="Select a file or folder: ")

    # Strip enclosing single quotes if present
    selected=$(echo "$selected" | sed "s/^'//;s/'$//")

    # Check if selection is valid
    if [ -n "$selected" ]; then
        if [ -d "$selected" ]; then
            # Navigate into the directory
            cd "$selected" || echo "Failed to navigate to '$selected'"
            echo "You are now in: $(pwd)"
            eza -1 --icons  # Optionally list the contents
        elif [ -f "$selected" ]; then
            # Open the file in nvim
            nvim "$selected"
        else
            echo "Error: '$selected' is neither a file nor a folder."
        fi
    else
        echo "No selection made."
    fi
}
alias lsnav='open_ls'
