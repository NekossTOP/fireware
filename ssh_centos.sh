# 定义要修改的SSH端口
NEW_PORT=5322
# 备份SSH配置文件
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
# 使用sed命令替换SSH配置文件中的端口号
sed -i "s/^#Port .*/Port $NEW_PORT/" /etc/ssh/sshd_config
# 在系统防火墙中添加要修改的端口
firewall-cmd --zone=public --add-port=$NEW_PORT/tcp –permanent
# 临时关闭SELinux
setenforce 0
# 重启系统防火墙
systemctl restart firewalld.service
# 重启SSH服务
service sshd restart
