# -*- coding: utf-8 -*-

# pip install BeautifulSoup, pymongo
import urllib2
from bs4 import BeautifulSoup
import pymongo
import sys


success_list = [];
fail_list = [];

url = "http://www.index.go.kr/potal/main/EachDtlPageDetail.do?idx_cd=2838"
content = urllib2.urlopen(url)
soup = BeautifulSoup(content, 'html.parser')

arr = [];

temp = soup.find(id="t_Table_283805").find("thead").find("tr").find_all("th")
index = 0
for tr in temp:
    if index == 0:
        index += 1
        continue
    tx = tr.get_text()
    arr.append([tx])


temp = soup.find(id="t_Table_283805").find("tbody").find_all("tr")
for tr in temp:
    index = 0
    for td in tr.find_all("td"):
        tx = td.get_text()
        # print(tx)
        arr[index].append(tx)
        index += 1

# for t in arr:
#     for x in t:
#         print(x)
#     # print("")

connection = pymongo.MongoClient("mongodb://localhost")
db = connection.test
products = db.products

for a in arr:
    doc = {'_id': a[0],
           '전산업생산지수(원지수)': a[1],
           '전년동월(기)비': a[2],
           '광공업': a[3],
           '건설업': a[4],
           '서비스업': a[5],
           '공공행정': a[6],
           }
    print(doc)
    try:
        products.insert(doc)
    except:
        print("insert failed", sys.exc_info()[0])

