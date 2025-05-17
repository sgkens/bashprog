#!/bin/bash
# ==================================================================
# File: bashprog.sh
# Description: Main entry point for the bashprog library
# ==================================================================
bashprog() {
    
    # Default values
    mode=""
    theme=""
    bar_color=""
    bar_bg_color=""
    pointer_color=""
    bar_open_color=""
    bar_close_color=""
    percent_color=""
    spinner_color=""
    spinner_bg_color=""
    percent=0
    width=50

    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
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
            -t|--theme)
                theme="$2"
                shift 2
                ;;
            -dm|--demomode)
                mode="demo"
                shift
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
                    echo "Unknown option: $1"
                    show_help
                fi
                shift
                ;;
            esac
        done
        # Check if the mode is set

        bashprog_debug "Mode: $mode" # demo, bar, spinner
        bashprog_debug "Theme: $theme"
        bashprog_debug "Percent: $percent"
        bashprog_debug "Width: $width"
        bashprog_debug "Bar Color: $bar_color"
        bashprog_debug "Pointer Color: $pointer_color"
        bashprog_debug "Bar Open Color: $bar_open_color"
        bashprog_debug "Bar Close Color: $bar_close_color"
        bashprog_debug "Percent Color: $percent_color"
        bashprog_debug "Spinner Color: $spinner_color"
        #bashprog_debug "Spinner Background Color: $spinner_bg_color"
        bashprog_debug "Debug: $debug"
        #bashprog_debug "Bar Background Color: $bar_bg_color"
        bashprog_debug "Pointer Color: $pointer_color"



        # Main logic based on mode
        case "$mode" in
            "bar")
                echo "Running in bar mode"
                # Bar mode logic here

                ;;
            "spinner")
                echo "Running in spinner mode"
                # Spinner mode logic here
                ;;
            "demo")
                echo "Running in demo mode"
                # Demo mode logic - perhaps show all themes or modes
                ;;
            *)
                echo "No mode specified. Use -b/--bar, -s/--spinner, or -dm/--demomode"
                show_help
                ;;
        esac
}

export -f bashprog