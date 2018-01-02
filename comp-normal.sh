#!/bin/sh
outdir=`pwd`/out

#This script compresses all .tif files using lossless LZW compression.

echo $1
if [ -f "$1" ]; then
    #echo "file"
    #exit 0
    mogrify -compress lzw "$1"
    exit 0
    #newname=cmp_`basename "$1"`
    #tiffcp -c lzw "$1" "${newname}"
    #convert $1 -compress lzw $outdir/`basename $1`
else
    echo "no file"
fi

echo -e "\n"
