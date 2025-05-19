---
title: Install
layout: default
description: Installing bashprog
keywords: ["install"]
tags: ["install"]
parent: Usage
nav_order: 1
---

# Installation

<p class="fs-6 fw-300 text-dusk-400 alt-body-text">Importing bashprog into your project</p>

Bashprog can be installed from source or pre-built release packages (zip/tar.gz).

## Release Packages

Download the latest release from the [releases page](https://github.com/sgkens/bprog/releases) and source the `entry.sh` file.

### Using wget

```bash
# Download Release from https://github.com/sgkens/bprog/releases
wget https://github.com/sgkens/bprog/releases/download/v1.0.0/bashprog.zip
source ./bashprog/entry.sh # source the bashprog.sh entry script
```

### Using curl

```bash
# Download Release from https://github.com/sgkens/bprog/releases
curl -L https://github.com/sgkens/bprog/releases/download/v1.0.0 -o bashprog
source ./bashprog/entry.sh # source the bashprog.sh entry script
```

## From Source

Clone the repository and source the `entry.sh` file.

### Using Git

```bash
# source
git clone https://github.com/sgkens/bprog.git
source path/to/bprog/entry.sh # source the bashprog.sh entry script
```
<div class="text-right">
    <a href="{{site.url}}/usage/modes" class="btn">Different Modes <box-icon name='caret-right-circle' type='solid' color='#ffffff' ></box-icon></a>
</div>