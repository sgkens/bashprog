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
# =======================================================================                                                                       


# initialize the BPROG_HOME variable
: "${BPROG_HOME:=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )}"

# Set the default debug mode
BPROG_DEBUG=1 # default is 0, set with bprog_set_debug 1 or bprog with --debug flag

# Import the necessary libraries
source ${BPROG_HOME}/lib/bprog-core.sh

bprog_debug "BPROG_HOME: $BPROG_HOME"
