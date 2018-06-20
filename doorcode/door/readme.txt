1.执行脚本 starDoor.sh.这是终端项目代码的启动脚本。
2.frp_c是frp客户端文件解压后的目录，在此目录下启动frp客户端。
3.gpio是手动下载的python第三方库，若是使用pip安装了gpio，则此目录可忽略。
4.wav是设备注册时自动创建的目录，用于临时保存接收到的音频文件。
5.audio.py 语音通信模块
6.ffmpeg.py 视频推流模块
7.heart.py 心跳维持模块
8.name.txt 设备注册成功后自动创建的文件，用于保存设备号
9.openDoor 电控开锁模块
10.reg.py 设备注册模块
11.rm.sh 用于清空注册信息，以便重新注册