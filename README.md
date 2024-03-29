## 前言

**自2012年接触翻墙以来，我大约用过以下各类软件：**
> - VPN系列：PPTP、L2TP类软件（类似GreenVPN等）
> - 法轮功成员开发软件：Lantern（蓝灯）、自由门、无界……（可能还有，但我就用过这几种）
> - 初代代理软件：Psiphon（赛风）、XX-NET（基于GAEAgent且自带一定混淆的软件，直至今天仍在更新）
> - 传奇代理软件：Shadowsocks(R)（可以说没有这款软件就没有今天的代理软件百家齐放的局面。R.I.P. Clowwindy&Breakwa11）
> - 现代代理软件：v2ray、xray、Clash、QuantumultX、Shadowrocket、Surge...
> - 小众代理软件：Tuic、Hysteria、Naiveproxy、mieru...

在这分享（记录）一下，方便后续查阅。

## 软件归类

### 各类核心

**请注意：本处仅存放平时本人可能会用到的核心，以外的完全不涉及**

> - [v2ray/v2fly](https://github.com/v2fly/v2ray-core/releases)
> - [xray](https://github.com/XTLS/Xray-core/releases)
> - [Clash Foss](https://github.com/Dreamacro/clash/releases)
> - [Clash Premium](https://github.com/Dreamacro/clash/releases/tag/premium)
> - [Clash Meta](https://github.com/MetaCubeX/Clash.Meta/releases)
> - [Sing-box](https://github.com/SagerNet/sing-box/releases)
> - [NaiveProxy](https://github.com/klzgrad/naiveproxy/releases)
> - [Hysteria](https://github.com/apernet/hysteria/releases)
> - [Tuic](https://github.com/EAimTY/tuic/releases)
> - [Mieru](https://github.com/enfein/mieru/releases)

### Windows GUI

#### Clash系

> - [Clash for Windows（已删库，此链接为最终汉化备份版）](https://github.com/imbalaomao/fireware/releases/tag/cfw)
> - [Clash for Windows汉化版](https://github.com/Z-Siqi/Clash-for-Windows_Chinese/releases/tag/CFW-V0.20.39_CN)
> - [Clash Verge（需要EdgeRuntime2，轻量好用）](https://github.com/zzzgydi/clash-verge/releases)
> - [ClashWarden（使用C++编写的小巧客户端，许久不更新了）](https://github.com/dream7180/ClashWarden)
> - [ClashN（V2rayN作者做的同界面客户端，许久不更新了）](https://github.com/2dust/clashN/releases/latest)
> - [Fclash（使用Flutter编写的跨平台GUI）](https://github.com/Fclash/Fclash/release/latest)
> - [clash-for-flutter（使用谷歌Flutter框架编写）](https://github.com/mapleafgo/clash-for-flutter/releases/latest)
> - [Clash.Mini（使用Go语言编写的简洁版UI，集成了Meta内核，许久不更新了）](https://github.com/Clash-Mini/Clash.Mini/releases/latest)
> - [ClashR Auto（基于CFW魔改）](https://github.com/ClashrAuto/Clashr-Auto-Desktop/releases/latest)
> - [Clashy（桌面全平台）](https://github.com/SpongeNobody/Clashy)

#### V2ray系

> - [Nekoray（魔改Qv2Ray，增加hysteria等新协议支持）](https://matsuridayo.github.io/download/)
> - [V2rayN（老牌*ray系软件，近期已用.NET 6.0重写）](https://github.com/2dust/v2rayN)
> - [Qv2ray（原维护者弃坑，新仓库为RELEASE备份）](https://github.com/Shadowsocks-NET/Qv2ray)

#### Sing-Box

> - [Sing-box 托盘GUI](https://github.com/daodao97/SingBox/releases)
  
### iOS/MacOS GUI

> - [Shadowrocket(仅限iOS系统，不支持intel Mac，一般定价：**2.99USD**)](https://itunes.apple.com/us/app/shadowrocket/id932747118?mt=8)
> - [QuantumultX(iOS/MacOS授权通用，支持Intel-Mac/M1-Mac，一般定价：**4.99USD**)](https://apps.apple.com/us/app/quantumult-x/id1443988620)
> - [Surge(iOS/MacOS授权分离，定价超高，土豪专用)](https://www.nssurge.com/)
> - [Loon(iOS/MacOS授权通用)](https://apps.apple.com/us/app/loon/id1373567447)
> - [Stash(iOS可用，与Clash premium核心共享配置文件，**2.99USD**)](https://apps.apple.com/us/app/stash-rule-based-proxy/id1596063349)
> - [ClashX（仅限Mac使用）](https://github.com/yichengchen/clashX)
> - [ClashX Meta（仅限Mac使用）](https://github.com/MetaCubeX/ClashX.Meta)
> - [V2rayX（仅限Mac使用）](https://github.com/Cenmrev/V2RayX)
> - [Sing-box 托盘GUI（仅限Mac使用）](https://github.com/daodao97/SingBox/releases)

### Android GUI

#### V2ray系

> - [SagerNet（兼容SSR、v2ray、clash配置，带很多插件，已停更）](https://github.com/SagerNet/SagerNet/releases)
> - [Matsuri（魔改版Sagernet，与原版差距不大，兼容原版插件）](https://matsuridayo.github.io/download/)
> - [V2rayNG（Xray社区钦定）](https://github.com/2dust/v2rayNG)
  
#### Clash系

> + [Clash for Android](https://github.com/Kr328/ClashForAndroid/releases/latest)
> + [Clash Meta for Android](https://github.com/MetaCubeX/ClashMetaForAndroid/releases/tag/Prerelease-alpha)
> + [Clash for Magisk（需ROOT）](https://github.com/kalasutra/Clash_For_Magisk)
  
#### [Surfboard（兼容Surge4配置文件）](https://github.com/getsurfboard/surfboard/releases)

### 路由器

> + [fancyss(梅林/华硕固件经典插件)](https://github.com/hq450/fancyss)
> + [MerlinClash(使用ClashPremium/ClashMeta内核)](https://github.com/zhangkuang/Merlinclash)
> + [OpenClash(OpenWRT经典插件)](https://github.com/vernesong/OpenClash)
> + [ShellClash(只要能SSH就能Clash！)](https://github.com/juewuy/ShellClash)

## 搭建脚本归类

**所有脚本我本人都使用过，无好坏之分，只有适合你自己的才是最好的**
****

### v2ray/xray脚本

> - [233boy的v2ray一键脚本](https://233boy.com/v2ray/v2ray-script/)
> - [233boy的xray一键脚本](https://233boy.com/xray/xray-script/)
> - [mack-a 编写的八合一脚本，简单易用](https://www.v2ray-agent.com/archives/1680104902581)
> - [1024.day站长自编简易wss+ss安装脚本，脚本足够安全](https://blog.r1m.us/1024day-v2ray)

### sing-box脚本
> - [fscarmen的一键脚本](https://github.com/fscarmen/sing-box)
> - [FranzKafkaYu的一键脚本](https://github.com/FranzKafkaYu/sing-box-yes)
> - [yuehen7的一键脚本](https://github.com/yuehen7/scripts)

### Trojan脚本

***请注意：Trojan原版核心已两年多未更新，Trojan-go核心已一年多未更新，因此存在被探测可能性，保稳定性推荐使用v2ray/xray脚本或使用下方的小众协议***
> - [世界上最简单的Trojan一键部署脚本，无需域名申请（目前本人正在使用）](https://github.com/maplecool/easytrojan)
> - [BBR + Trojan-go + 其他脚本合集](https://github.com/yuehen7/scripts)
> - [Overplus，IP裸连（基于trojan，域名sniffer为bing搜索，但客户端跳过证书验证，目前稳定性尚佳）](https://github.com/xyanrch/overplus)
> - [Jrohy的Trojan一键脚本，但卸载部分无法完全删除安装时产生的文件，不是很推荐](https://github.com/Jrohy/trojan)

### 小众协议脚本/教程

***本Part中很少会出现一键脚本，大多为分步骤教学，需要对Linux有一定基础知识。同时大多数小众协议并无图形化UI，因此请使用v2rayN或Nekoray添加自定义核心后使用，具体使用方法请参考[此处](https://matsuridayo.github.io/n-extra_core/)***
> - [Naiveproxy安装脚本 by MisakaBlog](https://blog.misaka.rest/2023/04/08/naiveproxy-script/)
> - [Hi-Hysteria一键安装脚本（未适配Hysteria 2.0）](https://github.com/emptysuns/Hi_Hysteria)
> - [Hysteria 2.0安装脚本 by MisakaBlog](https://blog.misaka.rest/2023/09/02/hysteria2-script/)
> - [Hysteria 2.0安装脚本 by Qin2DIM(本脚本依赖python 3.8+)](https://github.com/QIN2DIM/hy2)
> - [Tuic安装脚本 by MisakaBlog](https://blog.misaka.rest/2023/06/10/tuic-v5-script/)
> - [mieru官方教程（分步骤且为英文，非脚本）](https://github.com/enfein/mieru)
> - [socks5代理搭建](https://sunpma.com/724.html)

#### 小众协议补充：

1.  目前对于如Racknerd、virmach这类无药可救的机器，可以使用Hysteria协议，如有CN2GIA、CU4837、CU9929等优秀线路的机器推荐优先考虑Tuic、Naiveproxy等有流控的协议（Hysteria无法搭建在Racknerd机器上）。
2.  [Clash.meta](https://docs.metacubex.one/)目前已对Tuic、Hysteria做了较为完善的支持，不想添加自定义配置和核心的可以使用此软件（关于替换核心可以看[本人教程](https://www.youtube.com/watch?v=V5v3eBi-sXo)）

### 面板搭建
> - [原版X-UI（很久不更新了）](https://github.com/vaxilu/x-ui)
> - [魔改X-UI](https://github.com/FranzKafkaYu/x-ui)

## VPS测试脚本

- 萌咖大佬的DD脚本（如VPS为甲骨文ARM，则需要加 `-firmware`）
```shell
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 11 -v 64 -p p@ssw0rd -a
```
- 宝塔面板开心版7.7.0（无后台监控）
```shell
curl -sSO https://raw.githubusercontent.com/8838/btpanel-v7.7.0/main/install/install_panel.sh && bash install_panel.sh

# 1，屏蔽手机号
sed -i "s|bind_user == 'True'|bind_user == 'XXXX'|" /www/server/panel/BTPanel/static/js/index.js
# 2，删除强制绑定手机js文件
rm -f /www/server/panel/data/bind.pl
# 3，手动解锁宝塔所有付费插件为永不过期
文件路径：/www/server/panel/data/plugin.json
搜索字符串："endtime": -1全部替换为"endtime": 999999999999
# 4，给plugin.json文件上锁防止自动修复为免费版
chattr +i /www/server/panel/data/plugin.json
```
- 开启BBR+FQ
```shell
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
sysctl net.ipv4.tcp_available_congestion_control
lsmod | grep bbr
```
- 另一开启BBR脚本（秋水逸冰大佬）
```shell
wget --no-check-certificate -O /opt/bbr.sh https://github.com/teddysun/across/raw/master/bbr.sh
chmod 755 /opt/bbr.sh
/opt/bbr.sh
```
- 三网测速
```shell
bash <(curl -Lso- https://git.io/superspeed_uxh)
```
- 解锁测试
```shell
bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
```

## 机场

**对于小白且对于翻墙IP要求低的用户来说，机场是最好的选择。但由于最近的 [v2board群体脱库事件](https://www.cnblogs.com/arrdres/p/16986407.html) 导致很多人不敢买机场，以下推荐的机场都是没有使用v2board的，因此可以放心购买：**
- [YToo（歪兔：极稳定、贵、速度很快）](https://oxycontin.top/aff.php?aff=1637)
- [Saiki（新开机场，低价大流量速度快）](https://saikiowo.com/#/register?code=7jLTQUSD)
- [X-air（稳定、快速、便宜）](https://temp-linshidizhi-1.very-fast.net:666/register?aff=20158)
