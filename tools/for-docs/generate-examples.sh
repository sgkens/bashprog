#! bin/bash
# bring in dependency libraries
source ./lib/clstring.sh
source ./lib/bkvp.sh

source ./tools/for-docs/bar-example-generator.sh
source ./tools/for-docs/spinner-example-generator.sh

make_svg_bar_examples
make_svg_spinner_examples