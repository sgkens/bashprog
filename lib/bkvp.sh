#!/bin/bash

# ==================================================================
# Function: bkvp
# ==================================================================
# Description:
#   Output key-value pairs in JSON single line format.
#
# Arguments:
#   key: The key of the key-value pair.
#   value: The value of the key-value pair.
#
# Examples:
#   bkvp "name" "John Doe"
#   bkvp "age" "30"
#
# =================================================================

bkvp() {
    local key="$1"
    local value="$2"
    
    # Check if key and value are not empty
    if [[ -z "$key" || -z "$value" ]]; then
        echo "bkvp: Key and value cannot be empty"
        return 1
    fi
    
    # Output key-value pair in JSON format
    echo "$(color_text { magenta) $(color_text ${key} cyan) : ${value} $(color_text } magenta)"
}

export -f bkvp

