#!/usr/bin/env python2
#-*- coding: utf-8 -*-
import os
import time


#从文件中获取设备名
def getName():
    with open('name.txt','r') as f:
        name = f.readline().strip()
        return name

#开启ffmpeg推流，将本地http流转成rtmp流推向服务器
def startFFmpeg():
   # mjpg_Streamer()
    time.sleep(5)
    name = getName() 
    ffmpeg_order = 'ffmpeg -re -i http://localhost:8080/?action=stream -b:v 500k -an -f flv rtmp://easy.lbbit.com/live/%s'%name
    ##ffmpeg_order = 'nohup ffmpeg -re -f v4l2  -video_size vga -pix_fmt yuv420p -i /dev/video0  -b:v 500k -c:v libx264 -an -f flv  rtmp://easy.lbbit.com/live/%s >ffmpeg.log 2>&1 &'%name
    ##ffmpeg_order = 'ffmpeg  -f v4l2 -video_size vga -pix_fmt yuv420p -i /dev/video0 -f alsa -i hw:0 -b:v 500k -c:v   -ar 44100 -ac 1 -f flv rtmp://easy.lbbit.com/live/%s'%name
    os.system(ffmpeg_order) 

#开启mjpg-Streamer采集本地http流
def mjpg_Streamer():
    streamer_order = '../mjpg-streamer/mjpg_streamer -i "./input_uvc.so -f 20 -d /dev/video0  -y -r  640*480" -o "./output_http.so -w ./www" &'
    os.system(streamer_order)

startFFmpeg()

