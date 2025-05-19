---
title: Custom Themes
layout: home
parent: Themes
description: Custom themes for bashprog.
keywords: ["theme", "custom"]
nav_order: 3
---

<br>
<box-icon name='doughnut-chart' size='lg' type='solid' color="#1db95b" ></box-icon>

# Custom Themes

<p class="fs-6 fw-300 text-dusk-400">Bashprog is built on modular json themes files.
</p>

Theme files are in the format of  a **JSON** _Object_ and are located in the `themes` directory. themes consist of mostly ASCII+Advanced characters and some utf-8 symbols with some mixed together.

## Bar Themes

Bar themes are located in the `themes/bars` directory and are named `themename.json`.

> 🐦 Note!
> `open`, `close`, `complete`, `incomplete`, `description` are not required properties.
> `❗theme` is a required property

🟣 **Example Bar Theme:**

```json
{
    "schema": "https://raw.githubusercontent.com/sgkens/bprog/main/themes/bars/schema.json",
    "theme": "boxedprogress",
    "description": "Solid blocks with light shading",
    "open": "[",
    "close": "]",
    "complete": "█",
    "incomplete": "░",
    "pointer": "▓"
}
```

## Spinner Themes

Spinner themes are located in the `themes/spinners` directory and are named `themename.json`.

🟣 **Example Spinner Theme:**

```json
{
    "theme": "bits",
    "description": "Bits spinning",
    "frames": [
        "■",
        "□",
        "▢",
        "▣",
        "▤",
        "▥"
    ],
    "complete": "✓"
}
```

#### Custom Themes

Create a new theme by creating a JSON file in the `themes/bars` or `themes/spinners` directory. The file name should be the theme name and the file extension should be `.json`.

🟣 **Example: Bar Theme**

```json
{
    "theme": "custom",
    "description": "Custom theme",
    "open": "[",
    "close": "]",
    "complete": "✓",
    "incomplete": "✗",
    "pointer": "✗",
    "example": "[✓✓✓✓✓✗✗✗✗✗] 50% Complete"
}
```

🟣 **Example: Spinner Theme**

```json
{
    "theme": "bits",
    "description": "Bits spinning",
    "frames": [
        "■",
        "□",
        "▢",
        "▣",
        "▤",
        "▥"
    ],
    "complete": "✓"
}
```