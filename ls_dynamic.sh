# ############################################################################ #
#                                  ls_open BEGIN                               #
# ############################################################################ #
# ⚠ Dependencies: eza, fzf, sed                                                #
# ---------------------------------------------------------------------------- #
#   From current directory; opens up a list of all folders available for      #
# navigation.                                                                  #
# ---------------------------------------------------------------------------- #
# ############################################################################ #

# aliases
alias lsnav='open_ls'
alias nav='open_ls'
alias open='open_ls'
alias opendir='open_ls'
alias dopen='open_ls'
alias diropen='open_ls'

# Function to handle selecting and opening files or directories
open_ls() {
    # List only directories in the current directory using eza’s --only-dirs flag
    local selected=$(eza -1 --icons --only-dirs | fzf --height=40% --border --prompt="Select a directory: ")

    # Remove any surrounding single quotes (if they exist)
    selected=$(echo "$selected" | sed "s/^'//;s/'$//")

    # Check if a selection was made
    if [ -n "$selected" ]; then
        # The cd command with "$selected" automatically handles names with spaces.
        cd "$selected" || { echo "Failed to navigate to '$selected'"; return 1; }
        echo "You are now in: $(pwd)"
        # Optionally list the directories in the new location
        eza -1 --icons --only-dirs
    else
        echo "No selection made."
    fi
}


# ############################################################################ #
#                                  ls_open END                                 #
# ############################################################################ #
