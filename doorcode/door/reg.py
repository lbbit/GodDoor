#!/usr/bin/env python2
#-*- coding: utf-8 -*-
import requests
import json
import random 
import os
import heart

url = 'http://easy.lbbit.com:8080/admin/dev/register'
headers = {"Content-type": "application/json"} 
body = {}
#获取随机的设备名
def getUniqueName():
	random.seed()
	name = random.randint(1,1000)
	return name
#填写注册信息
def getRegInfo(body):
	name = getUniqueName()
	port_a = 10000 + 2*name + 1
	port_c = 10000 + 2*name
	name = str(name)
	body['name'] = str(name)
	body['port_a'] = str(port_a)
	body['port_c'] = str(port_c)
#向服务器注册设备
def regArm():
	while True:
		getRegInfo(body)
		response = requests.post(url, data = json.dumps(body), headers = headers)
		print response
		result = response.json()
		print result
		code = result['code']
		print result['message']
		#如果注册成功
		if(code == 1):
			updateFile()
			print 'Success.'
			break
		#如果注册失败
		else:
			print "Error,it's trying again..."
#将设备名以及端口号保存到文件中
def updateFile():
	filename1 = "name.txt"
	with open(filename1,'w') as f:
		f.write(body['name'])
		print 'DeviceName Success.'
	filename2 = "./frp_c/frpc.ini"
	with open(filename2,'w') as f:
		frpc_str="[common]\nserver_addr = 118.25.43.148\nserver_port = 7000\n\n[ssh_a]\ntype = tcp\nlocal_ip = 127.0.0.1\nlocal_port = 10000\nremote_port = %s\n\n[ssh_c]\ntype = udp\nlocal_ip = 127.0.0.1\nlocal_port = 10001\nremote_port = %s\n" %(str(body['port_a']),str(body['port_c']))
		#print frpc_str
		f.write(frpc_str)
		print 'Port Success'
	#创建wav目录保存临时音频文件
	os.mkdir('wav')
#判断设备是否已注册
def isReg():
	filename = "name.txt"
	if os.path.exists(filename):
		return False
	else:
		return True
#入口函数
def startReg():
	if isReg():
		regArm()
	else:
		print 'have registered.exit...'
		

startReg()
print json.dumps(body)
heart.startReq()

		




