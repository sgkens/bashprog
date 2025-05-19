---
title: Loops
layout: default
description: Implementing a progress bar inside a loop
keywords: ["loop"]
tags: ["loop"]
parent: Usage
nav_order: 5
---

# Loops

<p class="fs-6 fw-300 text-dusk-400 alt-body-text">Implementing a progress bar inside a loop is straightforward.</p>

Bashprog can be used in `for`, `while`, `until`, and `select` loops.

{: .info}
The [`--rewrite`][clearlines-link] switch is used to clear the current line or lines in the terminal.


## Loop Examples

### **_for_** loop

<span class="alt-body-text">Example:</span>

```bash
for i in {1..10}; do
    echo "Generating theme $((i+1)) of 10"
    bashprog --bar --theme braille 75 30 --barcolor red --barbgcolor green
    bashprog --rewrite 2 # clears the last 2 lines
done
```

### **_while_** loop

<span class="alt-body-text">Example:</span>

```bash
i=1
while [ $i -le 10 ]; do
    echo "Generating theme $i of 10"
    bashprog --bar --theme braille 75 30 --barcolor red --barbgcolor green
    i=$((i+1))
    bashprog --rewrite 2 # clears the last 2 lines
done
```

### **_until_** loop

<span class="alt-body-text">Example:</span>

```bash
i=1
until [ $i -gt 10 ]; do
    echo "Generating theme $i of 10"
    bashprog --bar --theme braille 75 30 --barcolor red --barbgcolor green
    i=$((i+1))
    bashprog --rewrite 2 # clears the last 2 lines
done
```

### **_select_** loop

<span class="alt-body-text">Example:</span>

```bash
select i in {1..10}; do
    echo "Generating theme $i of 10"
    bashprog --bar --theme braille 75 30 --barcolor red --barbgcolor green
    bashprog --rewrite 2 # clears the last 2 lines
done
```



[clearlines-link]: getting-started/clearlines.md