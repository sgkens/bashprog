#!/bin/bash
# ====================================
# Define global variables for spinner
# ====================================
declare -g -A bprog_spinner_theme
declare -g -a bprog_spinner_frames
declare -g -i bprog_spinner_current_frame=0
declare -g -i bprog_spinner_max_frame
# ====================================


# ==================================================================
# Function: bprog_load_spinner_theme
# ==================================================================
# Description:
#   Load spinner theme from JSON file.
#
# Arguments:
#   theme_file: The path to the JSON file containing the theme data.
#
# Examples:
#   bprog_load_spinner_theme ./themes/spinners/bits.json
#   echo "Spinner theme loaded: ${bprog_spinner_theme[theme]}"
#
# =================================================================

bprog_load_spinner_theme() {
    local theme_file="$1"
    
    bprog_debug "$(clstring "[IO]" "bright_magenta") Loading $(clstring "$theme_file" "yellow") spinner theme from"
    
    # Check if file exists
    if [[ ! -f "$theme_file" ]]; then
        echo "$(clstring "[ERROR]" "red")> Theme file '$theme_file' not found." >&2
        return 1
    fi
    
    # Load the theme basic data
    bprog_spinner_theme["theme"]=$(jq -r '.theme' "$theme_file" 2>/dev/null)
    if [[ $? -ne 0 ]]; then
        echo "$(clstring "[ERROR]" "red")> Failed to parse theme file." >&2
        return 1
    fi
    
    bprog_spinner_theme[complete]=$(jq -r '.complete // "✓"' "$theme_file")
    bprog_spinner_theme[wait]=$(jq -r '.wait // "-"' "$theme_file")
    
    # Reset spinner frames array
    unset bprog_spinner_frames
    declare -g -a bprog_spinner_frames
    
    # Load spinner frames - using the simplified format with direct array
    local frames_count=$(jq '.frames | length' "$theme_file")
    
    for ((i=0; i<frames_count; i++)); do
        bprog_spinner_frames[$i]="$(jq -r ".frames[$i]" "$theme_file")"
    done
    
    bprog_spinner_max_frame=${#bprog_spinner_frames[@]}
    # bprog_spinner_current_frame=0
    
    # Validate that we actually loaded some frames
    if [[ ${#bprog_spinner_frames[@]} -eq 0 ]]; then
        echo "$(clstring "[ERROR]" "red")> Failed to load any spinner frames from theme file." >&2
        return 1
    fi
    
    bprog_debug "Spinner theme '${bprog_spinner_theme["theme"]}' loaded with ${#bprog_spinner_frames[@]} frames"
    return 0
}

# ==================================================================
# Function: bprog_spinner
# ==================================================================
# Description:
#   Returns the next spinner frame based on the current frame index.
#
# Arguments:
#   None
#
# Examples:
#  bprog_use_spinner_theme "bits"
#  echo "Status: $(bprog_spinner)"
# =================================================================

bprog_spinner() {

    # Check if theme is loaded
    if [[ -z "${bprog_spinner_theme[theme]}" ]]; then
        echo "$(clstring "[ERROR]" "red")> No spinner theme loaded. Use bprog_load_spinner_theme first." >&2
        return 1
    fi
    
    # If there are no frames defined, return an error
    if [[ ${#bprog_spinner_frames[@]} -eq 0 ]]; then
        echo "$(clstring "[ERROR]" "red")> No spinner frames loaded." >&2
        return 1
    fi
    
    # Get the current spinner frame
    local spinner_frame="${bprog_spinner_frames[$bprog_spinner_current_frame]}"
    
    # Increment to the next frame
    bprog_spinner_current_frame=$((bprog_spinner_current_frame + 1))

    # reset the spinner frame if we reach the end
    if [[ $bprog_spinner_current_frame -ge $bprog_spinner_max_frame ]]; then
        bprog_spinner_current_frame=0
    fi
    
    # Return the current spinner frame
    echo -n "$spinner_frame"

}

# ==================================================================
# Function: bprog_spinner_complete
# ==================================================================
# Description:
#   Marks the spinner as complete.
#
# Arguments:
#   message: The message to display alongside the spinner.
#
# Examples:
#  bprog_use_spinner_theme "bits"
#  echo "Status: $(bprog_spinner_with_message "Loading..." bprog_spinner)"
#  bprog_spinner_complete "Loading"
# =================================================================

bprog_spinner_complete() {

    local message="$1"

    echo -e "${bprog_spinner_theme[complete]} $message"

}

# ==================================================================
# Function: bprog_spinner_demo
# ==================================================================
# Description:
#   Demonstrates the spinner with a specified theme and message.
#
# Arguments:
#   theme_name: The name of the spinner theme to use.
#   message: The message to display alongside the spinner.
#   iterations: The number of times to spin the spinner.
#
# Examples:
#  bprog_spinner_demo "bits" "Loading..." 20
#  bprog_spinner_demo "braille" "Processing..." 10
#  bprog_spinner_demo "braille" "Processing..."
# =================================================================

bprog_spinner_demo() {

    local theme_name=${1:-"bits"}
    local message=${2:-"Loading..."}
    local iterations=${3:-20}
    
    if ! bprog_use_spinner_theme "$theme_name"; then
        return 1
    fi
    
    echo "Demonstrating spinner with theme: $theme_name"
    local spinner_frame=$(bprog_spinner)
    for ((i=0; i<iterations; i++)); do
        bprog_spinner
        echo " $message"
        echo
        sleep 0.1
        clearlines 2
    done
    bprog_spinner_complete "$message Complete!"
    echo

}

# Initialize the spinner module
# ==================================================================
# Function: bprog_spinner_init
# ==================================================================
# Description:
#   Initialize the spinner module.
#
# Examples:
#   bprog_spinner_init
#
# =================================================================

bprog_spinner_init() {

    bprog_debug "$(clstring "bprog_spinner_init" "yellow") Spinner module initialized"
    return 0

}

# Call init function
# TODO: move to bprog entry .sh
bprog_spinner_init