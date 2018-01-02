outdir=`pwd`/out

#These variables handle cleaning up hole-punch marks.

#number of pixels to "white out" from odd and even pages.

#Since hole-punch marks will be visible on either the left or the right side of the page,
#punch marks are blanked-out from the left or the right depending on whether the page is odd or even in number (respectively).

#"other_side" determines how many pixels to blank from the opposite side (non-hole punched side).
odd_horizontal=230
odd_horizontal_other_side=5
odd_vertical=0

even_horizontal=230
even_horizontal_other_side=5
even_vertical=0

staple_width=435
staple_height=140

bgcolor=black

echo $1
if [ -f "$1" ]; then
    #echo "file"
    #exit 0
    ##newname=cmp_`basename "$1"`
    newname=`basename "$1"`
    #tiffcp -c lzw "$1" "${newname}"
    ##exit 0
    #try to get the page number, so we can determine whether the binding that we're trying to strip is on the left of the right side.
    num=`echo $1 | sed 's/.*_//' | sed 's/\..*//'| sed 's/^0*//'`
    echo $num
    if [ $((num%2)) -eq 0 ]; then
        echo "Even Number Page - Strip Right"
        #convert -gravity SouthEast -chop 120x65 $1 $outdir/`basename $1`
        convert -gravity northeast -region ${staple_width}x${staple_height}+0+0 -fill ${bgcolor} -draw "rectangle 0,0 ${staple_width},${staple_height}" ${newname} -compress lzw "$outdir/`basename $1`"
    else
        echo "Odd Number Page - Strip Left"
        #convert -gravity SouthWest -chop 120x65 $1 $outdir/`basename $1`
        convert -gravity northwest -region ${staple_width}x${staple_height}+0+0 -fill ${bgcolor} -draw "rectangle 0,0 ${staple_width},${staple_height}" ${newname} -compress lzw "$outdir/`basename $1`"
    fi

else
    echo "no file"
fi

echo -e "\n"
