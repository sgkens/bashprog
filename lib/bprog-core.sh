#!/bin/bash

# ==================================================================
# File: lib/bprog-core.sh
# Description: Core functions for bashprog
# ==================================================================



# ==================================================================
# Function: show_helpremaining_descrption_spaces
# ==================================================================
# Description:
#   Show the help message, to be called with the -h or --help option.
#
# Examples:
#   show_help "-b" "--bars" "Generate a progress bar"
# ==================================================================

help_writer() {
    local shortform="$1"
    local longform="$2"
    local description="$3"


    local shlf_spacing=3
    
    echo -n "$(clstring "$shortform" "bright_cyan") "

    local shlf_maxlength=10
    local current_shlf_length=$((${#shortform}+$shlf_spacing))
    local remaining_shlf_spaces=$(($shlf_maxlength-$current_shlf_length))
    
    echo -n "$(printf "%${remaining_shlf_spaces}s" "")"

    echo -n "$(clstring "$longform" "cyan")"
    
    local descrption_maxlength=35
    local current_descrption_length=$((${#longform}+current_shlf_length))
    local remaining_descrption_spaces=$(($descrption_maxlength-$current_descrption_length))
    
    if [[ ${#shortform} -gt 1 ]]; then
        remaining_descrption_spaces=$((${#shortform}-1+$remaining_descrption_spaces))
    else
        remaining_descrption_spaces=$((${#shortform}+$remaining_descrption_spaces))
    fi

    echo -n "$(printf "%${remaining_descrption_spaces}s" "")"
    echo "$(clstring "$description" "gray")"
}

show_help() {
    error="$1"
    mode="$2"
    command="$3"
    error_desc="$4"

    cat << EOF
$(clstring "BashProg" "cyan") ${BPROG_VERSION}

Usage: bashprog [options] [theme] [percent] [width]

≡$(clstring "Options" "yellow")≡
  $(help_writer "-h," "--help" "Display this help text")
  $(help_writer "-d," "--debug" "Sets BPROG_DEBUG to 1, enables debug mode")
  $(help_writer "-l," "--list [bars|spinners]" "List available themes for bars or spinners")
  $(help_writer "-m," "--message" "Sets the message to display for the bars or spinners")
  $(help_writer "-b," "--bar" "Switch to bar mode")
  $(help_writer "-s," "--spinner" "Switch to spinner mode")
  $(help_writer "-rw," "--rewrite" "Switch to rewrite mode")
  $(help_writer "-dm," "--demomode" "Switch to Demo mode")
  $(help_writer "-bc," "--barcolor" "Sets the bar color")
  $(help_writer "-bbg," "--barbgcolor" "Sets the bar background color")
  $(help_writer "-ptc," "--pointercolor" "Sets the bar pointer color")
  $(help_writer "-boc," "--baropencolor" "Sets the bar open color")
  $(help_writer "-bcc," "--barclosecolor" "Sets the bar close color")
  $(help_writer "-pc," "--percentcolor" "Sets the bar percent color")
  $(help_writer "-hp," "--hidePercent" "Omits the percent from the bar")

≡$(clstring "Examples" "yellow")≡
    $(clstring "Example" "bright_gray"): bashprog --bar --theme BlocksHolo 75 30
    $(clstring "Example" "bright_gray"): bashprog --spinner braille

>>> $( 
        if [[ "$error" == 1 ]]; then 
            echo "$(clstring "Command Error:" "red") $(clstring "$error_desc" "bright_red")";
            echo "       $(clstring "$mode" "yellow")";
            echo "       $(clstring "$command" "cyan")";
        fi 
    )

EOF
}

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
        echo "$(clstring "[DEBUG]" "cyan") $*" >&2
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
        echo "$(clstring "[WARNING]" "bright_yellow") jq is not installed. Some features may not work properly." >&2
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

    bprog_debug "$(clstring "bprog_load_module" "yellow") Loading module $(bkvp $module_name $module_path)"
    
    if [[ -f "$module_path" ]]; then
        source "$module_path"
        return 0
    else
        echo "$(clstring "[ERROR]" "red") Module '$module_name' not found at $(clstring "$module_path" "yellow")" >&2
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
#TODO: Add switch to list individual theme both bars and spinners
bprog_list_themes() {
    local theme_type="$1"  # "bars" or "spinners"
    local theme_name="$2" # optional theme name
    
    if [[ "$theme_type" != "bars" && "$theme_type" != "spinners" ]]; then
        echo "Usage: bprog_list_themes [bars|spinners]"
        return 1
    fi
    
    local theme_dir="${BPROG_HOME}/themes/${theme_type}"
    
    if [[ ! -d "$theme_dir" ]]; then
        echo "$(clstring "[ERROR]" "red") Theme directory not found: $theme_dir" >&2
        return 1
    fi
    
    echo "╭──────────────────────────────────╮"
    echo "├    Available bashprog themes     ┤"
    echo "├──────────────────────────────────┤"
    echo "├─• $(clstring "$theme_type" "bright_cyan")"
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
            theme_name="$(clstring "$(jq -r '.theme // "No theme"' "$theme_file" 2>/dev/null)" "bright_cyan")"
            theme_desc=$(jq -r '.description // "No description"' "$theme_file" 2>/dev/null)
            
            # TODO: Add Color to output
            case "$theme_type" in
                "bars")
                    # color elements with clstring
                    theme_bar_open="$(clstring "$(jq -r '.open // "No opening"' "$theme_file" 2>/dev/null)" "bright_yellow")"
                    theme_bar_close="$(clstring "$(jq -r '.close // "No closing"' "$theme_file" 2>/dev/null)" "bright_yellow")"
                    theme_bar_complete="$(clstring "$(jq -r '.complete // "No complete"' "$theme_file" 2>/dev/null)" "bright_green")"
                    theme_bar_incomplete="$(clstring "$(jq -r '.incomplete // "No incomplete"' "$theme_file" 2>/dev/null)" "bright_red")"
                    theme_bar_pointer="$(clstring "$(jq -r '.pointer // "No pointer"' "$theme_file" 2>/dev/null)" "bright_blue")"
                    local cchar=$theme_bar_complete
                    local ichar=$theme_bar_incomplete
                    echo "  $theme_name - $theme_bar_open$cchar$cchar$cchar$theme_bar_pointer$ichar$ichar$ichar$ichar$ichar$theme_bar_close 34%"
                    ;;
                "spinners")
                    theme_spinner_frames=$(jq -r '.frames | join(",") // "No frames"' "$theme_file" 2>/dev/null)
                    theme_spinner_complete=$(jq -r '.complete // "No complete"' "$theme_file" 2>/dev/null)
                    echo "  - $theme_name -|frames: [$theme_spinner_frames] Complete:($theme_spinner_complete)"
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
    
    bprog_debug "$(clstring "bprog_get_theme_path" "yellow") requesting themepath Generation : $(clstring "$theme_path" "cyan")"

    if [[ -f "$theme_path" ]]; then
        echo "$theme_path"
        return 0
    else
        echo "$(clstring "[ERROR]>" "red") Theme '$theme_name' not found at $theme_path" >&2
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
    
    bprog_debug "$(clstring "bprog_use_bar_theme" "yellow") requesting theme: $theme_name"

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
    
    bprog_debug "$(clstring "bprog_use_spinner_theme" "yellow") Loading spinner theme from path: $theme_path"

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
    
    bprog_check_dependencies
    
    # Load the core modules
    bprog_load_module "clearlines"
    bprog_load_module "bprog-bar"
    bprog_load_module "bprog-spinner"
    bprog_load_module "bprog-serializer-cachce" #*Completed
    bprog_load_module "bashprog-command"
    
    bprog_debug "$(clstring "bprog_init" "yellow") Initializing bashprog modules"

    return 0
}

bprog_init