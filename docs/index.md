---
title: Home
layout: home
description: Home
keywords: ["home"]
tags: ["home"]
nav_order: 1
---

<img src="/assets/images/bashprog-logo+text.png" alt="bashprog">


<p class="fs-6 fw-300 text-dusk-400  alt-body-text">
    <b class="text-oceanblue-400">Spinners</b>,
    <b class="text-oceanblue-400">Loaders</b>, and
    <b class="text-oceanblue-400">Progress Bars</b>  for bash
</p>

{% include svgs/bars/blocks.svg %}

<pre>Version: <b> v0.2.1</b></pre>

**Bashprog** is a bash module that provides a simple way to display progress [**bars**][link-bars] and [**spinners**][link-spinners]. It supports multiple [**themes**][link-themes] and can be used in conjunction with other bash modules to create more complex progress bars and spinners.

## Simple Installation and Usage

> See [Getting Started](/usage/install) for detailed instructions on how to use bashprog

### Source with Git

```bash
# Github
git clone https://github.com/sgkens/bashprog.git
# gitlab
git clone https://gitlab.com/sgken/bashprog.git
```
### Import with source

```bash
source ./bashprog/entry.sh
```

### Display a Progress Bar

```bash
bashprog --bar --theme braille 75 30
```

<a href="{{site.url}}/usage/" class="btn btn fs-4">Getting Started</a>
<a href="{{site.url}}/releases/" class="btn btn fs-4">Themes</a>
<a href="{{site.url}}/releases/" class="btn btn fs-4">Releases</a>

[GitHub Pages / Actions workflow]: https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/
[link-spinners]: themes/spinners/index.html
[link-bars]: themes/bars/
[link-themes]: themes/
[link-usage]: usage/index.html
[link-getting-started]: getting-started/index.html
[color-link]: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors