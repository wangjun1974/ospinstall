### 可以从网址生成 https://access.redhat.com/labsinfo/kickstartconfig
可以从网址生成 https://access.redhat.com/labsinfo/kickstartconfig
```
cat > /tmp/ks.cfg <<'EOF'
lang en_US
keyboard us
timezone Asia/Shanghai --isUtc
rootpw $1$PTAR1+6M$DIYrE6zTEo5dWWzAp9as61 --iscrypted
#platform x86, AMD64, or Intel EM64T
reboot
text
cdrom
bootloader --location=mbr --append="rhgb quiet crashkernel=auto"
zerombr
clearpart --all --initlabel
autopart
network --device=ens3 --hostname=helper.example.com --bootproto=static --ip=192.168.10.42 --netmask=255.255.255.0 --gateway=192.168.10.1 --nameserver=119.29.29.29 --vlanid 10
auth --passalgo=sha512 --useshadow
selinux --enforcing
firewall --enabled --ssh
skipx
firstboot --disable
%packages
@^minimal-environment
kexec-tools
%end
EOF
```

vlan 配置参见：https://access.redhat.com/solutions/25133