#!/bin/sh
echo "starting Door Project now..."
echo "Registering the device and keeping heartbeat..."
python reg.py &
echo "start the frp_client...."
cd ./frp_c
chmod +x frpc
nohup ./frpc -c frpc.ini  >frp_c.log 2>&1 &
cd ..
echo "Waiting for client to send voice..."
python  audio.py &
echo "Waiting for client to open lock..."
python  openDoor.py &
echo "starting mjpg-streamer..."
cd ../mjpg-streamer
./mjpg_streamer -i "./input_uvc.so -f 20 -d /dev/video0  -y -r  640*480" -o "./output_http.so -w ./www" & 
cd ../door
echo "Staring ffmpeg now..."
python ffmpeg.py 


