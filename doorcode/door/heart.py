#!/usr/bin/env python2
#-*- coding: utf-8 -*-
import requests
import json
import os
import time,threading

url = "http://easy.lbbit.com:8080/admin/dev/updateTime"
headers = {"Content-type": "application/json"} 
body = {}

#从文件中获取设备名
def getName():
    filename = "name.txt"
    if os.path.exists(filename):
        with open(filename,'r') as f:
            body['name'] = f.readline().strip()
            print body['name']
            return True
    else:
        print 'Heartbeat:Error,cannot get deviceName!'
        return False

#循环发送post请求，以维持和服务器之间的心跳
def loopRequest():
    while True:
        print 'Heartbeat:Sending package now.'
        response = requests.post(url, data = json.dumps(body), headers = headers)
        print response.json()['message']
        time.sleep(30)
        pass

def startReq():
    if getName():
        loopRequest()
    else:
        print 'Heartbeat:Fail,exiting now.'

#startReq()


