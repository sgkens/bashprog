#!/bin/bash

# remove old SVG files
rm -rf ./docs/_includes/svgs/bars/*.svg
# remove old markdown files except for index.md
rm -rf ./docs/themes/bars/*/index.md
# remove bar/index.md
rm -rf ./docs/themes/bars/index.md

# large param array
declare -a large_param_array=()

bar_svg_example_md_generator() {
    counter=0
    # Loop through all parameters
    local theme_name=${large_param_array[0]}
    local empty_char=${large_param_array[1]}
    local empty_color=${large_param_array[2]}
    local fill_char=${large_param_array[3]}
    local fill_color=${large_param_array[4]}
    local pointer_char=${large_param_array[5]}
    local pointer_color=${large_param_array[6]}
    local opening_char=${large_param_array[7]}
    local opening_color=${large_param_array[8]}
    local closing_char=${large_param_array[9]}
    local closing_color=${large_param_array[10]}
    local percentage_color=${large_param_array[11]}


    # bash multi-line string
local svg_theme=$(cat <<EOF
<svg id="${theme_name}_svg" viewBox="0 0 410 85" xmlns="http://www.w3.org/2000/svg">
  <!-- Background rectangle -->
  <rect width="100%" height="100%" fill="#1e1e1e"/>
  
  <!-- Progress bar container - with fixed positions -->
  <text font-family="monospace" font-size="20" font-weight="bold">
    <!-- Opening bracket - fixed position -->
    <tspan x="20" y="40" id="${theme_name}_progressOpen" fill="${opening_color}">${opening_char}</tspan>
    
    <tspan x="35" y="40">
      <tspan id="${theme_name}_progressFill" fill="${fill_color}">${fill_char}</tspan><tspan id="${theme_name}_progressEmpty" fill="${empty_color}">${empty_char}</tspan>
    </tspan>
    
    <!-- Closing bracket - fixed position -->
    <tspan x="338" y="40" id="${theme_name}_progressClose" fill="${closing_color}">${closing_char}</tspan>
    
    <!-- Percentage display - fixed position -->
    <tspan x="355" y="40" id="${theme_name}_percentDisplay" fill="${percentage_color}">0%</tspan>
  </text>

  <!-- pointer hidden outside element as it calulated after the svg is loaded -->
  <tspan opacity="0" id="_hidden_${theme_name}_progressPointer">${pointer_char}</tspan>
  <tspan opacity="0" id="_hidden_${theme_name}_progressOpen">${opening_char}</tspan>
  <tspan opacity="0" id="_hidden_${theme_name}_progressClose">${closing_char}</tspan>
  <tspan opacity="0" id="_hidden_${theme_name}_progressFill">${fill_char}</tspan>
  <tspan opacity="0" id="_hidden_${theme_name}_progressEmpty">${empty_char}</tspan>
  <tspan opacity="0" id="_hidden_${theme_name}_percentColor">${percentage_color}</tspan>

  <!-- Restart button -->
  <g id="${theme_name}_restartButton" opacity="1" cursor="pointer">
    <rect x="20" y="50" width="80" height="25" rx="5" ry="5" fill="#4CAF50" />
    <text x="60" y="67" font-family="Arial" font-size="14" fill="white" text-anchor="middle">Animate</text>
  </g>
</svg>
EOF
    )
    # Print the SVG file path
    echo "$svg_theme" > "./docs/_includes/svgs/bars/${theme_name}.svg"
}


# =======================================================================
# function bar_svg_example_md_generator
# =======================================================================
# Description:
#   Generates an SVG progress bar example with animation output for each theme in the bars directory.
#   Generates a markdown file for each theme with detailed information.
#   The SVG file contains a progress bar with customizable characters, colors, and a pointer.
#   The generated SVG files are saved in the docs/assets/images/bars directory.
#   The function uses the jq command to extract values from the JSON theme files.
#   The function also uses the clstring and bkvp libraries for string manipulation and key-value pair formatting.
#   The function is called by the make_svg_bar_examples function.
# Arguments:
#   $1 - Theme name (string)
#   $2 - Empty character (string)
#   $3 - Fill character (string)
#   $4 - Empty color (string)
#   $5 - Fill color (string)
#   $6 - Pointer character (string)
#   $7 - Pointer color (string)
#   $8 - Opening character (string)
#   $9 - Closing character (string)
#   $10 - Percentage color (string)
# Returns:
#   None
# Example usage:
#   bar_svg_example_md_generator "example_theme" "#" "=" "#CCCCCC" "#00FF00" ">" "#FF0000" "[" "]" "#0000FF"
# =======================================================================

make_svg_bar_examples() {
    # bar themes yaml header
    # used to generate the index.md file header
    bar_themes_yaml_header=$(cat <<EOF
---
title: "Bars"
description: "List of all the bar themes."
keywords: ["bar"]
tags: ["bar"]
layout: default
nav_order: 1
parent: Themes
---

## Bar Themes

EOF
      )
    echo "$bar_themes_yaml_header" > "./docs/themes/bars/index.md"

    for theme in $(ls ./themes/bars/*.json); do
        local theme_name=$(basename "$theme" .json)
        local theme_svg_file="_includes/bars/$theme_name.svg"

        # elements from
        local empty_char=$(cat "$theme" | jq -r '.incomplete')
        local fill_char=$(cat "$theme" | jq -r '.complete')
        local pointer_char=$(cat "$theme" | jq -r '.pointer')
        local open_char=$(cat "$theme" | jq -r '.open')
        local close_char=$(cat "$theme" | jq -r '.close' )
        local description=$(cat "$theme" | jq -r '.description')
        local types=$(cat "$theme" | jq -r '.types | join(", ")')

        # capitalize the theme name
        capitalized="${theme_name^}"

        # Json theme file contents
        theme_json_contents=$(cat "$theme" | jq -r)


        # color list
        colors=("white" "blue" "green" "yellow" "magenta" "cyan")

        # random colors for elements
        random_open_close_color_index=$(( RANDOM % ${#colors[@]} ))
        random_percent_color_index=$(( RANDOM % ${#colors[@]} ))
        random_fill_color_index=$(( RANDOM % ${#colors[@]} ))
        random_empty_color_index=$(( RANDOM % ${#colors[@]} ))
        random_pointer_color_index=$(( RANDOM % ${#colors[@]} ))

        open_color="${colors[$random_open_close_color_index]}"
        close_color="${colors[$random_open_close_color_index]}"
        percentage_color="${colors[$random_percent_color_index]}"
        fill_color="${colors[$random_fill_color_index]}"
        empty_color="${colors[$random_empty_color_index]}"
        pointer_color="${colors[$random_pointer_color_index]}"

        # generate the SVG file
        echo "Generating SVG: $(clstring ${theme_svg_file} cyan) for $(bkvp ${theme_name}, "./themes/bars/${theme_name}.json")"
        
        # bar_svg_example_md_generator
        # uses and external array to pass the parameters
        # to the function as bash does not support passing arrays
        # to functions or params with count greater than 10
        # without impoying a split switch statement
        large_param_array[0]="$theme_name"
        large_param_array[1]="$empty_char"
        large_param_array[2]="$empty_color"
        large_param_array[3]="$fill_char"
        large_param_array[4]="$fill_color"
        large_param_array[5]="$pointer_char"
        large_param_array[6]="$pointer_color"
        large_param_array[7]="$open_char"
        large_param_array[8]="$open_color"
        large_param_array[9]="$close_char"
        large_param_array[10]="$close_color"
        large_param_array[11]="$percentage_color"
        bar_svg_example_md_generator

        # generate markdown file for the theme
        markdown_theme=$(cat <<EOF

## <span class="text-color-yellow"><a href="{{ site.url }}/themes/bars/${theme_name}/">${capitalized}</a></span>

<p class="fs-6 fw-300 text-dusk-400">${description}</p>

{% include svgs/bars/${theme_name}.svg %}
EOF
      )

        # generate markdown file for the theme with detailed information
        markdown_theme_detailed=$(cat <<EOF
---
title: "${theme_name}"
description: "${description}"
keywords: ["bar", "${theme_name}"]
tags: ["bar", "${theme_name}"]
layout: default
parent: Bars
---

#  {{ page.title | capitalize }}


<p class="fs-6 fw-300 text-oceanblue-200 alt-body-text">${description}</p>

**--demo**

{% include svgs/bars/${theme_name}.svg %}

---

### **Three modes available when using the bar mode:**

{: .bar-mode}
Switch \`--bar\` or \`-b\` to call the progress bar generator.

<pre>
bashprog [options] [theme] [width] [percentage] [message]
  Options:
    -b|--bar
</pre>


{: .demo-mode}
Switch \`--demo\` or \`-d\` to show a animated demo of the progress bar.

<pre>
bashprog [options] [theme] [width] [percentage] [message]
  Options:
    -d|--demo
</pre>

{: .debug-mode}
Switch \`--debug\` or \`-db\` to show debug information. Set \`BPROG_DEBUG\` to \`1\` enables output of debug information to console.

<pre>
bashprog [options] [theme] [width] [percentage] [message]
  Options:
    -db|--debug
</pre>

**⚡ Examples**

Display the ${theme_name} progress bar theme with a width of \`50\` and a percentage of \`30\`.
\`\`\`bash
bashprog --bar --theme ${theme_name} 50 30
\`\`\`

Demo the ${theme_name} progress bar theme with a width of \`50\` and a percentage of \`30\`.
\`\`\`bash
bashprog --demo --bar --theme ${theme_name} 50 30
\`\`\`

Debug the ${theme_name} progress bar theme with a width of \`50\` and a percentage of \`30\`.
\`\`\`bash
bashprog --debug --bar --theme ${theme_name} 50 30
\`\`\`

**<box-icon type='solid' color="#ffffff" name='file-json'></box-icon> JSON:** [themes/bars/arrowflow.json](https://github.com/sgkens/bashprog/blob/main/themes/bars/${theme_name}.json)

\`\`\`json
${theme_json_contents}
\`\`\`

<span class="text-color-yellow">Character Type:</span>

$(for type in $types; do echo "- $type"; done)

EOF
      )
        echo "Generating SVG: $(clstring "Detailed Markdown" cyan) for $(bkvp ${theme_name}, "./docs/themes/bars/${theme_name}.md")"
        # add the markdown to the bars.md index file
        echo "$markdown_theme" >> "./docs/themes/bars/index.md"
        # generate markdown file for the theme with detailed information
        echo "Generating SVG: $(clstring "Markdown" cyan) for $(bkvp ${theme_name}, "./docs/themes/bars/${theme_name}.md")"
        # create the directory if it doesn't exist
        mkdir -p "./docs/themes/bars/${theme_name}"
        echo "$markdown_theme_detailed" > "./docs/themes/bars/${theme_name}/index.md"

    done
}
