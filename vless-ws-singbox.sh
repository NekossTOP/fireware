#!/bin/sh

export LANG=en_US.UTF-8

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN="\033[0m"

red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}

install_precheck(){
  if [[ $(id -u) != 0 ]]; then
    red "请使用root用户运行此脚本"
    exit 1
  fi
  if [ -f "/usr/bin/apt-get" ]; then
    apt-get update -y
    apt-get install -y net-tools curl socat jq
    mkdir -p /usr/local/etc/sing-box
  else
    yum update -y
    yum install -y epel-release
    yum install -y net-tools curl socat jq
    mkdir -p /usr/local/etc/sing-box
  fi
  clear
  read -p "请输入端口(默认38247): " port
  sleep 3
  isPort=`netstat -ntlp| grep -E ':${port:-38247}\s '`
  if [ "$isPort" != "" ];then
    clear
    echo " ================================================== "
    yellow " 端口被占用，请先释放端口再运行此脚本"
    echo
    yellow " 端口占用信息如下："
    echo $isPort
    echo " ================================================== "
    exit 1
  fi
}

getIP(){
  read -p "请输入本机绑定的域名：" domain
  sleep 0.2
  local serverIP=
  serverIP=$(curl -s -4 http://www.cloudflare.com/cdn-cgi/trace | grep "ip" | awk -F "[=]" '{print $2}')
  if [[ -z "${serverIP}" ]]; then
      serverIP=$(curl -s -6 http://www.cloudflare.com/cdn-cgi/trace | grep "ip" | awk -F "[=]" '{print $2}')
  fi
  echo "${serverIP}"
}

install(){
  OS_ARCH=$(arch)
  if [[ ${OS_ARCH} == "x86_64" || ${OS_ARCH} == "x64" || ${OS_ARCH} == "amd64" ]]; then
      OS_ARCH="x86_64"
      echo
      echo "当前系统架构为 ${OS_ARCH}"
  elif [[ ${OS_ARCH} == "armv7l" || ${OS_ARCH} == "armv7" ]]; then
      OS_ARCH="armv7"
      echo
      echo "当前系统架构为 ${OS_ARCH}"
  elif [[ ${OS_ARCH} == "aarch64" || ${OS_ARCH} == "aarch64" ]]; then
      OS_ARCH="aarch64"
      echo "当前系统架构为 ${OS_ARCH}"
  else
      echo
      OS_ARCH="x86_64"
      echo "检测系统架构失败，使用默认架构: ${OS_ARCH}"
  fi
  tag=$(wget -qO- -t1 -T2 "https://api.github.com/repos/SagerNet/sing-box/releases/latest" | jq -r '.tag_name')
  echo
  yellow "最新版本为 ${tag}"
  echo
  echo "正在下载 ${tag}..."
  echo
  wget https://github.com/SagerNet/sing-box/releases/download/${tag}/sing-box-${tag}-linux-${OS_ARCH}.tar.gz -O server.tar.gz && tar -zxvf server.tar.gz && chmod a+x sing-box && mv sing-box /usr/local/bin/sing-box

  if [[ -f /usr/local/etc/sing-box/config.json ]]; then
    echo
    yellow "配置文件已存在🎉"
    echo
  else
    yellow "正在创建配置文件"
    echo
    echo
    read -p "设置UUID（回车跳过为随机 UUID）：" uuid
    [[ -z $uuid ]] && uuid=$(cat /proc/sys/kernel/random/uuid)
    echo
    echo
    read -p "设置ws路径（回车跳过为随机字符）：" wspath
    [[ -z $wspath ]] && wspath=$(date +%s%N | md5sum | cut -c 1-8)
    echo
    echo

cat >/usr/local/etc/sing-box/config.json <<EOF
{
  "log": {
    "disabled": false,
    "level": "info",
    "timestamp": true
  },
  "route": {
    "rules": [
      {
        "inbound": ["ch74v9x3-in"],
        "outbound": "direct"
      }
    ]
  },
  "inbounds": [
    {
      "type": "vless",
      "tag": "ch74v9x3-in",
      "listen": "::",
      "listen_port": "$port",
      "sniff": true,
      "sniff_override_destination": true,
      "transport": {
        "type": "ws",
        "path": "/$wspath",
        "max_early_data": 2048,
        "early_data_header_name": "Sec-WebSocket-Protocol"
      },
      "users": [
        {
          "uuid": "$uuid",
          "flow": ""
        }
      ]
    }
  ],
  "outbounds": [
    {
      "type": "direct",
      "tag": "direct"
    }
  ]
}
EOF

cat >/etc/systemd/system/sing-box.service<<EOF
[Unit]
Description=sing-box service
Documentation=https://sing-box.sagernet.org
After=network.target nss-lookup.target

[Service]
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
ExecStart=/usr/bin/sing-box run -c /usr/local/etc/sing-box/config.json
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
RestartSec=10s
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOF

  systemctl enable --now siong && sleep 0.2 && systemctl status sing-box
  if [[ -n $(systemctl status sing-box 2>/dev/null | grep -w active) && -f '/usr/local/etc/sing-box/config.json' ]]; then
    green "sing-box 安装成功！"
  else
    red "sing-box 安装失败！请运行systemctl status sing-box查看错误信息！" && exit 1
  fi
  cd ~/
  rm -rf ~/sing-box.sh*
  clear
}

client_re(){
  clear

cat /usr/local/etc/sing-box/url.txt<<EOF
{
===========vless配置参数============
协议：Vless"
地址：${domain}"
端口：${port}"
UUID：${uuid}"
加密方式：none"
传输协议：ws"
路径：/${wspath}
====================================

wslink=vless://${uuid}@$(getIP):${port}?security=&type=ws&path=/${wspath}&host={}&encryption=none#vless-ws

请去Cloudflare域名下的 Origin-rules 添加规则：
 Hostname equal ${domain}
 端口：${port}
}
EOF
  
  cat /usr/local/etc/sing-box/url.txt
  echo
}

update(){
  clear
  systemctl stop sing-box && sleep 0.2
  OS_ARCH=$(arch)
  if [[ ${OS_ARCH} == "x86_64" || ${OS_ARCH} == "x64" || ${OS_ARCH} == "amd64" ]]; then
      OS_ARCH="x86_64"
      echo
      echo "当前系统架构为 ${OS_ARCH}"
  elif [[ ${OS_ARCH} == "armv7l" || ${OS_ARCH} == "armv7" ]]; then
      OS_ARCH="armv7"
      echo
      echo "当前系统架构为 ${OS_ARCH}"
  elif [[ ${OS_ARCH} == "aarch64" || ${OS_ARCH} == "aarch64" ]]; then
      OS_ARCH="aarch64"
      echo "当前系统架构为 ${OS_ARCH}"
  else
      echo
      OS_ARCH="x86_64"
      echo "检测系统架构失败，使用默认架构: ${OS_ARCH}"
  fi
  echo
  tag=$(wget -qO- -t1 -T2 "https://api.github.com/repos/SagerNet/sing-box/releases/latest" | jq -r '.tag_name')
  echo
  yellow "最新版本为 ${tag}"
  echo
  yellow "正在下载sing-box-server-&{tag}..."
  echo
  wget https://github.com/SagerNet/sing-box/releases/download/${tag}/sing-box-${tag}-linux-${OS_ARCH}.tar.gz -O server.tar.gz && tar -zxvf server.tar.gz
  systemctl start sing-box && sleep 0.2 && systemctl status sing-box
  if [[ -n $(systemctl status sing-box 2>/dev/null | grep -w active) && -f '/usr/local/etc/sing-box/config.json' ]]; then
    green "sing-box 更新成功！"
  else
    red "sing-box 更新失败！请运行systemctl status sing-box查看错误信息！" && exit 1
  fi
}

show_config(){
  echo
  cat /usr/local/etc/sing-box/url.txt
  echo
}

uninstall(){
  clear
  systemctl stop sing-box && sleep 0.2
  systemctl disable sing-box && sleep 0.2
  rm -rf /usr/local/etc/sing-box
  rm -rf /etc/systemd/system/sing-box.service
  green "sing-box 已彻底卸载完成！"
}

start_menu(){
  clear
  echo "############################"
  echo -e "#   ${RED}vless-ws 一键安装脚本${PLAIN}   #"
  echo "############################"
  echo ""
  echo " 1. 安装 singbox-vless-ws"
  echo " 2. 更新 sing-box"
  echo " 3. 查看配置"
  echo " 4. 卸载 sing-box"
  echo " 0. 退出脚本"
  echo
  read -p "请输入数字:" num
  case "$num" in
  1)
  install_precheck
  getIP
  install
  client_re
  ;;
  2)
  update
  ;;
  3)
  show_config
  ;;
  4)
  uninstall
  ;;
  0)
  exit 1
  ;;
  *)
  clear
  echo "请输入正确数字"
  sleep 2s
  start_menu
  ;;
  esac
}

rm -rf /root/vless-ws-singbox*
start_menu
