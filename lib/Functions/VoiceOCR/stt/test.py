# api 请求示例
import os
import requests

# 请求地址
url = "http://127.0.0.1:8001/api"
# 请求参数  file:音视频文件，language：语言代码，model：模型，response_format:text|json|srt
# 返回 code==0 成功，其他失败，msg==成功为ok，其他失败原因，data=识别后返回文字
files = {"file": open(r"C:\Users\Dell\Downloads\林俊杰音乐\主角.mp3", "rb")}
data={"language":"zh","model":"base","response_format":"json"}
response = requests.request("POST", url, timeout=600, data=data,files=files)
print(response.json())
