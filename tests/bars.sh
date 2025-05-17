    #!/bin/bash

# =========================

source ./froglet.sh

declare -a themes 

theme_files_list=$(ls $FROGLET_HOME/themes/bars/*.json | xargs -n1 basename | sed 's/\.json//')

themes+=(${theme_files_list})

for theme in "${themes[@]}"; do
    froglet_use_bar_theme $theme
    echo "Progress: $(froglet_bar 30 30) Theme: $theme "
done