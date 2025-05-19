---
title: Multi-Theme Generation
layout: default
description: Multi-Theme Generation
keywords: ["multi-theme"]
tags: ["multi-theme"]
has_children: true
parent: Usage
nav_order: 4
---

# Multi-Theme Generation
<p class="fs-6 fw-300 text-dusk-400">Bashprog supports generating multiple bar and spinner themes simultaneously by using command substitution within `$()` blocks.</p>


## Basic Usage

Generate and combine multiple themes in a single command:


```bash
#!/bin/bash
echo "generating themes"
bar=$(bashprog --bar --theme braille 75 30 --barcolor red --barbgcolor green)
spinner=$(bashprog --spinner --theme angles)
echo -n "${spinner}${bar}"
```

## Dynamic Updates

Use with a `while|until|select|for` loop and the `--rewrite` command to dynamically update the progress bar and spinner themes.

{: .note }
The `--rewrite` command is used to clear the current line in the terminal.
see [clearlines](/getting-started/clearlines) clearlines for more information on clearing terminal lines

```bash
#!/bin/bash
while true; do
    echo "generating themes"
    bar=$(bashprog --bar --theme braille 75 30 --barcolor red --barbgcolor green)
    spinner=$(bashprog --spinner --theme angles)
    echo -n "${spinner}${bar}"
    bashprog --rewrite 2
done
```

See [clearlines on gitlab](/getting-started/clearlines) for more information on clearing terminal lines.