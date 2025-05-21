#!/bin/bash
# =======================================================================                                      
#      .                              
#    @@@@@.                   -@@@*   
#   %@@.  @%                .@@-%@@*  
#  #@@     #%              %@    #@@+ 
#  #@=      # .          :-*      #@% 
#   @#       %  @@@@@@@* =#       :@: 
#   .@=     #  *@@@@@@@@  *-     .@#  
#     @@   #  -@@@@@@@@@@  %.   *@.   
#       %%@   @@@@@@@@@@@@  %@@@:     
#        #   @@@@@@@@@@@@@@  @        
#       #                     @       
#          @@@@@@@@@@@@@@@@@@  @      
#         @@@@@@@@@@@@@@@@@@@@        
#        @@@@@@@@@@@@@@@@@@@@@@       
#        BASH PROG @@@#@@@ @@@#@                                  
#                   ...:::---==+      
# ==============================   
# Main Entry Point
# This script is the main entry point for the BashProg library.
# =======================================================================                                                                       

# initialize the BPROG_HOME variable
: "${BPROG_HOME:=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )}"
: "${BPROG_VERSION:="v$(cat ${BPROG_HOME}/VERSION)"}"

# Set the default debug mode
BPROG_DEBUG=1 # default is 0, set with bprog_set_debug 1 or bprog with --debug flag

# Dependancies
# Import the necessary libraries
source ${BPROG_HOME}/lib/bkvp.sh
source ${BPROG_HOME}/lib/clstring.sh
source ${BPROG_HOME}/lib/bprog-core.sh

bprog_debug "BPROG_HOME: $BPROG_HOME"