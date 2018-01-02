#!/bin/sh
find '.' -iname "*.tif" -maxdepth 1 -type f -exec /book/convert-destaple.sh {} \;