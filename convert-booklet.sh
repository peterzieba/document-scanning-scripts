#!/bin/sh

#$1 - Number of pages (This should be double the number of files coming in, as it represents physical book pages)
#$2 - Whether first page needs to be flipped CW or CCW
#$3 - Filename

midline=2020

prefix=img_

outdir=`pwd`/out

num=`echo $3 | sed 's/.*_//' | sed 's/\..*//'| sed 's/^0*//'`

if [ -z $num ]; then
    echo "filename error"
    exit 0
fi

echo "Processing: $3"

if [ ! -f "$3"  ]; then
    echo "oops, not a file: ${3}"
fi


# echo $num
if [ $((num%2)) -eq 0 ]; then
    even=yes
else
    even=no
fi

if [ "$2" == "cw" ]; then
    firstpage=cw
elif [ "$2" == "ccw" ]; then
    firstpage=ccw
else
    echo fuck
    exit 0
fi

echo "even: $even"
echo "1st $firstpage"

if [[ $even == "no" && $firstpage == "cw" ]] || [[ $even == "yes" && $firstpage == "ccw" ]]; then
    degrees=90
else
    degrees=270
fi

echo "degrees: $degrees"
echo "num: $num"

#Establish filenames for left and right pages that jive with physical pagenumbers
#This is done by translating the sequence number from the original filename ( $num ), and taking into account the number of total pages ( $1 ).
if [ "$2" == "cw" ]; then
    if [[ $even == "no" ]]; then
	leftpage=`printf "%0*d" 4 $(($1-($num-1)))`
	rightpage=`printf "%0*d" 4 $num`
    elif [[ $even == "yes" ]]; then
	leftpage=`printf "%0*d" 4 $num`
	rightpage=`printf "%0*d" 4 $(($1-($num-1)))`
    fi
elif [ "$2" == "ccw" ]; then
    if [[ $even == "no" ]]; then
	leftpage=`printf "%0*d" 4 $((${1}/2-($num-1)))`
	rightpage=`printf "%0*d" 4 $((${1}/2+$num))`
    elif [[ $even == "yes" ]]; then
	leftpage=`printf "%0*d" 4 $((${1}/2+$num))`
	rightpage=`printf "%0*d" 4 $((${1}/2-($num-1)))`
    fi
fi

echo "left: $leftpage"
echo "right: $rightpage"

#convert "$3" -rotate $degrees -crop 50%x100%+0+0 -compress lzw ${outdir}/"$leftpage.tif"
#convert "$3" -rotate $degrees -gravity east -crop 50%x100%+0+0 -compress lzw ${outdir}/"$rightpage.tif"

#convert "$3" -rotate $degrees -gravity northwest -crop ${midline}x+0+0 +repage -compress lzw ${outdir}/"$leftpage-L-$degrees-${num}.tif"
#convert "$3" -rotate $degrees -gravity northeast -crop ${midline}x+0+0 +repage -compress lzw ${outdir}/"$rightpage-R-$degrees-${num}.tif"

#if [ "$degrees" == 270 ]; then
#elif [ "$degrees" == 90 ]; then
#else

#convert "$3" -rotate $degrees -gravity northwest -compress lzw ${outdir}/"$leftpage-L-$degrees-${num}.tif"
#convert "$3" -rotate $degrees -gravity northeast -compress lzw ${outdir}/"$rightpage-R-$degrees-${num}.tif"

#convert "$3" -gravity northwest -crop x${midline}+0+${midline} +repage -compress lzw ${outdir}/"$leftpage-L-$degrees-${num}.tif"
#convert "$3" -gravity northwest -crop x${midline}+0+0 +repage -compress lzw          ${outdir}/"$rightpage-R-$degrees-${num}.tif"

if [ $leftpage -le $((${1}/2)) ]; then
    #convert "$3" -compress lzw ${outdir}/"$leftpage-L-$degrees-${num}.tif"
    convert "${3}" -gravity northwest -crop x${midline}+0+0 +repage -rotate $degrees -compress lzw          ${outdir}/"${prefix}${leftpage}.tif"
else
    convert "${3}" -gravity northwest -crop x${midline}+0+${midline} +repage -rotate $degrees -compress lzw ${outdir}/"${prefix}${leftpage}.tif"
fi

if [ $rightpage -le $((${1}/2)) ]; then
    convert "${3}" -gravity northwest -crop x${midline}+0+0 +repage -rotate $degrees -compress lzw          ${outdir}/"${prefix}${rightpage}.tif"
else
    convert "${3}" -gravity northwest -crop x${midline}+0+${midline} +repage -rotate $degrees -compress lzw ${outdir}/"${prefix}${rightpage}.tif"
fi

#convert "$3" -compress lzw          ${outdir}/"$rightpage-R-$degrees-${num}.tif"

echo "-------------------"