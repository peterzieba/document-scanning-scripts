outdir=`pwd`/out

#These variables handle cleaning up hole-punch marks.

#number of pixels to "white out" from odd and even pages.

#Since hole-punch marks will be visible on either the left or the right side of the page,
#punch marks are blanked-out from the left or the right depending on whether the page is odd or even in number (respectively).

#"other_side" determines how many pixels to blank from the opposite side (non-hole punched side).
odd_horizontal=155
odd_horizontal_other_side=80
odd_vertical=0

even_horizontal=155
even_horizontal_other_side=80
even_vertical=0

bgcolor=white

echo $1
if [ -f "$1" ]; then
    #echo "file"
    #exit 0
    ##newname=cmp_`basename "$1"`
    newname=`basename "$1"`
    echo $newname
    #tiffcp -c lzw "$1" "${newname}"
    ##exit 0
    #try to get the page number, so we can determine whether the binding that we're trying to strip is on the left of the right side.
    num=`echo $1 | sed 's/.*_//' | sed 's/\..*//'| sed 's/^0*//'`
    echo $num
    if [ $((num%2)) -eq 0 ]; then
        echo "Even Number Page - Strip Right"
        #convert -gravity SouthEast -chop 120x65 $1 $outdir/`basename $1`
        convert -background ${bgcolor} -gravity SouthEast -chop ${even_horizontal}x${even_vertical} -splice ${even_horizontal}x${even_vertical} -gravity SouthWest -chop ${even_horizontal_other_side}x${even_vertical} -splice ${even_horizontal_other_side}x${even_vertical} ${newname} -compress lzw "$outdir/`basename $1`"
    else
        echo "Odd Number Page - Strip Left"
        #convert -gravity SouthWest -chop 120x65 $1 $outdir/`basename $1`
        convert -background ${bgcolor} -gravity SouthWest -chop ${odd_horizontal}x${odd_vertical} -splice ${odd_horizontal}x${odd_vertical} -gravity SouthEast -chop ${odd_horizontal_other_side}x${even_vertical} -splice ${odd_horizontal_other_side}x${even_vertical} ${newname} -compress lzw "$outdir/`basename $1`"
    fi

else
    echo "no file"
fi

echo -e "\n"
