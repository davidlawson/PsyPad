#!/bin/bash

convert -size 1024x1024 xc:"#444444"  pp_icon_background.png

cp pp_icon_background.png a.png
for ((i=0; i<=50 ; i++ ))
do
    x=$RANDOM ; let "x %= 1000"
    y=$RANDOM ; let "y %= 1000"
    mogrify -fill "#c5c5c5" -draw "rectangle $x,$y $((x + 24)),$((y+24))" a.png
done

for dim in 20 29 40 58 80 76 152 167
do
    convert a.png -resize "$dim"x"$dim" pp_icon_$dim.png
done


