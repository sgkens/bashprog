#!/bin/bash
# Author: Garvey Snow
# github: https://github.com/sgkens/colortext
# ==================================================================
#*Function: color_text
# ==================================================================
# Description:
#   Color text in the terminal, supports 8-bit colors.
#
# Arguments:
#   string: The text to color.
#   color: The text color (e.g., red, green, blue).
#   bgcolor: The background color (e.g., red, green, blue).
#
# Examples:
#   color_text "This is red text on yellow background" "red" "yellow"
#   color_text "This is blue text" "blue" ""
#   color_text "This has green background" "" "green"
# =================================================================

color_text() {
    local string="$1"
    local color="$2"
    local bgcolor="$3"
    
    # Foreground color codes
    local colors=(
        "black=30"
        "red=31"
        "green=32"
        "yellow=33"
        "blue=34"
        "magenta=35"
        "cyan=36"
        "white=37"
        "bright_black=90"    # Dark gray/bright black
        "bright_red=91"
        "bright_green=92"
        "bright_yellow=93"
        "bright_blue=94"
        "bright_magenta=95"
        "bright_cyan=96"
        "bright_white=97"
    )

    # Background color codes
    local bgcolors=(
        "black=40"
        "red=41"
        "green=42"
        "yellow=43"
        "blue=44"
        "magenta=45"
        "cyan=46"
        "white=47"
        "bright_black=100"   # Dark gray/bright black
        "bright_red=101"
        "bright_green=102"
        "bright_yellow=103"
        "bright_blue=104"
        "bright_magenta=105"
        "bright_cyan=106"
        "bright_white=107"
    )
    
    local color_code=""
    local bgcolor_code=""
    
    # Find color code
    for c in "${colors[@]}"; do
        if [[ "${c%%=*}" == "$color" ]]; then
            color_code="${c##*=}"
            break
        fi
    done
    
    # Find background color code
    for bg in "${bgcolors[@]}"; do
        if [[ "${bg%%=*}" == "$bgcolor" ]]; then
            bgcolor_code="${bg##*=}"
            break
        fi
    done
    
    # If color or bgcolor not found, use default (no color change)
    if [[ -z "$color_code" && -z "$bgcolor_code" ]]; then
        echo "$string"
        return
    fi
    
    local format_code=""
    
    # Construct format code
    if [[ -n "$color_code" && -n "$bgcolor_code" ]]; then
        format_code="\e[${color_code};${bgcolor_code}m"
    elif [[ -n "$color_code" ]]; then
        format_code="\e[${color_code}m"
    elif [[ -n "$bgcolor_code" ]]; then
        format_code="\e[${bgcolor_code}m"
    fi
    
    # Return the colored string with reset code at the end
    echo -e "${format_code}${string}\e[0m"
}

export -f color_text

# Test the function if this script is run directly
# if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
#     echo "Testing color_text function:"
#     echo "$(color_text "This is red text on yellow background" "red" "yellow")"
#     echo "$(color_text "This is blue text" "blue" "")"
#     echo "$(color_text "This has green background" "" "green")"
# fi