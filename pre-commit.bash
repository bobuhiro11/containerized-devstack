#!/bin/bash -xe

systemctl disable devstack

# Disable loading kmod for openvswitch on "ovs-ctl start"
sed -i -e 's/insert_mod_if_required.*return 1/#&/' /usr/share/openvswitch/scripts/ovs-ctl

# Add auth info for nova-compute
# https://bugs.launchpad.net/devstack/+bug/1996465
cat << EOF | tee -a /etc/nova/nova-cpu.conf
[placement]
region_name = RegionOne
project_domain_name = Default
project_name = service
user_domain_name = Default
password = password
username = placement
auth_url = http://172.28.0.2/identity
auth_type = password
EOF

# Disable namespace in libvirt/qemu.conf
# https://listman.redhat.com/archives/libvirt-users/2017-February/009734.html
echo 'namespaces = []' >> /etc/libvirt/qemu.conf
