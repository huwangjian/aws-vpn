yum install haproxy -y

mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak
cp ./haproxy.cfg /etc/haproxy/haproxy.cfg

haproxy -f /etc/haproxy/haproxy.cfg -D

