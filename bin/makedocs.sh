#!/bin/bash

cd src/ || exit 1;
find . -type d -exec mkdir -p ../doc/{} \;
find . -type f -name "*.litcoffee" -exec markdown_py -f ../doc/{}.html {} \;
find . -type f -name "*.md" -exec markdown_py -f ../doc/{}.html {} \;

cd ../doc || exit 1
for f in `find * -type f -name "*.html"`; do
  cp $f $f.tmp
  cat .head.html $f.tmp .foot.html >$f
  rm $f.tmp
done

