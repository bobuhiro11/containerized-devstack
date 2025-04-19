#!/bin/bash -xe

nova-manage cell_v2 discover_hosts --verbose

sudo systemctl restart devstack@q-l3
sudo systemctl restart devstack@q-meta

sleep 10
openstack compute service list
openstack network agent list

net_id=$(openstack network show private -f json 2>/dev/null | jq -r .id | tr -d "\r\n")
image=$(openstack image list | awk '/cirros/ { print $4 }')

openstack server create --image $image --flavor m1.medium \
  --nic net-id=$net_id --availability-zone=nova:controller testvm
sleep 60

ip=$(openstack server show testvm -f json | jq -r '.addresses.private[0]')

openstack server list
openstack server show testvm | grep ACTIVE
openstack server delete testvm

sudo journalctl --no-pager -n 300 -eu devstack@n-cpu
sudo journalctl --no-pager -n 300 -eu devstack@q-agt
