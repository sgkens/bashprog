---
title: Color
layout: default
parent: Usage
nav_order: 3
---

# Using Color

<p class="fs-6 fw-300 text-dusk-400">Bashprog supports the default terminal color range and 256-bit color ranges.</p>


**24-bit Color Range**
  - <span class="text-dusk-000">Default Range</span>: (<span class="text-color-blue">blue</span>, <span class="text-color-green">green</span>, <span class="text-color-red">red</span>, <span class="text-color-yellow">yellow</span>, <span class="text-color-magenta">magenta</span>, <span class="text-color-cyan">cyan</span>,<span class="text-color-white">white</span>, <span class="text-color-gray">gray</span>, <span class="text-color-black">black</span>)
  - <span class="text-dusk-000">Bright Range</span>: (<span class="text-color-bright-blue">blue</span>, <span class="text-color-bright-green">green</span>, <span class="text-color-bright-red">red</span>, <span class="text-color-bright-yellow">yellow</span>, <span class="text-color-bright-magenta">magenta</span>, <span class="text-color-bright-cyan">cyan</span>,<span class="text-color-white">white</span>, <span class="text-color-gray">gray</span>, <span class="text-color-black">black</span>)

**256-bit color range** (`Work-In-Progress`)

## Generating Progress Bars with Color

**Example**: 

Output a progress bar with the `barcolor` and `barbgcolor` switches.

```bash
# long form
bashprog --bar --theme braille 75 30 --barcolor red --barbgcolor green
# short form
bashprog -b -t braille 75 30 -bc red -bbg green
```

## 24-bit Color Range support

Color codes are based on the [ANSI escape code](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors) for terminals.

{: .info}
`24-bit` color range is supported by most modern terminals. It is also supported by some older terminals.

| Bashprog color Code        | ASCII Code | Example                                                     | Description    |
| -------------- | ---- | ----------------------------------------------------------- | -------------- |
| magenta        | 5    | <span class="text-color-magenta">████████████</span>        | `24-bit` Magenta         |
| blue           | 4    | <span class="text-color-blue">████████████</span>           | `24-bit` blue           |
| yellow         | 3    | <span class="text-color-yellow">████████████</span>         | `24-bit` yellow         |
| green          | 2    | <span class="text-color-green">████████████</span>          | `24-bit` green          |
| red            | 1    | <span class="text-color-red">████████████</span>            | `24-bit` red            |
| cyan           | 6    | <span class="text-color-cyan">████████████</span>           | `24-bit` Cyan           |
| black          | 0    | <span class="text-color-black">████████████</span>          | `24-bit` black          |
| white          | 15   | <span class="text-color-white">████████████</span>           | `24-bit` white          |
| gray           | 8    | <span class="text-color-gray">████████████</span>           | `24-bit` gray           |
| bright_gray    | 8    | <span class="text-color-bright-gray">████████████</span>    | `24-bit` Bright gray    |
| bright_cyan    | 14   | <span class="text-color-bright-cyan">████████████</span>    | `24-bit` Bright cyan    |
| bright_red     | 9    | <span class="text-color-bright-red">████████████</span>     | `24-bit` Bright red     |
| bright_green   | 10   | <span class="text-color-bright-green">████████████</span>   | `24-bit` Bright green   |
| bright_yellow  | 11   | <span class="text-color-bright-yellow">████████████</span>  | `24-bit` Bright yellow  |
| bright_blue    | 12   | <span class="text-color-bright-blue">████████████</span>    | `24-bit` Bright blue    |
| bright_magenta | 13   | <span class="text-color-bright-magenta">████████████</span> | `24-bit` Bright magenta |


## 256-bit Color Range (`Work-In-Progress`)

256-bit color range is supported by some modern terminals. It is not supported by all terminals.



🔻 Output:

# link svg spinner and bar example here

<div class="text-right">
    <a href="{{ site.url }}/usage/multi-theme-generation" class="btn"> Multi-Theme Generation <box-icon name='caret-right-circle' size="xs" type='solid' color='#ffffff' ></box-icon></a>
</div>

<a href="{{ site.url }}/usage/using-color#main-header" class=""><box-icon name='arrow-to-top' size="xs" type='solid' color='#ffffff' ></box-icon> Back to top</a>