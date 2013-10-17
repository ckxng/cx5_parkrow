#!/bin/bash

cd src/ || exit 1;
find . -type d -exec mkdir -p ../lib/{} \;
find . -type f -name "*.js" -exec rm ../lib/{} \; 2>/dev/null
find . -type f -name "*.js" -exec ln -s `pwd`/{} ../lib/{} \;

