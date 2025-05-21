#!/bin/bash

declare -g -A bprog_bar_theme_cache
declare -g -A bprog_spinner_theme_cache

# Function to add a theme to the cache
function bprog_add_theme_to_cache() {
    local theme_name="$1"
    local theme_type="$2"
    local debug_ident_color=$(clstring "*add_theme_to_cache" "bright_cyan")
   
    case "$theme_type" in
        "bar")
            # CRITICAL FIX: First retrieve and store all values in local variables
            local open_val="${bprog_bar_theme[open]}"
            local close_val="${bprog_bar_theme[close]}"
            local complete_val="${bprog_bar_theme[complete]}"
            local incomplete_val="${bprog_bar_theme[incomplete]}"
            local pointer_val="${bprog_bar_theme[pointer]}"
            local desc_val="${bprog_bar_theme[description]}"
            
            # Debug the retrieved values
            bprog_debug "${debug_ident_color} Currently Loaded: open='$open_val'"
            bprog_debug "${debug_ident_color} Currently Loaded: close='$close_val'"
            bprog_debug "${debug_ident_color} Currently Loaded: complete='$complete_val'"
            bprog_debug "${debug_ident_color} Currently Loaded: incomplete='$incomplete_val'"
            bprog_debug "${debug_ident_color} Currently Loaded: pointer='$pointer_val'"
            bprog_debug "${debug_ident_color} Currently Loaded: description='$desc_val'"
            
            # Store each property with the theme name as part of the key
            bprog_bar_theme_cache["${theme_name}_theme"]="$theme_name"
            bprog_bar_theme_cache["${theme_name}_open"]="$open_val"
            bprog_bar_theme_cache["${theme_name}_close"]="$close_val"
            bprog_bar_theme_cache["${theme_name}_complete"]="$complete_val"
            bprog_bar_theme_cache["${theme_name}_incomplete"]="$incomplete_val"
            bprog_bar_theme_cache["${theme_name}_pointer"]="$pointer_val"
            bprog_bar_theme_cache["${theme_name}_description"]="$desc_val"
            
            # Debug values in cache after storing
            bprog_debug "${debug_ident_color} From cache: Cached: open='${bprog_bar_theme_cache["${theme_name}_open"]}'"
            bprog_debug "${debug_ident_color} From cache: close='${bprog_bar_theme_cache["${theme_name}_close"]}'"
            bprog_debug "${debug_ident_color} From cache: complete='${bprog_bar_theme_cache["${theme_name}_complete"]}'"
            bprog_debug "${debug_ident_color} From cache: incomplete='${bprog_bar_theme_cache["${theme_name}_incomplete"]}'"
            bprog_debug "${debug_ident_color} From cache: pointer='${bprog_bar_theme_cache["${theme_name}_pointer"]}'"
            bprog_debug "${debug_ident_color} From cache: description='${bprog_bar_theme_cache["${theme_name}_description"]}'"

            bprog_debug "${debug_ident_color} Added bar theme '$theme_name' to cache."
            ;;
           
        "spinner")
            # CRITICAL FIX: First retrieve and store all values in local variables
            local complete_val="${bprog_spinner_theme[complete]}"
            local frames_val="${bprog_spinner_theme[frames]}"
            local desc_val="${bprog_spinner_theme[description]}"
            
            # Debug the retrieved values
            bprog_debug "${debug_ident_color} Retrieved: complete='$complete_val'"
            bprog_debug "${debug_ident_color} Retrieved: frames='$frames_val'"
            bprog_debug "${debug_ident_color} Retrieved: description='$desc_val'"
            
            # Store each property with the theme name as part of the key
            bprog_spinner_theme_cache["${theme_name}_theme"]="$theme_name"
            bprog_spinner_theme_cache["${theme_name}_complete"]="$complete_val"
            bprog_spinner_theme_cache["${theme_name}_frames"]="$frames_val"
            bprog_spinner_theme_cache["${theme_name}_description"]="$desc_val"
            
            bprog_debug "${debug_ident_color} Added spinner theme '$theme_name' to cache."
            ;;
    esac
   
    return 0
}

# Function to check if a theme exists in the cache
function bprog_check_cache_array() {
    local theme_name="$1"
    local theme_type="$2"
    local debug_ident_color=$(clstring "*check_cache_array_flat" "bright_cyan")
   
    case "$theme_type" in
        "bar")
            bprog_debug "${debug_ident_color} Checking if bar theme '$theme_name' exists in cache."
            if [[ -n "${bprog_bar_theme_cache["${theme_name}_theme"]}" ]]; then
                bprog_debug "${debug_ident_color} Theme '$theme_name' already exists in cache."
                return 0 # exit with success
            else
                return 1 # exit with error
            fi
            ;;
           
        "spinner")
            bprog_debug "${debug_ident_color} Checking if spinner theme '$theme_name' exists in cache."
            if [[ -n "${bprog_spinner_theme_cache["${theme_name}_theme"]}" ]]; then
                bprog_debug "${debug_ident_color} Theme '$theme_name' already exists in cache."
                return 0 # exit with success
            else
                return 1 # exit with error
            fi
            ;;
           
        *)
            echo "Invalid theme type: $theme_type"
            bprog_debug "${debug_ident_color} Invalid theme type: $theme_type"
            return 1 # exit with error
            ;;
    esac
   
    # If we got here, the theme wasn't found
    return 1
}

# Function to get a theme from the cache (flat approach)
function bprog_get_theme_from_cache() {
    local theme_name="$1"
    local theme_type="$2"
    local debug_ident_color=$(clstring "*get_theme_from_cache" "bright_cyan")
   
    case "$theme_type" in
        "bar")
            if [[ -n "${bprog_bar_theme_cache["${theme_name}_theme"]}" ]]; then
                bprog_debug "${debug_ident_color} Theme '$theme_name' found in cache, loading it."
                
                local theme_val=${bprog_bar_theme_cache["${theme_name}_theme"]}
                local open_val=${bprog_bar_theme_cache["${theme_name}_open"]}
                local close_val=${bprog_bar_theme_cache["${theme_name}_close"]}
                local complete_val=${bprog_bar_theme_cache["${theme_name}_complete"]}
                local incomplete_val=${bprog_bar_theme_cache["${theme_name}_incomplete"]}
                local pointer_val=${bprog_bar_theme_cache["${theme_name}_pointer"]}
                local desc_val=${bprog_bar_theme_cache["${theme_name}_description"]}
                
                # Debug the retrieved values
                bprog_debug "${debug_ident_color} Retrieved from cache: open='$open_val'"
                bprog_debug "${debug_ident_color} Retrieved from cache: close='$close_val'"
                bprog_debug "${debug_ident_color} Retrieved from cache: complete='$complete_val'"
                bprog_debug "${debug_ident_color} Retrieved from cache: incomplete='$incomplete_val'"
                bprog_debug "${debug_ident_color} Retrieved from cache: pointer='$pointer_val'"
                bprog_debug "${debug_ident_color} Retrieved from cache: description='$desc_val'"
               
                # Populate the bprog_bar_theme array with the cached theme
                bprog_bar_theme[theme]="$theme_val"
                bprog_bar_theme[open]="$open_val"
                bprog_bar_theme[close]="$close_val"
                bprog_bar_theme[complete]="$complete_val"
                bprog_bar_theme[incomplete]="$incomplete_val"
                bprog_bar_theme[pointer]="$pointer_val"
                bprog_bar_theme[description]="$desc_val"

                # Debug values in bprog_bar_theme after loading
                bprog_debug "${debug_ident_color} Loaded: open='${bprog_bar_theme[open]}'"
                bprog_debug "${debug_ident_color} Loaded: close='${bprog_bar_theme[close]}'"
                bprog_debug "${debug_ident_color} Loaded: complete='${bprog_bar_theme[complete]}'"
                bprog_debug "${debug_ident_color} Loaded: incomplete='${bprog_bar_theme[incomplete]}'"
                bprog_debug "${debug_ident_color} Loaded: pointer='${bprog_bar_theme[pointer]}'"
                bprog_debug "${debug_ident_color} Loaded: description='${bprog_bar_theme[description]}'"

                
                unset theme_val
                unset open_val
                unset close_val
                unset complete_val
                unset incomplete_val
                unset pointer_val
                unset desc_val

                return 0
            fi
            ;;
           
        "spinner")
            if [[ -n "${bprog_spinner_theme_cache["${theme_name}_theme"]}" ]]; then
                bprog_debug "${debug_ident_color} Theme '$theme_name' found in cache, loading it."
                
                # CRITICAL FIX: First retrieve and store all values in local variables
                local theme_val="${bprog_spinner_theme_cache["${theme_name}_theme"]}"
                local complete_val="${bprog_spinner_theme_cache["${theme_name}_complete"]}"
                local frames_val="${bprog_spinner_theme_cache["${theme_name}_frames"]}"
                local desc_val="${bprog_spinner_theme_cache["${theme_name}_description"]}"
                
                # Debug the retrieved values
                bprog_debug "${debug_ident_color} Retrieved from cache: complete='$complete_val'"
                bprog_debug "${debug_ident_color} Retrieved from cache: frames='$frames_val'"
                bprog_debug "${debug_ident_color} Retrieved from cache: description='$desc_val'"
               
                # Populate the bprog_spinner_theme array with the cached theme
                bprog_spinner_theme[theme]="$theme_val"
                bprog_spinner_theme[complete]="$complete_val"
                bprog_spinner_theme[frames]="$frames_val"
                bprog_spinner_theme[description]="$desc_val"
                
                return 0
            fi
            ;;
           
        *)
            bprog_debug "${debug_ident_color} Invalid theme type: $theme_type"
            return 1
            ;;
    esac
   
    # If we got here, the theme wasn't found
    return 1
}