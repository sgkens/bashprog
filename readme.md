<div align="center">
  <img src="https://raw.githubusercontent.com/phellams/phellams-general-resources/main/logos/bprog/dist/svg/bprog-128x128.svg" alt="bprog" width="128" height="128">
  <H1>BashProg</H1>
  <p>A simple bash module to display progress bars and spinners, using the ascii-advanced and optionally utf-8 symbols.</p>

  <code>◉━◉━◉━◉◯◯◯◯◯ 40% </code>
</div> 

# Readme for [BashProg](https://github.com/sgkens/bprog)
 - git readme houses build details and basic usage 
 - gitlab pages house the full documentation

### ✨ Features

- Generate **progress-bars** and **spinners** 
  - Supports multiple spinners and progress-bars themes running in parallel.
  - Theme files are cached in memory on theme load to improve performance, and minimize the number of times the theme file is read from disk.
- Supports `24-bit` color ranges
- Supports `256-bit` color ranges with optional flag `--c256`, most modern terminals support 256 but not all.
- Supports multiple themes
- Supports custom themes via JSON files

### ⭕ Requirments:
 - `jq` command line tool (https://stedolan.github.io/jq/)
 - `bash` **v5.7** or higher

### ⚒️ Installation

Clone the repo and source the `bashprog.sh`.

```bash
# clone the repo to your local machine
git clone https://github.com/sgkens/bprog.git
cd froglet

# source the bashprog.sh entry file
source /path/to/bprog/bashprog.sh
```

### Build

Build the `bashprog` script by running the `build.sh` script.

### 🖥️ Using the `bashprog` command

#### Generating Progress Bars

⚗️ Output a progress bar using the `braille` theme.

```bash
# long form
bashprog --bar --theme braille 75 30
# short form
bashprog -b -t braille 75 30
```

🔻 Output:

<pre>
◉━◉━◉━◉◯◯◯◯◯ 40% 
</pre>


⚗️ Output a progress bar with the braille theme add `barcolor` and `barbgcolor`.

```bash
bashprog -b -t braille -p 75 -w 30 -bc red -bbg black
```

⚗️ Output a progress bar with all options

```bash
bprog -b -t braille -p 75 -w 30 \
-bc red -bbg black -ptc green -bop white -bco blue -pc yellow -v
```

#### Loading Spinners

⚗️ Output a spinner with the bits theme

```bash
bprog -s -t bits -m "Loading..."
```
⚗️ Output a spinner with the bits theme with `spinnercolor`

```bash
bprog -s -t bits -m "Loading..." -sc red
```

⚗️ Output a spinner with all options

```bash
bprog -s -t bits -m "Loading..." -sc red -v
```

#### Modes

Bashprog has three modes: `Bar`, `Spinner`, and `Demo`.

▫️ **Bar mode** is used to display progress bars `--bar`. \
▫️ **Spinner mode** is used to display spinners `--spinner`. \
▫️ **Demo mode** is used to display a demo of the spinner and bar themes `--demomode`.

#### Debug Mode

`--debug` is used to enable debug **mode**. This will output debug messages to the console.

```bash
bashprog --bar braille 75 30 --debug --demo
```

## Param Switches


> Modes -> Bar, Spinner, Demo
> Themes -> Bar, Spinner

Logic 
  - set local variable for $MODE, $TYPE, $THEME
  - switch case for $MODE
    - switch case inside of switch case for $TYPE

<pre>
bashprog [options] [theme] [[percent] [width] [message] | [message]]
  options:
  -h, --help            Display this help message
  -d, --debug           Debug mode
  -b, --bar             Display a progress bar
  -s, --spinner         Display a spinner
  -t, --theme           Theme name
  -dm, --demomode       Demo mode
  -bc, --barcolor       Bar color
  -bbg, --barbgcolor    Bar background color
  -ptc, --pointercolor  Pointer color
  -bop, --baropencolor  Bar open color
  -bco, --barclosecolor Bar close color
  -pc, --percentcolor   Percent color
  -v, --verbose         Verbose mode
  -d, --debug           Debug mode
</pre>

## 🧦 Themes

Theme files are in the format of  a **JSON** _Object_ and are located in the `themes` directory. themes consist of mostly ASCII+Advanced characters and some utf-8 symbols with some mixed together.

#### Bar Themes

Bar themes are located in the `themes/bars` directory and are named `themename.json`.

> 🐦 Note!
> `open`, `close`, `complete`, `incomplete`, `description` are not required properties.
> `❗theme` is a required property

