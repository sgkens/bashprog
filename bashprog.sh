#!/bin/bash
# =========================
# Define the bprog installation directory
# This can be overridden by setting FROGLET_HOME environment variable
# Source the parent directory of the script
# =========================

: "${BPROG_HOME:=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )}"

bprog_debug "bprog_HOME: $BPROG_HOME"

# Set the default debug mode
BPROG_DEBUG=1 # default is 0, set with bprog_set_debug 1 or bprog with --debug flag

# Import the necessary libraries
source ${BPROG_HOME}/lib/bprog-utils.sh

# import utility functions
bprog_load_module "clearlines"
bprog_load_module "colortext"
