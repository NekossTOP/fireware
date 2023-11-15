#!/bin/bash
echo 将开消耗您的流量，此脚本占用宽带。
echo 将与8秒后开始运行
sleep 8
echo 正在检测环境
if [ -f "/usr/bin/apt-get" ]; then
    apt-get install -y screen wondershaper
    wondershaper 500000 200000
else
    yum install -y screen wondershaper
    wondershaper 500000 200000
fi
echo starting...
echo 若要停止,重启服务器即可
sleep 3
screen_name=$"run"  
screen -dmS $screen_name
cmd=$"while true ;do wget -O /dev/null 'https://speed.cloudflare.com/__down?during=download&bytes=10737418240'; done;";
screen -x -S $screen_name -p 0 -X stuff "$cmd"
screen -x -S $screen_name -p 0 -X stuff $'\n'
echo  脚本启动成功
