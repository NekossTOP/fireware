cat >> /etc/sysctl.conf << EOF
net.ipv4.ip_forward = 1
net.ipv4.tcp_collapse_max_bytes = 6291456
net.ipv4.udp_rmem_min = 16384
net.ipv4.conf.all.forwarding = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_adv_win_scale = 1
net.ipv4.tcp_bypass_slc = 1
net.ipv4.tcp_fcs_optimization = 2
net.ipv4.tcp_rmem = 8192 262144 536870912
net.ipv4.conf.default.forwarding = 1
net.ipv4.tcp_notsent_lowat = 131072
net.core.default_qdisc = fq
net.ipv4.udp_wmem_min = 16384
net.ipv4.tcp_congestion_control = bbr
net.ipv4.conf.all.route_localnet = 1
net.ipv4.tcp_wmem = 8192 262144 536870912
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.eth0.disable_ipv6 = 1
EOF
sysctl -p
