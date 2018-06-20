#!/usr/bin/env python2
# -*- coding:UTF-8 -*-
from sys import path
path.append(r'./gpio') 
from socket import *  
import time
import string  
import gpio
#开锁
def openDoor():
    gpio.setup(62,'out')
    gpio.setwarnings(False)
    print 'Set gpio62 as 1\n'
    gpio.set(62,1)
    time.sleep(1)
    gpio.set(62,0)
    #gpio.cleanup(62)

#创建服务端UDP连接，等待客户端开锁指令
def lockServer():
    HOST = '0.0.0.0'
    PORT = 10001
    BUFSIZ = 256 
    ADDR = (HOST, PORT) 
    #创建一个服务器端UDP套接字  
    udpServer = socket(AF_INET, SOCK_DGRAM)
    #绑定服务器套接字  
    udpServer.bind(ADDR)  
    while True:  
        print 'waiting for client...\n'
        #接收来自客户端的数据  
        data, addr = udpServer.recvfrom(BUFSIZ)
        print data  
        #向客户端发送数据
        if data == 'OpenLock':
            openDoor()
            udpServer.sendto('1', addr)  
            print '[%s] the door is open by '% time.ctime(),addr ,'\n'
        else:
            udpServer.sendto('0', addr)  
            print '[%s] prevent ' % time.ctime(),addr,' to open the door !\n' 
    udpServer.close()


print '111'
lockServer()
