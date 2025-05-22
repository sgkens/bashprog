#!/bin/bash

source ./entry.sh

# should have an io operation
bprog_use_bar_theme "arrowflow"
bprog_add_theme_to_cache "arrowflow" "bar"
bprog_bar 10 100

# should not have an io operation
bprog_use_bar_theme "blocks"
bprog_add_theme_to_cache "blocks" "bar"
bprog_bar 10 100


# Shouldnt have an io operation
# pull from cache
bprog_get_theme_from_cache "arrowflow" "bar"
bprog_bar 10 100

# Shouldnt have an io operation
# pull from cache

bprog_get_theme_from_cache "blocks" "bar"
bprog_bar 10 100

# ==================================================================
# spinner themes
# ==================================================================
bprog_use_spinner_theme "angles"
bprog_add_theme_to_cache "angles" "spinner"
bprog_spinner
bprog_spinner_complete "Loading"

bprog_use_spinner_theme "steps"
bprog_add_theme_to_cache "steps" "spinner"
bprog_spinner
bprog_spinner_complete "Loading"

# Shouldnt have an io operation
# pull from cache
bprog_get_theme_from_cache "bits" "spinner"
bprog_spinner
bprog_spinner_complete "Loading"
# Shouldnt have an io operation
# pull from cache
bprog_get_theme_from_cache "steps" "spinner"
bprog_spinner
bprog_spinner_complete "Loading"

# ==================

# print the value of the cache assoc array 

# echo "bprog_bar_theme_cache: ${bprog_bar_theme_cache[@]}"
# # print the keys of the cache assoc array
# echo "bprog_bar_theme_cache keys: ${!bprog_bar_theme_cache[@]}"

# text assoc array with named keys
declare -A bprog_bar_theme_cache1

theme_name1="arrowflow"

bprog_bar_theme_cache1["${theme_name1}_theme"]="$theme_name"
bprog_bar_theme_cache1["${theme_name1}_open"]="["
bprog_bar_theme_cache1["${theme_name1}_close"]="]"
bprog_bar_theme_cache1["${theme_name1}_complete"]="#"
bprog_bar_theme_cache1["${theme_name1}_incomplete"]="-"
bprog_bar_theme_cache1["${theme_name1}_pointer"]=">"
bprog_bar_theme_cache1["${theme_name1}_description"]="Arrow flow theme"

# print the value of the cache assoc array
echo "bprog_bar_theme_cache: ${bprog_bar_theme_cache1[@]}"
echo "bprog_bar_theme_cache: ${!bprog_bar_theme_cache1[@]}"