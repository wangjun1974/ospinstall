### 在 helper 虚拟机里安装 container registry
```
# 添加 /etc/hosts 记录
HOST_IP=$( ip a s dev ens3 | grep -E "inet " | awk '{print $2}' | awk -F'/' '{print $1}' )
[root@undercloud repos]# > /etc/yum.repos.d/osp.repo 
cat >> /etc/hosts << EOF
${HOST_IP} helper.example.com
EOF

# 拷贝 podman-docker-registry-v2.image.tgz 和 
# osp16.1-poc-registry-2021-01-15.tar.gz 到 helper 所在的主机
[root@helper ~]# ls -l *.tar.gz *.tgz
-rw-r--r--. 1 root root 5199344504 Jan 20 12:48 osp16.1-poc-registry-2021-01-15.tar.gz
-rw-r--r--. 1 root root    9801251 Jan 20 12:46 podman-docker-registry-v2.image.tgz

# 安装软件 container registry 所需软件
yum -y install podman httpd httpd-tools wget jq

# 创建目录
mkdir -p /opt/registry/{auth,certs,data}

# 解压缩 osp16.1-poc-registry-2021-01-15.tar.gz 文件
tar zxvf osp16.1-poc-registry-2021-01-15.tar.gz -C /

# 在本地建立证书信任
cp /opt/registry/certs/domain.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust extract

# 开放防火墙端口
firewall-cmd --add-port=5000/tcp --zone=internal --permanent
firewall-cmd --add-port=5000/tcp --zone=public   --permanent
firewall-cmd --reload

# 在 helper 上导入 docker-registry 镜像
tar xvf podman-docker-registry-v2.tar
podman load -i docker-registry

# 创建脚本
cat > /usr/local/bin/localregistry.sh << 'EOF'
#!/bin/bash
podman run --name poc-registry -d -p 5000:5000 \
-v /opt/registry/data:/var/lib/registry:z \
-v /opt/registry/certs:/certs:z \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
-e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
localhost/docker-registry:latest 
EOF

# 添加可执行权限
chmod +x /usr/local/bin/localregistry.sh

# 启动 registry 
/usr/local/bin/localregistry.sh

# 访问 registry 查看 v2 catalog
curl https://helper.example.com:5000/v2/_catalog

# 在 helper上添加 undercloud.example.com 到 /etc/hosts
cat >> /etc/hosts << EOF
192.168.8.21 undercloud.example.com
EOF

# 拷贝 registry 证书到 undercloud
# 添加 registry 证书到 undrecloud 的信任
scp /opt/registry/certs/domain.crt stack@undercloud.example.com:~
ssh stack@undercloud.example.com sudo cp /home/stack/domain.crt /etc/pki/ca-trust/source/anchors/
ssh stack@undercloud.example.com sudo update-ca-trust extract

# 在 undercloud 上添加 helper 的 hosts 记录
ssh stack@undercloud.example.com 
sudo -i
cat >> /etc/hosts << EOF

192.168.8.20 helper.example.com
EOF

# 访问 helper.example.com 的 registry catalog
curl https://helper.example.com:5000/v2/_catalog

```