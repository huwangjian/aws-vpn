yum remove -y pptpd ppp
iptables --flush POSTROUTING --table nat
iptables --flush FORWARD
rm -rf /etc/pptpd.conf
rm -rf /etc/ppp

yum install dkms
wget http://poptop.sourceforge.net/yum/stable/rhel6/x86_64/ppp-2.4.5-33.0.rhel6.x86_64.rpm
wget http://poptop.sourceforge.net/yum/stable/rhel6/x86_64/pptpd-1.4.0-1.el6.x86_64.rpm

rpm -i ppp-2.4.5-33.0.rhel6.x86_64.rpm
rpm -i pptpd-1.4.0-1.el6.x86_64.rpm

sed -i 's/^logwtmp/#logwtmp/g' /etc/pptpd.conf

sed -i 's/^net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
sysctl -p

echo "localip 10.0.0.1" >> /etc/pptpd.conf
echo "remoteip 10.0.0.2-10" >> /etc/pptpd.conf
echo "ms-dns 8.8.8.8" >> /etc/ppp/options.pptpd
echo "ms-dns 8.8.4.4" >> /etc/ppp/options.pptpd

echo "vpn pptpd vpntest *" >> /etc/ppp/chap-secrets

iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -p tcp --syn -s 10.0.0.0/24 -j TCPMSS --set-mss 1356
service iptables save

chkconfig iptables on
chkconfig pptpd on

service iptables start
service pptpd start
