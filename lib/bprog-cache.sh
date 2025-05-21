
declare -a bprog_bar_theme_cache_array=()
declare -a bprog_spinner_theme_cache_array=()



# ==================================================================
# Function: bprog_check_cache_array
# ==================================================================
# Description:
#   Check if a theme is already in the cache
#
# Arguments:
#   theme_name: The name of the theme to use.
#
# Examples:
#   bprog_check_cache_array "theme_name"
# =================================================================

function bprog_check_cache_array() {
    local theme_name="$1"
    local theme_type="$2"
    local debug_ident_color=$(clstring "bprog_check_cache_array" "cyan")
    
    case "$theme_type" in
        "bar")
            echo "Checking if theme '$theme_name' exists in cache."
            # loop through the array and check if the theme name exists in the cache
            bprog_debug "${debug_ident_color} Checking if bar theme '$theme_name' exists in cache."
            
            # Check if the theme name exists as a key in the bprog_bar_theme_cache_array
            if [[ -n "${bprog_bar_theme_cache_array[$theme_name]}" ]]; then
                bprog_debug "${debug_ident_color} Theme '$theme_name' already exists in cache."
                return 0 # exit with success
            fi
            ;;
            
        "spinner")
            bprog_debug "${debug_ident_color} Checking if spinner theme '$theme_name' exists in cache."
            
            # Check if the theme name exists as a key in the bprog_spinner_theme_cache_array
            if [[ -n "${bprog_spinner_theme_cache_array[$theme_name]}" ]]; then
                bprog_debug "${debug_ident_color} Theme '$theme_name' already exists in cache."
                return 0 # exit with success
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

# ==================================================================
# Function: bprog_get_theme_from_cache
# ==================================================================
# Description:
#   Get a theme from the cache
#
# Arguments:
#   theme_name: The name of the theme to use.
#   theme_type: The type of theme to use.
#
# Examples:
#   bprog_get_theme_from_cache "theme_name" "theme_type"
# =================================================================

function bprog_get_theme_from_cache() {
    local theme_name="$1"
    local theme_type="$2"

    declare -g -A bprog_bar_theme_cache

    local debug_ident_color=$(clstring "bprog_get_theme_from_cache" "cyan")

    case "$theme_type" in
        "bar")
            for i in ${!bprog_bar_theme_cache_array[@]}; do
                if [[ ${bprog_bar_theme_cache_array[$i][$theme_name]} == $theme_name ]]; then
                    bprog_debug "${debug_ident_color} Theme '$theme_name' found in cache, loading it."
                    
                    # populate the bprog_bar_theme array with the cached theme
                    bprog_bar_theme[theme]=${bprog_bar_theme_cache_array[$i][$theme_name]}
                    bprog_bar_theme[open]=${bprog_bar_theme_cache_array[$i][$theme_name]}
                    bprog_bar_theme[close]=${bprog_bar_theme_cache_array[$i][$theme_name]}
                    bprog_bar_theme[complete]=${bprog_bar_theme_cache_array[$i][$theme_name]}
                    bprog_bar_theme[incomplete]=${bprog_bar_theme_cache_array[$i][$theme_name]}
                    bprog_bar_theme[pointer]=${bprog_bar_theme_cache_array[$i][$theme_name]}
                    bprog_bar_theme[description]=${bprog_bar_theme_cache_array[$i][$theme_name]}

                    return 0

                fi
            done   
            ;;
        "spinner")
            bprog_debug "${debug_ident_color} Theme '$theme_name' found in cache, load."

            for i in ${!bprog_spinner_theme_cache_array[@]}; do
                if [[ ${bprog_spinner_theme_cache_array[$i][$theme_name]} == $theme_name ]]; then
                    bprog_debug "${debug_ident_color} Theme '$theme_name' found in cache, loading it."
                    
                    # populate the bprog_bar_theme array with the cached theme
                    bprog_spinner_theme[theme]=${bprog_spinner_theme_cache_array[$i][$theme_name]}
                    bprog_spinner_theme[complete]=${bprog_spinner_theme_cache_array[$i][$theme_name]}
                    bprog_spinner_theme[frames]=${bprog_spinner_theme_cache_array[$i][$theme_name]}
                    bprog_spinner_theme[description]=${bprog_spinner_theme_cache_array[$i][$theme_name]}

                    return 0

                fi
            done
            ;;
        *)
            bprog_debug "${debug_ident_color} Invalid theme type: $theme_type"
            return 1
            ;;
    esac
}

# ==================================================================
# Function: bprog_bar_theme_cache_manager
# ==================================================================
# Description:
#   Manage the cache of themes
#
# Arguments:
#   theme_name: The name of the theme to use.
#   theme_type: The type of theme to use.
#
# Examples:
#   bprog_bar_theme_cache_manager "theme_name" "theme_type"
# =================================================================

function bprog_bar_theme_cache_manager() {
    local theme_name="$1"
    
    declare -g -A bprog_bar_theme_cache_elements

    local debug_ident_color=$(clstring "bprog_bar_theme_cache_manager" "cyan")

    # check if the theme name is provided
    if [[ -z "$theme_name" ]]; then
        bprog_debug "Theme name is required for caching."
        return 1
    fi

    # check if the current theme is already loaded into assoc array: bprog_bar_theme
    # check if the theme name is already in the cache, if not then add it
    if [[ ${bprog_bar_theme[theme]} == "$theme_name" ]]; then
        bprog_debug "${debug_ident_color} Theme '$theme_name' Already loaded, caching it if not already cached."

        # check if the theme name exists in the cache array
        if [[ $(bprog_check_cache_array "$theme_name" "bar") -eq 1 ]]; then
            bprog_debug "${debug_ident_color} Theme '$theme_name' already exists in cache, skipping."

            return 1
        else
            bprog_debug "${debug_ident_color} Theme '$theme_name' does not exist in cache, Adding theme to cache."
            
            # import the theme data from the bprog_bar_theme array to the cache
            bprog_bar_theme_cache_elements[theme]="${bprog_bar_theme[theme]}"
            bprog_bar_theme_cache_elements[open]="${bprog_bar_theme[open]}"
            bprog_bar_theme_cache_elements[close]="${bprog_bar_theme[close]}"
            bprog_bar_theme_cache_elements[complete]="${bprog_bar_theme[complete]}"
            bprog_bar_theme_cache_elements[incomplete]="${bprog_bar_theme[incomplete]}"
            bprog_bar_theme_cache_elements[pointer]="${bprog_bar_theme[pointer]}"
            bprog_bar_theme_cache_elements[description]="${bprog_bar_theme[description]}"

            bprog_bar_theme_cache_array+=bprog_bar_theme_cache_elements
            
            bprog_debug "${debug_ident_color} Theme '$theme_name' added to cache."
            
            return 0
        fi
    else
        # check if theme is in cache to save an IO operation
        # populate the bprog_bar_theme array with the cached theme if it exists
        bprog_debug "${debug_ident_color} Theme '$theme_name' not loaded, cannot cache."
        if [[ $(bprog_check_cache_array "$theme_name" "bar") -eq 1 ]]; then
            bprog_debug "${debug_ident_color} Theme '$theme_name' already exists in cache."

            bprog_get_theme_from_cache "$theme_name" "bar"
            
            bprog_debug "${debug_ident_color} Theme '$theme_name' loaded from cache."
            
            return 0

        else
            # if theme is not in cache, load it from file and save it to cache
            bprog_debug "${debug_ident_color} Theme '$theme_name' not found in cache."
            bprog_use_bar_theme "$theme_name"

            # import the theme data from the bprog_bar_theme array to the cache
            bprog_bar_theme_cache_elements[theme]="${bprog_bar_theme[theme]}"
            bprog_bar_theme_cache_elements[open]="${bprog_bar_theme[open]}"
            bprog_bar_theme_cache_elements[close]="${bprog_bar_theme[close]}"
            bprog_bar_theme_cache_elements[complete]="${bprog_bar_theme[complete]}"
            bprog_bar_theme_cache_elements[incomplete]="${bprog_bar_theme[incomplete]}"
            bprog_bar_theme_cache_elements[pointer]="${bprog_bar_theme[pointer]}"
            bprog_bar_theme_cache_elements[description]="${bprog_bar_theme[description]}"

            bprog_bar_theme_cache_array+=bprog_bar_theme_cache_elements
            
            bprog_debug "${debug_ident_color} Theme '$theme_name' added to cache."
            
            return 0
        fi
        
    fi 

}

function bprog_spinner_theme_cache_manager() {
    local theme_name="$1"

    declare -g -A bprog_spinner_theme_cache_elements

    local debug_ident_color=$(clstring "bprog_spinner_theme_cache_manager" "cyan")

    # check if the theme name is provided
    if [[ -z "$theme_name" ]]; then
        bprog_debug "${debug_ident_color} Theme name is required for caching."
        return 1
    fi
    # check if the current theme is already loaded into assoc array: bprog_spinner_theme
    # check if the theme name is already in the cache, if not then add it
    if [[ ${bprog_spinner_theme[theme]} == $theme_name ]]; then
        bprog_debug "${debug_ident_color} Theme '$theme_name' Already loaded, caching it if not already cached."

        # check if the theme name exists in the cache array
        if [[ $(bprog_check_cache_array "$theme_name" "spinner") -eq 1 ]]; then
            bprog_debug "${debug_ident_color} Theme '$theme_name' already exists in cache, skipping."

            return 1
        else
            bprog_debug "${debug_ident_color} Theme '$theme_name' does not exist in cache, Adding theme to cache."
            
            # import the theme data from the bprog_bar_theme array to the cache
            bprog_spinner_theme_cache_elements[theme]="${bprog_spinner_theme[theme]}"
            bprog_spinner_theme_cache_elements[complete]="${bprog_spinner_theme[complete]}"
            bprog_spinner_theme_cache_elements[frames]="${bprog_spinner_theme[frames]}"
            bprog_spinner_theme_cache_elements[description]="${bprog_spinner_theme[description]}"
            bprog_spinner_theme_cache_array+=bprog_spinner_theme_cache_elements
            bprog_debug "${debug_ident_color} Theme '$theme_name' added to cache."
        fi
        return 0
    else
        # check if theme is in cache to save an IO operation
        # populate the bprog_bar_theme array with the cached theme if it exists
        bprog_debug "${debug_ident_color} Theme '$theme_name' not loaded, cannot cache."
        if [[ $(bprog_check_cache_array "$theme_name" "spinner") -eq 1 ]]; then
            bprog_debug "${debug_ident_color} Theme '$theme_name' already exists in cache."

            bprog_get_theme_from_cache "$theme_name" "spinner"
            
            bprog_debug "${debug_ident_color} Theme '$theme_name' loaded from cache."
            
            return 0

        else
            # if theme is not in cache, load it from file and save it to cache
            bprog_debug "${debug_ident_color} Theme '$theme_name' not found in cache."
            bprog_use_spinner_theme "$theme_name"

            # import the theme data from the bprog_bar_theme array to the cache
            bprog_spinner_theme_cache_elements[theme]="${bprog_spinner_theme[theme]}"
            bprog_spinner_theme_cache_elements[complete]="${bprog_spinner_theme[complete]}"
            bprog_spinner_theme_cache_elements[frames]="${bprog_spinner_theme[frames]}"
            bprog_spinner_theme_cache_elements[description]="${bprog_spinner_theme[description]}"

            bprog_spinner_theme_cache_array+=bprog_spinner_theme_cache_elements
            bprog_debug "${debug_ident_color} Theme '$theme_name' added to cache."
            
            return 0
        fi
        
    fi
}
