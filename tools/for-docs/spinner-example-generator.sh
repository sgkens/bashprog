#!/bin/bash

# remove old SVG files
rm -rf ./docs/_includes/svgs/spinners/*.svg
# remove old markdown files except for index.md
rm -rf ./docs/themes/spinners/*/index.md

# large param array
declare -a large_param_array=()

spinner_svg_example_md_generator() {
    # Extract parameters from the array
    local theme_name=${large_param_array[0]}
    local frames_json=${large_param_array[1]}
    local spinner_color=${large_param_array[2]}
    local complete_char=${large_param_array[3]}
    local complete_color=${large_param_array[4]}
    local text_color=${large_param_array[5]}
    
    # Parse frames from JSON array
    frames=()
    # Remove brackets from JSON array and split by commas
    frames_string=$(echo "$frames_json" | sed 's/^\[//;s/\]$//;s/,/ /g')
    # Read frames into array, handling quotes
    eval "frames=($frames_string)"
    
    # Basic SVG for spinner with animation
    local svg_theme=$(cat <<EOF
<svg viewBox="0 0 300 90" xmlns="http://www.w3.org/2000/svg">
  <!-- Background rectangle -->
  <rect width="100%" height="100%" fill="#28272c"/>
  
  <!-- Spinner container -->
  <g>
    <!-- Spinner character - animated via JS -->
    <text id="${theme_name}_spinner" x="30" y="45" font-family="monospace" font-size="24" font-weight="bold" fill="${spinner_color}">${frames[0]}</text>
    
    <!-- Complete character - shown when complete -->
    <text id="${theme_name}_complete" x="30" y="45" font-family="monospace" font-size="24" font-weight="bold" fill="${complete_color}" opacity="0">${complete_char}</text>

    <!-- Status text -->
    <text id="${theme_name}_status" x="60" y="45" font-family="monospace" font-size="18" fill="${text_color}">Processing...</text>
  </g>

  <!-- Control button -->
  <g id="${theme_name}_startButton" opacity="1" cursor="pointer">
    <rect id="${theme_name}_startButtonRect" x="20" y="60" width="100" height="25" rx="5" ry="5" fill="blue" />
    <text id="${theme_name}_startButtonText" x="70" y="77" font-family="Arial" font-size="14" fill="white" text-anchor="middle">Start</text>
  </g>

  <!-- frames invisible string array -->
  <text id="${theme_name}_frames" x="30" y="45" font-family="monospace" font-size="24" font-weight="bold" fill="${spinner_color}" opacity="0">
    $(counter=0; for frame in "${frames[@]}"; do echo "<tspan id="${counter}">${frame}</tspan>"; counter=$((counter+1)); done)
  </text>
  
</svg>
EOF
    )
    
    # Save the SVG file
    echo "$svg_theme" > "./docs/_includes/svgs/spinners/${theme_name}.svg"
}

# =======================================================================
# function make_svg_spinner_examples
# =======================================================================
# Description:
#   Generates SVG spinner examples with animation for each theme in the spinners directory.
#   Generates a markdown file for each theme with detailed information.
#   The SVG file contains a spinner with customizable frames and a complete character.
#   The generated SVG files are saved in the docs/_includes/svgs/spinners directory.
#   The function uses the jq command to extract values from the JSON theme files.
#   The function also uses the clstring and bkvp libraries for string manipulation and key-value pair formatting.
# Returns:
#   None
# Example usage:
#   make_svg_spinner_examples
# =======================================================================

make_svg_spinner_examples() {
    # Create directory if it doesn't exist
    mkdir -p "./docs/_includes/svgs/spinners"
    # Create index file for spinners
    echo "---
title: \"Spinners\"
description: \"Animated spinner indicators\"
keywords: [\"spinner\"]
tags: [\"spinner\"]
layout: default
has_children: true
nav_order: 2
parent: Themes
---

# Spinner Themes

Below are the available spinner themes for bashprog:

" > "./docs/themes/spinners/index.md"

    for theme in $(ls ./themes/spinners/*.json); do
        local theme_name=$(basename "$theme" .json)
        local theme_svg_file="_includes/svgs/spinners/$theme_name.svg"

        # Extract elements from the theme JSON
        local frames=$(cat "$theme" | jq -r '.frames')
        local complete_char=$(cat "$theme" | jq -r '.complete')
        local description=$(cat "$theme" | jq -r '.description')
        local types=$(cat "$theme" | jq -r '.types | join(", ")')

        # Capitalize the theme name
        capitalized="${theme_name^}"

        # JSON theme file contents
        theme_json_contents=$(cat "$theme" | jq -r)

        # Colors - select a random color for spinner
        colors=("white" "red" "green" "blue" "yellow" "magenta" "cyan")
        colors_index=$(( RANDOM % ${#colors[@]} ))
        random_color="${colors[$colors_index]}"
        complete_color="green"
        text_color="white"

        # Generate the SVG file
        echo "Generating SVG: $(clstring ${theme_svg_file} cyan) for $(bkvp ${theme_name}, "./themes/spinners/${theme_name}.json")"
        
        large_param_array[0]="$theme_name"
        large_param_array[1]="$frames"
        large_param_array[2]="$random_color"
        large_param_array[3]="$complete_char"
        large_param_array[4]="$complete_color"
        large_param_array[5]="$text_color"
        spinner_svg_example_md_generator
    
        # Generate markdown file for the theme (index)
        markdown_theme=$(cat <<EOF
## <span class="text-color-yellow"><a href="{{ site.url }}/themes/spinners/${theme_name}/">${capitalized}</a></span>

{% include svgs/spinners/${theme_name}.svg %}
EOF
        )

        # Generate detailed markdown file for the theme
        markdown_theme_detailed=$(cat <<EOF
---
title: "${theme_name}"
description: "${description}"
keywords: ["spinner", "${theme_name}"]
tags: ["spinner", "${theme_name}"]
layout: default
parent: Spinners
---

# {{ page.title | capitalize }}

<p class="fs-6 fw-300 text-dusk-400">${description}</p>

**--demo**

{% include svgs/spinners/${theme_name}.svg %}

### **Three modes available when using the spinner mode:**

{: .label .label-green }
Spinner

{: .label .label-blue }
Demo

{: .label .label-yellow }
Debug

---

{: .spinner-mode}
Switch \`-s\` or \`--spinner\` to call the spinner function. 

<pre>
bashprog [options] [theme] [message]
  Options:
    -s|--spinner
</pre>

\`\`\`bash
# long form
bashprog --spinner --theme ${theme_name}
# short form
bashprog -s -t ${theme_name}
\`\`\`

{: .demo-mode}
\`[-d|--demo]\` Switch to show an animated demo of the spinner.

\`\`\`bash
# long form
bashprog --demo --theme ${theme_name} --mode spinner
# short form
bashprog -d -t ${theme_name} -m spinner
\`\`\`

{: .debug-mode}
\`[-db|--debug]\` Switch to show debug information, Switch set \`BPROG_DEBUG\` to \`1\` enables output of debug information to console.


\`\`\`bash
# long form
bashprog --debug --spinner --theme ${theme_name}
# short form
bashprog -db -s -t ${theme_name}
\`\`\`

**⚡ Command:**

\`\`\`bash
# long form
bashprog --spinner --theme ${theme_name} "Processing please wait..."
# short form
bashprog -s -t ${theme_name} "Processing please wait..."
\`\`\`

<span class="text-color-cyan">Other Modes:</span>

**🏐 JSON:** [themes/spinners/${theme_name}.json](https://github.com/sgkens/bashprog/blob/main/themes/spinners/${theme_name}.json)

\`\`\`json
${theme_json_contents}
\`\`\`

<span class="text-oceanblue-400">Character Type:</span>

$(for type in $types; do
    if [[ $type == "ASCII" ]]; then
        echo "{: .label .label-green }"
        echo "$type"; 
    elif [[ $type == "ASCII-Extended" ]]; then
        echo "{: .label .label-yellow }";
        echo "$type"; 
    elif [[ $type == "ASCII-Advanced" ]]; then
        echo "{: .label .label-red }";
        echo "$type";
    elif [[ $type == "unicode-emojis" ]]; then
        echo "{: .label .label-red }"
        echo "$type";
    else
        echo "{: .label .label-blue }";
        echo "$type"; 
    fi
done)

EOF
        )
        
        echo "Generating Markdown: $(clstring "Detailed Markdown" cyan) for $(bkvp ${theme_name}, "./docs/themes/spinners/${theme_name}.md")"
        # Append the markdown to the spinners.md index file
        echo "$markdown_theme" >> "./docs/themes/spinners/index.md"
        
        # Generate detailed markdown file for the theme
        echo "Generating Markdown: $(clstring "Markdown" cyan) for $(bkvp ${theme_name}, "./docs/themes/spinners/${theme_name}.md")"
        # Create the directory if it doesn't exist
        mkdir -p "./docs/themes/spinners/${theme_name}"
        echo "$markdown_theme_detailed" > "./docs/themes/spinners/${theme_name}/index.md"
    done
}

# Execute the spinner generator
#make_svg_spinner_examples