apt-get update
apt-get upgrade -y

echo "* soft nofile 65535" >> /etc/security/limits.conf
echo "* hard nofile 65535" >> /etc/security/limits.conf
echo "session required pam_limits.so" >> /etc/pam.d/common-session
echo "ulimit -SHn 65535" >> /etc/profile

sysctl -w fs.file-max=65535 >> /etc/sysctl.conf

sysctl -w net.core.rmem_max=26214400 >> /etc/sysctl.conf
sysctl -w net.core.rmem_default=26214400 >> /etc/sysctl.conf
sysctl -w net.core.wmem_max=26214400 >> /etc/sysctl.conf
sysctl -w net.core.wmem_default=26214400 >> /etc/sysctl.conf
sysctl -w net.core.netdev_max_backlog=4096 >> /etc/sysctl.conf

sysctl -w net.ipv4.tcp_congestion_control=bbr >> /etc/sysctl.conf
sysctl -w net.core.default_qdisc=fq >> /etc/sysctl.conf

sysctl -p

reboot
