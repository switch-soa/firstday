#!/bin/bash

export K3S_RUN_DIR=/tmp/public/kxs

mkdir -p /var/lib/rancher/k3s/server
echo "$(hostname -I|awk '{print $1}')" > /etc/hostname
sysctl -w kernel.hostname=$(cat /etc/hostname)
hostname

setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
getenforce


ln -sf ${K3S_RUN_DIR}/k3s/get.k3s.io.sh /usr/local/bin/get.k3s.io.sh
ln -sf ${K3S_RUN_DIR}/k3s/k3s /usr/local/bin/k3s
chmod +x ${K3S_RUN_DIR}/k3s/get.k3s.io.sh ${K3S_RUN_DIR}/k3s/k3s
k3s -v

if [ -f ${K3S_RUN_DIR}/k3s/k3s-airgap-images-amd64.tar.gz ]; then
	mkdir -p /var/lib/rancher/k3s/agent/images/k3s-airgap-images-amd64/
	tar -zvxf ${K3S_RUN_DIR}/k3s/k3s-airgap-images-amd64.tar.gz -C /var/lib/rancher/k3s/agent/images/k3s-airgap-images-amd64/
#	rm -rf ${K3S_RUN_DIR}/k3s/k3s-airgap-images-amd64.tar.gz
fi

echo "$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')" > /var/lib/rancher/k3s/server/token_row
cat /var/lib/rancher/k3s/server/token_row
INSTALL_K3S_SELINUX_WARN=true INSTALL_K3S_SKIP_DOWNLOAD=true K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/token_row) get.k3s.io.sh --cluster-init --disable-cloud-controller --disable traefik --selinux --flannel-backend=vxlan --bind-address=0.0.0.0
sleep 3
systemctl status k3s.service
sleep 30
kubectl get nodes
kubectl get pod -A