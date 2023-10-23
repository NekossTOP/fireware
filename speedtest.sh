#!/bin/bash

while true; do
    wget -O /root/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py && chmod +x /root/speedtest-cli
    /root/speedtest-cli
    sleep 5  # 等待 5 秒后继续执行
done
