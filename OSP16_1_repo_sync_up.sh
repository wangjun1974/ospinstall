#!/bin/bash

localPath="/var/www/html/repos/osp16.1/"
fileConn="/getPackage/"

## sync following yum repos 
# rhel-8-for-x86_64-baseos-eus-rpms
# rhel-8-for-x86_64-appstream-eus-rpms
# rhel-8-for-x86_64-highavailability-eus-rpms
# ansible-2.9-for-rhel-8-x86_64-rpms
# openstack-16.1-for-rhel-8-x86_64-rpms
# fast-datapath-for-rhel-8-x86_64-rpms
# rhceph-4-tools-for-rhel-8-x86_64-rpms
# advanced-virt-for-rhel-8-x86_64-rpms

for i in rhel-8-for-x86_64-baseos-eus-rpms rhel-8-for-x86_64-appstream-eus-rpms rhel-8-for-x86_64-highavailability-eus-rpms ansible-2.9-for-rhel-8-x86_64-rpms openstack-16.1-for-rhel-8-x86_64-rpms fast-datapath-for-rhel-8-x86_64-rpms rhceph-4-tools-for-rhel-8-x86_64-rpms advanced-virt-for-rhel-8-x86_64-rpms
do

  rm -rf "$localPath"$i/repodata
  echo "sync channel $i..."
  reposync -n --delete --download-path="$localPath" --repoid $i --downloadcomps --download-metadata

  echo "create repo $i..."
  time createrepo -g $(ls "$localPath"$i/repodata/*comps.xml) --update --skip-stat --cachedir /tmp/empty-cache-dir "$localPath"$i

done

exit 0
