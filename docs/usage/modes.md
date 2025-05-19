---
title: Modes
layout: default
description: Modes for bashprog
keywords: ["mode"]
tags: ["mode"]
parent: Usage
nav_order: 2
---

# Modes

<p class="fs-6 fw-300 text-dusk-400">Bashprog offers three main modes, one submode, and one optional debug mode. </p>


{: .bar-mode }
Use the `--bar` mode to display progress bars. Can be combined with Demo mode and/or Debug mode

{: .spinner-mode }
Use the `--spinner` mode to display spinners. Can be combined with Demo mode and/or Debug mode

{: .demo-mode }
Use the `--demo` or `-d` mode to display a demonstration of spinner and bar themes. Can be combined with Spinner and Bar modes and/or Debug mode

{: .debug-mode }
Use the `--debug` or `-db` mode to enable debugging information output. Can be combined with Spinner and Bar modes and/or Demo mode. controlled via the `BPROG_DEBUG` environment variable (set to `1` to enable, `0` to disable)

<div class="text-right">
    <a href="{{ site.url }}/usage/color" class="btn">Using Color <box-icon name='caret-right-circle' size="xs" type='solid' color='#ffffff' ></box-icon></a>
</div>

<a href="{{ site.url }}/usage/modes#main-header" class=""><box-icon name='arrow-to-top' size="xs" type='solid' color='#ffffff' ></box-icon> Back to top</a>