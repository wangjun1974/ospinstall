### OSP16.1 containers-prepare-parameter.yaml 的例子
```
# 默认情况下 osp16.1 以 registry.redhat.io 为上游镜像服务器
# 镜像会首先拉取到 undercloud 上给 undercloud 和 overcloud 使用
# 因此，一般情况需要设置 ContainerImageRegistryCredentials
# ContainerImageRegistryCredentials 的格式为
#   ContainerImageRegistryCredentials:
#     <registry.fqdn>:
#        <user>: <pass>
# 如果从红帽官网拉镜像，Red Hat 推荐使用 service account
# 参见：https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/16.1/html/advanced_overcloud_customization/sect-containerized_services#container-image-preparation-parameters
# 参见：https://access.redhat.com/RegistryAuthentication
# 在以下网址创建所需的 registry service accounts
# https://access.redhat.com/terms-based-registry/#/accounts
parameter_defaults:
  ContainerImagePrepare:
  - push_destination: true
    set:
      ceph_alertmanager_image: ose-prometheus-alertmanager
      ceph_alertmanager_namespace: registry.redhat.io/openshift4
      ceph_alertmanager_tag: 4.1
      ceph_grafana_image: rhceph-4-dashboard-rhel8
      ceph_grafana_namespace: registry.redhat.io/rhceph
      ceph_grafana_tag: 4
      ceph_image: rhceph-4-rhel8
      ceph_namespace: registry.redhat.io/rhceph
      ceph_node_exporter_image: ose-prometheus-node-exporter
      ceph_node_exporter_namespace: registry.redhat.io/openshift4
      ceph_node_exporter_tag: v4.1
      ceph_prometheus_image: ose-prometheus
      ceph_prometheus_namespace: registry.redhat.io/openshift4
      ceph_prometheus_tag: 4.1
      ceph_tag: latest
      name_prefix: openstack-
      name_suffix: ''
      namespace: registry.redhat.io/rhosp-rhel8
      neutron_driver: ovn
      rhel_containers: false
      tag: '16.1'
    tag_from_label: '{version}-{release}'
  ContainerImageRegistryCredentials:
    registry.redhat.io:
      6747835|jwang: eyJhbGciOiJSUzUxMi...
```