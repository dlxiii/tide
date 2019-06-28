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

# https://www1.kaiho.mlit.go.jp/KANKYO/TIDE/cgi-bin/tide_pred.cgi?area=

def getData(code, year, month, day):
    url_base = "https://www1.kaiho.mlit.go.jp/KANKYO/TIDE/cgi-bin/tide_pred.cgi?area="
    html = url_base + code + '&back=1.%2Ftide_pred%2F5.htm&year=' + year + '&month=' + month + '&day=' + day + '&btn=%BF%E4%A1%A1%BB%BB'
    response = requests.get(html, stream=True)
    soup = BeautifulSoup(response.content, 'html.parser')
    table = soup.find('table',{'bgcolor':'#e3ffe3'})
    value = [td.text.replace('\n', '') for td in table.find_all('td',{'align':'right'})]
    return value

def makeDir(path):
    if os.path.isdir(path):
        print('Folder exsiting.')
        pass
    else:
        print('Folder creating.')
        os.mkdir(path)
    return None

def clearFile(path, file):
    if os.path.isfile(path + file + '.dat'):
        os.remove(path + file + '.dat')
    return None

def writeFile(time, value, path, name):
    fid = open(path + name + '.dat', 'a')
    fid.write('{} '.format(time))
    for i in range(len(value)):
        fid.write('{} '.format(value[i]))
    fid.write('\n')
    fid.close()
    return None

if __name__=="__main__":
    start = time.time()   
    codelist = np.array([\
                         ('船橋','FUNABASHI','1218'), \
                         ('晴海（東京）','TOKYO-HARUMI','1314'), \
                         ('千葉灯標（千葉）','CHIBA-CHIBALIGHT','1216'), \
                         ('横浜新港（横浜）','YKOHAMASHINKO','1403'), \
                         ('君津','KIMITSU','1212'), \
                         ('横須賀','YOKOSUKA','1407'), \
                         ('久里浜（横須賀）','KURIHAMA','1410'), \
                         ('城ケ島（三崎）','JOGASHIMA','1413'), \
                         ('布良','MERA','1208'), \
                         ('鴨川','KAMOGAWA','1206'), \
                         ('岡田（大島）','OSHIMA-OKADA','1304')\
                         ]) 
    timelist = [2014,1,1,2018,12,31]
    
    t0 = datetime.date(timelist[0],timelist[1],timelist[2])
    t1 = datetime.date(timelist[3],timelist[4],timelist[5])
    
    for i in range(len(codelist)):
        name = codelist[i][1]
        code = codelist[i][2]
        path = '../data/tide/'
        file = code + '_' + name
        print(file + ':')
        makeDir(path)
        clearFile(path, file)
        for j in range((t1 - t0).days + 1):
            day = t0 + datetime.timedelta(days = j)
            print('   ' + str(day) + ' ...')
            value = getData(code, str(day)[0:4], str(day)[5:7], str(day)[8:10])
            writeFile(str(day),value,path,file)
    total_time = time.time() - start
    print(u"Total time is：%f seconds" % total_time)
