#!/bin/bash

cd src/ || exit 1;
find . -type d -exec mkdir -p ../doc/{} \;
find . -type f -name "*.litcoffee" -exec markdown_py -f ../doc/{}.html {} \;
find . -type f -name "*.md" -exec markdown_py -f ../doc/{}.html {} \;

