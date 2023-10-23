#!/bin/bash
echo 将开消耗您的流量，此脚本占用宽带。
echo 将与8秒后开始运行
sleep 8
echo 正在检测环境
yum install screen curl -y
echo starting...
echo 若要停止,重启服务器即可
sleep 3
screen_name=$"run"  
screen -dmS $screen_name  
cmd=$"bash <(curl -sL https://raw.githubusercontent.com/imbalaomao/fireware/main/speedtest.sh)"; 
screen -x -S $screen_name -p 0 -X stuff "$cmd"  
screen -x -S $screen_name -p 0 -X stuff $'\n'  
echo  请时刻留意此脚本更新 https://www.diannaobos.com/post/921.html
