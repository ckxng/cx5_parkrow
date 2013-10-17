#!/bin/bash

cd src/ || exit 1;
find lib/ -type d -exec mkdir -p ../{} \;
find . -type f -name "*.js" -exec rm ../{} \; 2>/dev/null
find . -type f -name "*.js" -exec ln -s `pwd`/src/{} ../{} \;

