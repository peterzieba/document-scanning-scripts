#!/bin/sh
num_files=`find '.' -maxdepth 1 -type f -iname "*.tif" | wc -l`
pages=$((num_files*2))
#echo $pages

find '.' -maxdepth 1 -type f -iname "*.tif"  -exec /book/convert-booklet.sh 24 ccw {} \;
echo "---------------------"
