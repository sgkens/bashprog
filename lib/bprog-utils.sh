#!/bin/bash

# Debug function
# ==================================================================
# Function: bprog_debug
# ==================================================================
# Description:
#   Debug function
#
# Arguments:
#   message: The message to output
#
# Examples:
#   bprog_debug "Debug message"
#
#   bprog_debug "Debug message with variable: $var"
#
# =================================================================
bprog_debug() {
    if [[ $BPROG_DEBUG -eq 1 ]]; then
        echo "$(color_text "[DEBUG]" "cyan") $*" >&2
    fi
}

# Enable/disable debug mode
# ==================================================================
# Function: bprog_set_debug
# ==================================================================
# Description:
#   Enable/disable debug mode
#
# Arguments:
#   debug_mode: The debug mode to set (0 or 1)
#
# Examples:
#   bprog_set_debug 1
#
#   bprog_set_debug 0
#
# =================================================================

bprog_set_debug() {
    BPROG_DEBUG=$1
}

# ==================================================================
# Function: bprog_check_dependencies
# ==================================================================
# Description:
#   Check if jq is available
#
# Examples:
#   bprog_check_dependencies
#
# =================================================================

bprog_check_dependencies() {
    if ! command -v jq &> /dev/null; then
        echo "Warning: jq is not installed. Some features may not work properly." >&2
        return 1
    fi
    return 0
}

# ==================================================================
# Function: bprog_load_module
# ==================================================================
# Description:
#   Load a module from the lib directory.
#
# Arguments:
#   module_name: The name of the module to load.
#
# Examples:
#   bprog_load_module "bprog-core"
#   bprog_load_module "bprog-bar"
#   bprog_load_module "bprog-spinner"
#
# =================================================================

bprog_load_module() {
    local module_name="$1"
    
    local module_path="${BPROG_HOME}/lib/${module_name}.sh"

    bprog_debug "Loading module: $module_name from path: $module_path"
    
    if [[ -f "$module_path" ]]; then
        source "$module_path"
        return 0
    else
        echo "Error: Module '$module_name' not found at $module_path" >&2
        return 1
    fi
}

export -f bprog_load_module

# ==================================================================
# Function: bprog_list_themes
# ==================================================================
# Description:
#   List all available themes for bars or spinners.
#
# Arguments:
#   theme_type: The type of theme to list ("bars" or "spinners").
#
# Examples:
#   bprog_list_themes bars
#   bprog_list_themes spinners
#
# =================================================================

bprog_list_themes() {
    local theme_type="$1"  # "bars" or "spinners"
    local theme_name="$2" # optional theme name
    
    if [[ "$theme_type" != "bars" && "$theme_type" != "spinners" ]]; then
        echo "Usage: bprog_list_themes [bars|spinners]"
        return 1
    fi
    
    local theme_dir="${BPROG_HOME}/themes/${theme_type}"
    
    if [[ ! -d "$theme_dir" ]]; then
        echo "Error: Theme directory not found: $theme_dir" >&2
        return 1
    fi
    
    echo "Available $theme_type themes:"

    for theme_file in "$theme_dir"/*.json; do
        if [[ -f "$theme_file" ]]; then
            local theme_name=""
            local theme_desc=""
            local theme_spinner_frames=""
            local theme_bar_open=""
            local theme_bar_close=""
            local theme_bar_complete=""
            local theme_bar_incomplete=""
            local theme_bar_pointer=""
            
            # All themes will have these properties
            theme_desc=$(jq -r '.description // "No description"' "$theme_file" 2>/dev/null)
            
            # TODO: Add Color to output
            case "$theme_type" in
                "bars")
                    # color elements with color_text
                    theme_name="$(color_text "$(jq -r '.theme // "No theme"' "$theme_file" 2>/dev/null)" "bright_cyan")"
                    theme_bar_open="$(color_text "$(jq -r '.open // "No opening"' "$theme_file" 2>/dev/null)" "bright_yellow")"
                    theme_bar_close="$(color_text "$(jq -r '.close // "No closing"' "$theme_file" 2>/dev/null)" "bright_yellow")"
                    theme_bar_complete="$(color_text "$(jq -r '.complete // "No complete"' "$theme_file" 2>/dev/null)" "bright_green")"
                    theme_bar_incomplete="$(color_text "$(jq -r '.incomplete // "No incomplete"' "$theme_file" 2>/dev/null)" "bright_red")"
                    theme_bar_pointer="$(color_text "$(jq -r '.pointer // "No pointer"' "$theme_file" 2>/dev/null)" "bright_blue")"
                    local cchar=$theme_bar_complete
                    local ichar=$theme_bar_incomplete
                    echo "  $theme_name - $theme_bar_open$cchar$cchar$cchar$theme_bar_pointer$ichar$ichar$ichar$ichar$ichar$theme_bar_close"
                    ;;
                "spinners")
                    theme_spinner_frames=$(jq -r '.frames | join(",") // "No frames"' "$theme_file" 2>/dev/null)
                    echo "  - $theme_name -|frames: [$theme_frames] Wait:($theme_waiting) Open: ($theme_opening) Close: ($theme_closing)|- : $theme_desc"
                    ;;
            esac
            #echo "  - $theme_name -|frames: [$theme_frames] Wait:($theme_waiting) Open: ($theme_opening) Close: ($theme_closing)|- : $theme_desc"
        fi
    done
}

# ==================================================================
# Function: bprog_get_theme_path
# ==================================================================
# Description:
#   Get the path to a theme file based on its type and name.
#
# Arguments:
#   theme_type: The type of theme ("bars" or "spinners").
#   theme_name: The name of the theme.
#
# Examples:
#   bprog_get_theme_path bars "BlocksHolo"
#   bprog_get_theme_path spinners "bits"
#
# =================================================================

bprog_get_theme_path() {
    local theme_type="$1"  # "bars" or "spinners"
    local theme_name="$2"
    
    local theme_path="${BPROG_HOME}/themes/${theme_type}/${theme_name}.json"
    
    if [[ -f "$theme_path" ]]; then
        echo "$theme_path"
        return 0
    else
        echo "Error: Theme '$theme_name' not found at $theme_path" >&2
        return 1
    fi
}

# ==================================================================
# Function: bprog_use_bar_theme
# ==================================================================
# Description:
#   Load a bar theme by name instead of path.
#
# Arguments:
#   theme_name: The name of the theme to load.
#
# Examples:
#   bprog_use_bar_theme "BlocksHolo"
#   bprog_use_bar_theme "braille"
#
# =================================================================

bprog_use_bar_theme() {
    local theme_name="$1"
    local theme_path=$(bprog_get_theme_path "bars" "$theme_name")
    
    bprog_debug "Loading bar theme from path: $theme_path"

    if [[ -f "$theme_path" ]]; then
        bprog_load_bar_theme "$theme_path"
        return $?
    else
        return 1
    fi
}

# Load a spinner theme by name instead of path
# ==================================================================
# Function: bprog_use_spinner_theme
# ==================================================================
# Description:
#   Load a spinner theme by name instead of path.
#
# Arguments:
#   theme_name: The name of the theme to load.
#
# Examples:
#   bprog_use_spinner_theme "bits"
#   bprog_use_spinner_theme "braille"
#
# =================================================================

bprog_use_spinner_theme() {
    local theme_name="$1"
    local theme_path=$(bprog_get_theme_path "spinners" "$theme_name")
    
    bprog_debug "Loading spinner theme from path: $theme_path"

    if [[ -f "$theme_path" ]]; then
        bprog_load_spinner_theme "$theme_path"
        return $?
    else
        return 1
    fi
}

# ==================================================================
# Function: bprog_init
# ==================================================================
# Description:
#   Load all core modules.
#
# Examples:
#   bprog_init
#   bprog_init
#
# =================================================================

bprog_init() {

    
    bprog_debug "Initializing bprog modules"
    
    bprog_check_dependencies
    
    # Load the core modules
    bprog_load_module "bprog-bar"
    bprog_load_module "bprog-spinner"
    bprog_load_module "bprog-cache"
    
    return 0
}

bprog_init