#!/bin/bash
# ==================================================================
# File: bashprog.sh
# Description: main command function of module
# ==================================================================
bashprog() {
    
    # Default values
    mode=""
    linecount=1
    bar_color=""
    bar_bg_color=""
    pointer_color=""
    bar_open_color=""
    bar_close_color=""
    percent_color=""
    spinner_color=""
    spinner_bg_color=""
    theme=""
    width=50
    percent=0
    message=""
    list_type=""
    demo=0

    # Parse command line arguments
    for arg in "$@"; do
        case "$1" in
            -h|--help)
                show_help "0" "" "" ""
                ;;
            -d|--debug)
                BPROG_DEBUG=1
                shift
                ;;
            -b|--bar)
                mode="bar"
                shift
                ;;
            -s|--spinner)
                mode="spinner"
                shift
                ;;
            -v|--version)
                mode="version"
                shift
                ;;
            -dm|--demomode)
                demo=1
                shift 2
                ;;
            -l|--list)
                mode="list"
                list_type="$2"
                list_theme_name="$3"
                shift 2
                ;;
            -rw|--rewrite)
                mode="rewrite"
                linecount="$2"
                shift  2
                ;;
            -bc|--barcolor)
                bar_color="$2"
                shift 2
                ;;
            -bbg|--barbgcolor)
                bar_bg_color="$2"
                shift 2
                ;;
            -ptc|--pointercolor)
                pointer_color="$2"
                shift 2
                ;;
            -bop|--baropencolor)
                bar_open_color="$2"
                shift 2
                ;;
            -bco|--barclosecolor)
                bar_close_color="$2"
                shift 2
                ;;
            -pc|--percentcolor)
                percent_color="$2"
                shift 2
                ;;
            # -v|--verbose)
            #     verbose=true
            #     shift
            #     ;;
            *)
                # Handle positional arguments
                if [[ -z $theme && "$1" =~ ^[a-zA-Z0-9_]+$ ]]; then
                    theme="$1"
                elif [[ "$1" =~ ^[0-9]+$ && $percent -eq 0 ]]; then
                    percent="$1"
                elif [[ "$1" =~ ^[0-9]+$ ]]; then
                    width="$1"
                else
                    if [[ -z "$1" ]]; then
                        if [[ $mode == "bar" ]]; then
                            message="Loading..."
                        elif [[ $mode == "spinner" ]]; then
                            message="Processing..."
                        fi
                    else
                        message="$1"
                    fi
                fi
                shift
                ;;
            esac
        done
        # Check if the mode is set
        bprog_debug "----------------------"
        bprog_debug "[OPTIONS-Parse command line arguments]"
        bprog_debug "----------------------"
        bprog_debug "Mode__________________: $mode" # demo, bar, spinner
        bprog_debug "Demo__________________: $demo"
        bprog_debug "----------------------"
        bprog_debug "Debug trigger_________: $BPROG_DEBUG"
        bprog_debug "Bar Color_____________: $bar_color"
        bprog_debug "Bar Background Color__: $bar_bg_color"
        bprog_debug "Bar Open Color________: $bar_open_color"
        bprog_debug "Bar Close Color_______: $bar_close_color"
        bprog_debug "Pointer Color_________: $pointer_color"
        bprog_debug "Percent Color_________: $percent_color"
        bprog_debug "----------------------"
        bprog_debug "[THEME PARAMS]"
        bprog_debug "----------------------"
        bprog_debug "Theme_________________: $theme"
        bprog_debug "Width_________________: $width"
        bprog_debug "Percent_______________: $percent"
        bprog_debug "Message_______________: $message"
        bprog_debug "______________________"
        bprog_debug "List Type_____________: $list_type"
        bprog_debug "List Theme Name_______: $list_theme_name"
        bprog_debug "----------------------"
        bprog_debug "Line Count____________: $linecount"
        bprog_debug "----------------------"

        # Main logic based on mode
        case "$mode" in
            "list")
                 bprog_debug "$(clstring "bashprog" "cyan" ) Running in list mode"
                # check if user has specified a list type
                if [[ -z "$list_type" ]]; then
                    show_help "1" "List Mode Selected" "But requires list type" "List mode requires a list type [bars] or [spinners]"
                    return 1
                fi
                # switch between all theme output and a specific theme
                if [[ -z "$list_theme_name" ]]; then
                    bprog_list_themes $list_type $list_theme_name
                    if [[ $? -ne 0 ]]; then
                        return 1
                    else 
                        return 0
                    fi
                else
                    bprog_list_themes $list_type
                    if [[ $? -ne 0 ]]; then
                        return 1
                    else 
                        return 0
                    fi
                fi
                ;;
            "bar")
                bprog_debug "$(clstring "bashprog" "cyan" ) Running in bar mode"
                if [[ "$demo" ==  1 ]]; then 
                    bprog_debug "$(clstring "bashprog" "cyan" ) Switching to bar-demo mode"
                    bprog_bar_demo "$theme" "$width"
                else 
                    bprog_debug "$(clstring "bashprog" "cyan" ) Running in normal mode"
                    bprog_use_bar_theme "$theme"
                    bprog_bar "$percent" "$width" "$message"
                fi
                ;;
            "spinner")
                bprog_debug "$(clstring "bashprog" "cyan" ) Running in spinner mode"
                if [[ "$demo" ==  1 ]]; then
                    bprog_debug "$(clstring "bashprog" "cyan" ) switching to spinner-demo mode"
                    bprog_spinner_demo "$theme" "$message"
                    echo " $message"
                else
                    bprog_debug "$(clstring "bashprog" "cyan" ) Running in normal mode"
                    # Spinner mode logic here
                    bprog_use_spinner_theme "$theme"
                    bprog_spinner
                    echo " $message"
                fi
                ;;
            "rewrite")
                bprog_debug "$(clstring "bashprog" "cyan" ) Running in rewrite mode"
                # Rewrite mode logic here
                clearlines $linecount
                ;;
            "version")
                bprog_debug "$(clstring "bashprog" "cyan" ) Running in version mode"
                # Rewrite mode logic here
                echo "bashprog version $BPROG_VERSION"
                ;;
            *)
                show_help "1" "No mode" "Use [-b|--bar], [-s|--spinner] or [-l|--list] together with [-dm|--demomode] or [-db|--debug]" "Please specify a mode."
                ;;
        esac
}

export -f bashprog