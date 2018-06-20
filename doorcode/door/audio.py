#!/usr/bin/env python2
#-*- coding:utf-8 -*-
import socket
import threading
import time,random
import os
import struct


#以当前时间作为文件名
def getFileName():
	nowtime = time.strftime('%H%M%S',time.localtime(time.time()))
	filename = "./wav/%s.wav"%nowtime
	return filename

#播放音频文件
def playmusic(listname):
	#依次播放“缓冲区”中的音频文件
	print 'thread %s is running...\n' % threading.current_thread().name
	while  1:
		#如果播放列表不为空
		if listname:
			filename = listname[0]
			listname.remove(filename)
			print filename
			order = 'play %s'%filename
			print '%s is playing now...' %filename
			os.system(order)
			print '%s is playing over...' %filename
		else:
			break

#删除音频文件
def removeWav():
	path = './wav'
	print 'start to remove wav files:'	
	ls = os.listdir(path)
	for i in ls:
		c_path = os.path.join(path, i)
		print c_path
		os.remove(c_path)

#创建TCP连接函数，每个连接创建一个新线程
def tcplink(sock_addr):
    print 'Accept new connection from %s:%s...' % sock_addr[1]
    print sock_addr[1]
    sock = sock_addr[0]
    listname=[]
    while True:
    	try:
    		sock.settimeout(1800)
	    	#根据客户端ip命名音频文件
	        msg = sock.recv(1024)
	        print msg
	        if not msg :
	        	break
	        filesize = struct.unpack('i',msg[:4])[0]
	        print 'fileszie is %s :'% str(filesize)
	        recvd_size = 0 #定义接收了的文件大小
	        audioname = getFileName()
	        #将待播放文件名加入列表中
	        listname.append(audioname)
	        with open(audioname,'wb') as f:
		        print 'start receiving...'
		        while not recvd_size == filesize:
					if filesize - recvd_size > 1024:
						rdata = sock.recv(1024)
						recvd_size += len(rdata)
					else:
						rdata = sock.recv(filesize - recvd_size) 
						recvd_size = filesize
					f.write(rdata)
					print 'the recvd_size is %s' %recvd_size
			f.close()
			print 'thread %s is running...' % threading.current_thread().name
			#如果列表中只有一个文件名，即刚刚添加的
			if len(listname) == 1:
				print 'play music'
				t=threading.Thread(target=playmusic,args=(listname,),name='musicThread')
				t.start()
			print 'receive done...'	
    	except socket.timeout:
    		sock.close()
    		break
    	
    print 'Connection from %s:%s closed.'%sock_addr[1]
    removeWav()


#创建socket，并监听端口
def startSocket():
	#创建socket
	s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
	s.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
	#监听端口
	s.bind(('0.0.0.0',10000))
	s.listen(3)
	print 'Waiting for connection...'
	#服务器端创建循环，永久监听来自客户端的连接
	print 'thread %s is running...' % threading.current_thread().name
	while True:
		#接受一个新连接
		sock,addr=s.accept()
		#创建新线程来处理TCP连接
		sock_addr=(sock,addr)
		t=threading.Thread(target=tcplink,args=(sock_addr,))
		t.start()
	s.close()


startSocket()