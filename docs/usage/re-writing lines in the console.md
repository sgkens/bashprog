---
title: Re-Writing lines in the console
layout: default
nav_order: 6
parent: Usage
---

# Re-Writing lines in the console

<p class="fs-6 fw-300 text-dusk-400 alt-body-text">Need to clear the current or previous lines in the terminal?</p>

The `--rewrite` **switch** can be used the clear the current or previous lines in the terminal.

{: .info}
see: [`--rewrite`](https://github.com/sgkens/nashprog/blob/main/lib/clearlines.sh).sh bashprog `--rewrite`] calls the `clearlines` function to clear lines in the terminal

{: .note}
`--rewrite` uses the `printf` command to clear lines in the terminal

Example:

```bash
bashprog --bar --theme --barcolor red --barbgcolor green braille 75 30
bashprog --rewrite 1 # clears the current line
```

<div class="text-right">
    <a href="{{ site.url }}/themes/custom-themes" class="btn">Themes <box-icon name='caret-right-circle' size="xs" type='solid' color='#ffffff' ></box-icon></a>
    <a href="{{ site.url }}/themes/custom-themes" class="btn">Custom Themes <box-icon name='caret-right-circle' size="xs" type='solid' color='#ffffff' ></box-icon></a>
</div>

<a href="{{ site.url }}/usage/loops#main-header" class=""><box-icon name='arrow-to-top' size="xs" type='solid' color='#ffffff' ></box-icon> Back to top</a>