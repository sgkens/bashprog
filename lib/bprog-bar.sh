#!/bin/bash

# Global associative array to store theme data
declare -g -A bprog_bar_theme

# ==================================================================
# Function: bprog_load_bar_theme
# ==================================================================
# Description:
#   Load bar theme from JSON filee using jq
#
# Arguments:
#   theme_file the path to the JSON file containing the theme data
#
# Examples:
#   bprog_load_bar_theme ./themes/bars/theme.json
#   bprog_load_bar_theme --verbose ./themes/bars/theme.json
#
# =================================================================

bprog_load_bar_theme() {
    local theme_file="$1"
    
    bprog_debug "$(clstring "bprog_load_bar_theme" "bright_magenta") $(clstring "[IO]" "bright_magenta") Loading bar theme from file: $theme_file"

     # Clear existing theme data
    unset bprog_bar_theme
    declare -g -A bprog_bar_theme

    # Check if file exists
    if [[ ! -f "$theme_file" ]]; then
        echo "$(clstring "[ERROR]" "red")> Theme file '$theme_file' not found." >&2
        return 1
    fi
    
    # Load the theme data or fail
    bprog_bar_theme[theme]="$(jq -r '.theme' $theme_file)"
    if [[ $? -ne 0 ]]; then
        echo "$(clstring "[ERROR]" "red")> Failed to parse theme file." >&2
        return 1
    fi

    # Load the theme ui properties
    bprog_bar_theme[open]="$(jq -r '.open' $theme_file)"
    bprog_bar_theme[close]="$(jq -r '.close' $theme_file)"
    bprog_bar_theme[complete]="$(jq -r '.complete' $theme_file)"
    bprog_bar_theme[incomplete]="$(jq -r '.incomplete' $theme_file)"
    bprog_bar_theme[pointer]="$(jq -r '.pointer' $theme_file)"
    bprog_bar_theme[description]="$(jq -r '.description // "No description"' $theme_file)"
    
    bprog_debug "$(clstring "bprog_load_bar_theme" "bright_magenta") Bar theme '${bprog_bar_theme["theme"]}' loaded successfully"
    
    return 0
}

# ==================================================================
# Function: bprog_bar
# ==================================================================
# Description:
#   Generate a progress bar based on the loaded theme
#
# Arguments:
#   usage  : bprog_bar <percent> [width]
#   percent: Percentage of completion (0-100)
#   width  : Width of the bar (default is 20 characters)
#
# Examples:
#   bprog_bar <percent> [width]
#   bprog_bar 50 40
#
# =================================================================
bprog_bar() {
    local percent=$1
    local width=${2:-20}  # Default width is 20 characters
    local message=${3:-""}
    
    # Check if theme is loaded
    if [[ -z "${bprog_bar_theme["theme"]}" ]]; then
        echo "$(clstring "[ERROR]" "red")> No bar theme loaded. Use bprog_load_bar_theme first." >&2
        return 1
    fi
    
    # Validate percent
    if [[ $percent -lt 0 ]]; then
        percent=0
    elif [[ $percent -gt 100 ]]; then
        percent=100
    fi
    
    # Calculate how many completed segments to show
    local completed_width=$(( width * $percent / 100 ))
    
    # Construct the progress bar
    local bar="${bprog_bar_theme["open"]}"
    
    # Add completed segments
    for ((i=0; i<completed_width; i++)); do
        bar+="${bprog_bar_theme["complete"]}"
    done
    
    # Add pointer if not 100%
    if [[ $percent -lt 100 && $completed_width -lt $width ]]; then
        bar+="${bprog_bar_theme["pointer"]}"
        local remaining=$((width - completed_width - 1))
    else
        local remaining=$((width - completed_width))
    fi
    
    # Add incomplete segments
    for ((i=0; i<remaining; i++)); do
        bar+="${bprog_bar_theme["incomplete"]}"
    done
    
    bar+="${bprog_bar_theme["close"]} ${percent}%"
    
    # no need for a return echo will do it
    # even when called from with in a string repersentation
    if [[ -z "$message" ]]; then
       echo "${bar}"
    else  
       echo "${bar} ${message}"
    fi
}

# ==================================================================
# Function: bprog_bar_demo
# ==================================================================
# Description:
#   Demonstrate a progress bar with a specified theme.
#
# Arguments:
#   theme_name: The name of the theme to use.
#   width: The width of the progress bar (default is 20).
#
# Examples:
#   bprog_bar_demo "braille" 40
#   bprog_bar_demo "braille"
#
# =================================================================

bprog_bar_demo() {
    local theme_name=${1:-"braille"}
    local width=${2:-20}
    
    if ! bprog_use_bar_theme "$theme_name"; then
        return 1
    fi
    
    echo "Demonstrating progress bar with theme: $theme_name"
    for i in {0..100..5}; do
        echo -ne "$(bprog_bar $i $width)\r"
        sleep 0.1
    done
    echo
}

# Initialize the bar module
# ==================================================================
# Function: bprog_bar_init
# ==================================================================
# Description:
#   Initialize the bar module.
#
# Examples:
#   bprog_bar_init
#
# =================================================================

bprog_bar_init() {
    bprog_debug "$(clstring "bprog_bar_init" "yellow") Bar module initialized"
    return 0
}

# auto run init on source
bprog_bar_init