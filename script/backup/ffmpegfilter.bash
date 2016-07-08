#!/bin/sh
vidres=704x396

ffmpeg -i $1 \
       -vcodec mpeg -pix_fmt yuv420p -me_method epzs -threads 4 \
       -r 29.97 -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -s $vidres -b 4900k -bt 600k \
       -async 1 \
       -y \
       -f vob -
