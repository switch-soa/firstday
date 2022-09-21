tee /etc/sysctl.conf <<-'EOF'
net.ipv4.neigh.default.gc_thresh1 = 4096
net.ipv4.neigh.default.gc_thresh2 = 6144
net.core.netdev_max_backlog = 2500
net.core.somaxconn = 80000
net.ipv4.tcp_rmem = 4096 87380   16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.core.rmem_default = 1048576
net.core.wmem_default = 524288
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_max_syn_backlog = 102400
fs.aio-max-nr = 3145728
fs.file-max = 100000000
kernel.pid_max = 4194303
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
net.ipv4.conf.all.promote_secondaries = 1
net.ipv4.conf.default.promote_secondaries = 1
net.ipv6.neigh.default.gc_thresh3 = 4096
net.ipv4.neigh.default.gc_thresh3 = 4096
kernel.softlockup_panic = 1
kernel.sysrq = 1
net.ipv6.conf.all.disable_ipv6 = 0
net.ipv6.conf.default.disable_ipv6 = 0
net.ipv6.conf.lo.disable_ipv6 = 0
kernel.numa_balancing = 0
kernel.shmmax = 68719476736
kernel.printk = 5
net.ipv4.ip_local_reserved_ports = 30000-32767
vm.max_map_count = 262144
vm.swappiness = 1
fs.inotify.max_user_instances = 524288
EOF
#net.bridge.bridge-nf-call-arptables = 1
#net.bridge.bridge-nf-call-ip6tables = 1
#net.bridge.bridge-nf-call-iptables = 1
echo 'ulimit -n 1048576' >> /etc/profile
ulimit -l unlimited
ulimit -a
sysctl -p
systemctl restart network
for CPUFREQ in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do [ -f $CPUFREQ ] || continue; echo -n performance > $CPUFREQ; done
echo 0 > /proc/sys/kernel/hung_task_timeout_secs