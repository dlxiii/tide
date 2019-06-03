#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May  9 20:40:36 2019
@author: Yulong WANG
"""

from __future__ import unicode_literals
import os
import time
import requests
import datetime
import numpy as np
from bs4 import BeautifulSoup

# https://www1.kaiho.mlit.go.jp/KANKYO/TIDE/cgi-bin/curr_pred.cgi?area=0001&br=notns-win32&year=2014&month=01&day=09&hour=9&btn=%BF%E4%A1%A1%BB%BB
# https://www1.kaiho.mlit.go.jp/KANKYO/TIDE/cgi-bin/curr_img/01_2014010909.gif

# https://www1.kaiho.mlit.go.jp/KANKYO/TIDE/curr_pred/

def getData(code, year, month, day, hour):
    url_base = "https://www1.kaiho.mlit.go.jp/KANKYO/TIDE/cgi-bin/"
    html = url_base + 'curr_pred.cgi?area=' + code + '&br=notns-win32&year=' + year + '&month=' + month + '&day=' + day + '&hour=' + hour + '&btn=%BF%E4%A1%A1%BB%BB'
    response = requests.get(html, stream=True)
    soup = BeautifulSoup(response.content, 'html.parser')
    img = soup.find('img',{'usemap':'#StationMap'}).attrs['src']
    url = url_base + img
    return url

def makeDir(path):
    if os.path.isdir(path):
        print('Folder exsiting.')
        pass
    else:
        print('Folder creating.')
        os.mkdir(path)
    return None

def clearFile(path, file):
    if os.path.isfile(path + file + '.gif'):
        os.remove(path + file + '.gif')
    return None

def writeFile(time, value, path, name):
    fid = requests.get(value)
    with open(path + name + '_' + time[0:4] + '_' + time[5:7] + '_' + time[8:10] + '_' + time [11:13]+ '.gif', 'wb') as f:
        f.write(fid.content)
    return None

if __name__=="__main__":
    start = time.time()   
    codelist = np.array([\
                         ('東京湾','Tokyowan','0001') \
                         ]) 
    timelist = [2014,1,9,9,2014,2,8,9]
    
    t0 = datetime.datetime(timelist[0],timelist[1],timelist[2],timelist[3])
    t1 = datetime.datetime(timelist[4],timelist[5],timelist[6],timelist[7])
    
    for i in range(len(codelist)):
        name = codelist[i][1]
        code = codelist[i][2]
        path = '../data/current/'
        file = code + '_' + name
        print(file + ':')
        # makeDir(path)
        clearFile(path, file)
        for j in range((t1 - t0).days * 24 + 1):
            hour = t0 + datetime.timedelta(hours = j)
            print('   ' + str(hour) + ' ...')
            value = getData(code, str(hour)[0:4], str(hour)[5:7], str(hour)[8:10], str(hour)[11:13])
            writeFile(str(hour),value,path,file)
    total_time = time.time() - start
    print(u"Total time is：%f seconds" % total_time)
