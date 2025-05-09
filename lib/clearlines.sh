#!/bin/bash

# ==================================================================
# Function: clearlines
# ==================================================================
# Description:
#   Clear a specified number of lines from the terminal.
#
# Arguments:
#   lines: The number of lines to clear (default is 1).
#
# Examples:
#   clearlines 5
#   clearlines 10
#
# =================================================================

clearlines() {
    local lines=${1:-1}  # Default to 1 line if no argument provided
    
    if [[ $lines -lt 1 ]]; then
        return
    fi
    
    # Move cursor up N lines
    printf "\033[%dA" "$lines"
    
    # Clear from cursor to end of screen
    printf "\033[J"
}

export -f clearlines