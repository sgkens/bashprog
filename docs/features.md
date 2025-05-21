---
title: Features
layout: default
description: "Features"
keywords: ["feature"]
tags: ["feature"]
has_children: false
nav_order: 1
---

# Features

<p class="fs-6 fw-300 text-dusk-400 alt-body-text">What can you do with bashprog?</p>

Provides a simple way to display progress [**bars**][link-bars] and [**spinners**][link-spinners]. It supports multiple [**themes**][link-themes] and can be used in conjunction with other bash modules to create more complex progress bars and spinners.

## Feature list

- Multiple [**bars**][link-bars] and [**spinners**][link-spinners].  themes running in parallel.
- Memory caching, Theme files are cached in memory on theme load to improve performance, and minimize the number of times the theme file is read from disk.
- Rewrite console lines using the `--rewrite` switch
- Color individial elements using the `--bc|barcolor`, `--bbg|barbgcolor`, `-pc|pointercolor`, `-pbg|pointerbgcolor`, `--boc|baropencolor`, `--bcc|barclosecolor`, `--pc|percentcolor` switches.
- Multiple bars and spinners running in parallel
- [**24-bit**][color-link] color ranges, standard terminals support 24 bit color.
- `256-bit` color ranges with optional flag `--c256`, most modern terminals support 256 but not all.
- Multiple themes.
- Custom themes via JSON files.

{: .dependancies }
[`jq`][jq] is required to use the `bashprog` command. Bashprog will install `jq` if not installed see `lib/bprog-core.sh` <- `CheckDependencies`

```bash
# apt
sudo apt install jq
# pacman
sudo pacman -S jq
# brew
brew install jq
# yum
sudo yum install jq
# zypper
sudo zypper install jq
```

{: .info }
BashProg can be sourced from any location.

## Getting Started

BashProg can be installed using the following command:

```bash
# source
git clone https://github.com/sgkens/bprog.git
source path/to/bprog/bashprog.sh # source the bashprog.sh entry script

# Use
bashprog --bar --theme braille 75 30
bashprog --spinner braille
```

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>


[^1]: [It can take up to 10 minutes for changes to your site to publish after you push the changes to GitHub](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site).

[Just the Docs]: https://just-the-docs.github.io/just-the-docs/
[GitHub Pages]: https://docs.github.com/en/pages
[GitHub Pages / Actions workflow]: https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/
[use this template]: https://github.com/just-the-docs/just-the-docs-template/generate
[jq]: https://stedolan.github.io/jq/
[link-spinners]: spinners/index.html
[link-bars]: bars/index.html
[link-themes]: themes/bars.html
[link-usage]: usage/index.html
[link-getting-started]: getting-started/index.html
[color-link]: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors