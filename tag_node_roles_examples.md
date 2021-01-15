### 为 controller，compute, cephstorage 节点打标签的例子
```
# 说明 boot_option:local 后的 内容是节点原来的 property capabilities 的内容
# 可以用命令获取
# (undercloud) [stack@undercloud ~]$ openstack baremetal node show overcloud-ctrl01 -f json | jq '.properties.capabilities'
# controller
(undercloud) [stack@undercloud ~]$ openstack baremetal node set --property capabilities='node:controller-0,boot_option:local,cpu_aes:true,cpu_hugepages:true,cpu_hugepages_1g:true,cpu_vt:true' overcloud-ctrl01
(undercloud) [stack@undercloud ~]$ openstack baremetal node set --property capabilities='node:controller-1,boot_option:local,cpu_aes:true,cpu_hugepages:true,cpu_hugepages_1g:true,cpu_vt:true' overcloud-ctrl02
(undercloud) [stack@undercloud ~]$ openstack baremetal node set --property capabilities='node:controller-2,boot_option:local,cpu_aes:true,cpu_hugepages:true,cpu_hugepages_1g:true,cpu_vt:true' overcloud-ctrl03

# compute
(undercloud) [stack@undercloud ~]$ openstack baremetal node set --property capabilities='node:compute-0,boot_option:local,cpu_aes:true,cpu_hugepages:true,cpu_hugepages_1g:true,cpu_vt:true' overcloud-compute01
(undercloud) [stack@undercloud ~]$ openstack baremetal node set --property capabilities='node:compute-1,boot_option:local,cpu_aes:true,cpu_hugepages:true,cpu_hugepages_1g:true,cpu_vt:true' overcloud-compute02

# cephstorage
(undercloud) [stack@undercloud ~]$ openstack baremetal node set --property capabilities='node:cephstorage-0,boot_option:local,cpu_aes:true,cpu_hugepages:true,cpu_hugepages_1g:true,cpu_vt:true' overcloud-ceph01
(undercloud) [stack@undercloud ~]$ openstack baremetal node set --property capabilities='node:cephstorage-1,boot_option:local,cpu_aes:true,cpu_hugepages:true,cpu_hugepages_1g:true,cpu_vt:true' overcloud-ceph02
(undercloud) [stack@undercloud ~]$ openstack baremetal node set --property capabilities='node:cephstorage-2,boot_option:local,cpu_aes:true,cpu_hugepages:true,cpu_hugepages_1g:true,cpu_vt:true' overcloud-ceph03
```
