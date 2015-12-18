#! /usr/bin/env bash
mkdir right
mkdir left

ffmpeg -loop 1 -i /path/to/watermark_720-right.png -t 30 -vcodec png -pix_fmt rgba -vf "pad=1280:720:ow-iw:0:color=#000000@0.0" ./right/right-wm1.mp4

ffmpeg -loop 1 -i /path/t0/watermark_720-left.png -t 30 -vcodec png -pix_fmt rgba -vf "pad=1280:720:0:0:color=#000000@0.0" ./left/left-wm1.mp4

cp right-wm1.mp4 right-wm2.mp4
cp right-wm1.mp4 right-wm3.mp4
cp right-wm1.mp4 right-wm4.mp4

cp left-wm1.mp4 left-wm2.mp4
cp left-wm1.mp4 left-wm3.mp4
cp left-wm1.mp4 left-wm4.mp4


ffmpeg -i right-wm1.mp4 -i left-wm1.mp4 -i right-wm2.mp4 -i left-wm2.mp4 -i right-wm3.mp4 -i left-wm3.mp4 -i right-wm4.mp4 -i left-wm4.mp4 -filter_complex "[0:v] [1:v][2:v][3:v][4:v][5:v][6:v][7:v] concat=n=8:v=1:a=0 [v]" -map "[v]" -y -vcodec png -pix_fmt rgba -q 0 all-wm.mp4

ffmpeg -i "$1" -i all-wm.mp4 -vcodec h264 -acodec copy -s 1280x720 -b:v 6000k -f mp4 -filter_complex overlay -shortest -y -q 0 ${1%.*}.avi
