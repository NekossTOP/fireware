rm -rf /etc/sysctl.conf
cat >> /etc/sysctl.conf << EOF
# ------ 网络调优: 基本 ------
# TTL 配置, Linux 默认 64
# net.ipv4.ip_default_ttl=64

# 参阅 RFC 1323. 应当启用.
net.ipv4.tcp_timestamps=1
# ------ END 网络调优: 基本 ------

# ------ 网络调优: 内核 Backlog 队列和缓存相关 ------
# Ref: https://www.starduster.me/2020/03/02/linux-network-tuning-kernel-parameter/
# Ref: https://blog.cloudflare.com/optimizing-tcp-for-high-throughput-and-low-latency/
# Ref: https://zhuanlan.zhihu.com/p/149372947
# 有条件建议依据实测结果调整相关数值
# 缓冲区相关配置均和内存相关
net.core.wmem_default=16384
net.core.rmem_default=262144
net.core.rmem_max=536870912
net.core.wmem_max=536870912
net.ipv4.tcp_rmem=8192 262144 536870912
net.ipv4.tcp_wmem=4096 16384 536870912
net.ipv4.tcp_adv_win_scale=-2
net.ipv4.tcp_collapse_max_bytes=6291456
net.ipv4.tcp_notsent_lowat=131072
net.core.netdev_max_backlog=10240
net.ipv4.tcp_max_syn_backlog=10240
net.core.somaxconn=8192
net.ipv4.tcp_abort_on_overflow=1
# 流控和拥塞控制相关调优
# Egress traffic control 相关. 可选 fq, cake
# 实测二者区别不大, 保持默认 fq 即可
net.core.default_qdisc=fq
# Xanmod 内核 6.X 版本目前默认使用 bbr3, 无需设置
# 实测比 bbr, bbr2 均有提升
# 不过网络条件不同会影响. 有需求请实测.
# net.ipv4.tcp_congestion_control=bbr3
# 显式拥塞通知
# 已被发现在高度拥塞的网络上是有害的.
# net.ipv4.tcp_ecn=1
# TCP 自动窗口
# 要支持超过 64KB 的 TCP 窗口必须启用
net.ipv4.tcp_window_scaling=1
# 开启后, TCP 拥塞窗口会在一个 RTO 时间
# 空闲之后重置为初始拥塞窗口 (CWND) 大小.
# 大部分情况下, 尤其是大流量长连接, 设置为 0.
# 对于网络情况时刻在相对剧烈变化的场景, 设置为 1.
net.ipv4.tcp_slow_start_after_idle=0
# nf_conntrack 调优
# Add Ref: https://gist.github.com/lixingcong/0e13b4123d29a465e364e230b2e45f60
net.nf_conntrack_max=1000000
net.netfilter.nf_conntrack_max=1000000
net.netfilter.nf_conntrack_tcp_timeout_fin_wait=30
net.netfilter.nf_conntrack_tcp_timeout_time_wait=30
net.netfilter.nf_conntrack_tcp_timeout_close_wait=15
net.netfilter.nf_conntrack_tcp_timeout_established=300
net.ipv4.netfilter.ip_conntrack_tcp_timeout_established=7200
# TIME-WAIT 状态调优
# Ref: http://vincent.bernat.im/en/blog/2014-tcp-time-wait-state-linux.html
# Ref: https://www.cnblogs.com/lulu/p/4149312.html
# 4.12 内核中此参数已经永久废弃, 不用纠结是否需要开启
# net.ipv4.tcp_tw_recycle=0
## 只对客户端生效, 服务器连接上游时也认为是客户端
net.ipv4.tcp_tw_reuse=1
# 系统同时保持TIME_WAIT套接字的最大数量
# 如果超过这个数字 TIME_WAIT 套接字将立刻被清除
net.ipv4.tcp_max_tw_buckets=55000
# ------ END 网络调优: 内核 Backlog 队列和缓存相关 ------

# ------ 网络调优: 其他 ------
# Ref: https://zhuanlan.zhihu.com/p/149372947
# Ref: https://www.starduster.me/2020/03/02/linux-network-tuning-kernel-parameter/#netipv4tcp_max_syn_backlog_netipv4tcp_syncookies
# 启用选择应答
# 对于广域网通信应当启用
net.ipv4.tcp_sack=1
# 启用转发应答
# 对于广域网通信应当启用
net.ipv4.tcp_fack=1
# TCP SYN 连接超时重传次数
net.ipv4.tcp_syn_retries=3
net.ipv4.tcp_synack_retries=3
# TCP SYN 连接超时时间, 设置为 5 约为 30s
net.ipv4.tcp_retries2=5
# 开启 SYN 洪水攻击保护
# 注意: tcp_syncookies 启用时, 此时实际上没有逻辑上的队列长度, 
# Backlog 设置将被忽略. syncookie 是一个出于对现实的妥协, 
# 严重违反 TCP 协议的设计, 会造成 TCP option 不可用, 且实现上
# 通过计算 hash 避免维护半开连接也是一种 tradeoff 而非万金油, 
# 勿听信所谓“安全优化教程”而无脑开启
net.ipv4.tcp_syncookies=0

# Ref: https://linuxgeeks.github.io/2017/03/20/212135-Linux%E5%86%85%E6%A0%B8%E5%8F%82%E6%95%B0rp_filter/
# 开启反向路径过滤
# Aliyun 负载均衡实例后端的 ECS 需要设置为 0
net.ipv4.conf.default.rp_filter=2
net.ipv4.conf.all.rp_filter=2

# 减少处于 FIN-WAIT-2 连接状态的时间使系统可以处理更多的连接
# Ref: https://www.cnblogs.com/kaishirenshi/p/11544874.html
net.ipv4.tcp_fin_timeout=10

# Ref: https://xwl-note.readthedocs.io/en/latest/linux/tuning.html
# 默认情况下一个 TCP 连接关闭后, 把这个连接曾经有的参数保存到dst_entry中
# 只要 dst_entry 没有失效,下次新建立相同连接的时候就可以使用保存的参数来初始化这个连接.通常情况下是关闭的
net.ipv4.tcp_no_metrics_save=1
# unix socket 最大队列
net.unix.max_dgram_qlen=1024
# 路由缓存刷新频率
net.ipv4.route.gc_timeout=100

# Ref: https://gist.github.com/lixingcong/0e13b4123d29a465e364e230b2e45f60
# 启用 MTU 探测，在链路上存在 ICMP 黑洞时候有用（大多数情况是这样）
net.ipv4.tcp_mtu_probing = 1

# No Ref
# 开启并记录欺骗, 源路由和重定向包
net.ipv4.conf.all.log_martians=1
net.ipv4.conf.default.log_martians=1
# 处理无源路由的包
net.ipv4.conf.all.accept_source_route=0
net.ipv4.conf.default.accept_source_route=0
# TCP KeepAlive 调优
# 最大闲置时间
net.ipv4.tcp_keepalive_time=300
# 最大失败次数, 超过此值后将通知应用层连接失效
net.ipv4.tcp_keepalive_probes=2
# 发送探测包的时间间隔
net.ipv4.tcp_keepalive_intvl=2
# 系统所能处理不属于任何进程的TCP sockets最大数量
net.ipv4.tcp_max_orphans=262144
# arp_table的缓存限制优化
net.ipv4.neigh.default.gc_thresh1=128
net.ipv4.neigh.default.gc_thresh2=512
net.ipv4.neigh.default.gc_thresh3=4096
net.ipv4.neigh.default.gc_stale_time=120
net.ipv4.conf.default.arp_announce=2
net.ipv4.conf.lo.arp_announce=2
net.ipv4.conf.all.arp_announce=2
# ------ END 网络调优: 其他 ------

# ------ 内核调优 ------

# Ref: Aliyun, etc
# 内核 Panic 后 1 秒自动重启
kernel.panic=1
# 允许更多的PIDs, 减少滚动翻转问题
kernel.pid_max=32768
# 内核所允许的最大共享内存段的大小（bytes）
kernel.shmmax=4294967296
# 在任何给定时刻, 系统上可以使用的共享内存的总量（pages）
kernel.shmall=1073741824
# 设定程序core时生成的文件名格式
kernel.core_pattern=core_%e
# 当发生oom时, 自动转换为panic
vm.panic_on_oom=1
# 表示强制Linux VM最低保留多少空闲内存（Kbytes）
# vm.min_free_kbytes=1048576
# 该值高于100, 则将导致内核倾向于回收directory和inode cache
vm.vfs_cache_pressure=250
# 表示系统进行交换行为的程度, 数值（0-100）越高, 越可能发生磁盘交换
vm.swappiness=10
# 仅用10%做为系统cache
vm.dirty_ratio=10
vm.overcommit_memory=1
# 增加系统文件描述符限制
# Fix error: too many open files
fs.file-max=1048575
fs.inotify.max_user_instances=8192
fs.inotify.max_user_instances=8192
# 内核响应魔术键
kernel.sysrq=1
# 弃用
# net.ipv4.tcp_low_latency=1

# Ref: https://gist.github.com/lixingcong/0e13b4123d29a465e364e230b2e45f60
# 当某个节点可用内存不足时, 系统会倾向于从其他节点分配内存. 对 Mongo/Redis 类 cache 服务器友好
vm.zone_reclaim_mode=0
EOF
sysctl -p
