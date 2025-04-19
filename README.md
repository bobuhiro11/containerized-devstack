# containerized-devstack

This project easily deploys OpenStack in docker & docker compose.
This is mainly for development purpose.

NOTE: This is only tested on **x64 Ubuntu 24.04 machine**. It may work
on other Linux Distributions. Other CPU architectures and operating
systems cannot be supported.

# Usage

The docker compose command launches an OpenStack environment based
on preconfigured container images. The images are huge and will take
some time to download, but once complete, you should be up and running
in less than a minute thereafter.

An example is shown below:

```bash
curl -sLO https://raw.githubusercontent.com/bobuhiro11/containerized-devstack/main/docker-compose.yaml
sudo docker-compose up
```

You can use the OpenStack CLI in the container.

```bash
sudo docker compose exec controller openstack compute service list
# +--------------------------------------+----------------+------------+----------+---------+-------+----------------------------+
# | ID                                   | Binary         | Host       | Zone     | Status  | State | Updated At                 |
# +--------------------------------------+----------------+------------+----------+---------+-------+----------------------------+
# | 2d1c874e-3cba-4098-a8c9-7ca8d7f69e1d | nova-scheduler | controller | internal | enabled | up    | 2023-04-19T03:18:49.000000 |
# | 70ae8443-fce7-465a-a69b-455e661e80c1 | nova-conductor | controller | internal | enabled | up    | 2023-04-19T03:18:49.000000 |
# | 1a489657-cbb7-4efd-8ab6-a597de8aac1a | nova-conductor | controller | internal | enabled | up    | 2023-04-19T03:18:48.000000 |
# | 7f9d98c2-05e6-40c4-b59d-d5cd0ece7f7f | nova-compute   | controller | nova     | enabled | up    | 2023-04-19T03:18:50.000000 |
# | a01e676b-ed7b-4c29-be20-599e9e6564e4 | nova-compute   | compute-2  | nova     | enabled | up    | 2023-04-19T03:18:54.000000 |
# | 3a3ec69d-f2d3-477a-b0b5-14b9924e1b5b | nova-compute   | compute-1  | nova     | enabled | up    | 2023-04-19T03:18:55.000000 |
# +--------------------------------------+----------------+------------+----------+---------+-------+----------------------------+

sudo docker compose exec controller openstack network agent list
# +--------------------------------------+--------------------+------------+-------------------+-------+-------+---------------------------+
# | ID                                   | Agent Type         | Host       | Availability Zone | Alive | State | Binary                    |
# +--------------------------------------+--------------------+------------+-------------------+-------+-------+---------------------------+
# | 6652233d-141f-4b04-ad62-74304afb4deb | Open vSwitch agent | controller | None              | :-)   | UP    | neutron-openvswitch-agent |
# | cf7aec73-0a3d-4b71-ae9b-630c8075f0e5 | DHCP agent         | controller | nova              | :-)   | UP    | neutron-dhcp-agent        |
# | ee925744-dd85-4cfb-9dae-9f2ccc3e1bff | Metadata agent     | controller | None              | :-)   | UP    | neutron-metadata-agent    |
# | ef62635e-1da2-4689-b7a6-afc46b7a1c16 | L3 agent           | controller | nova              | :-)   | UP    | neutron-l3-agent          |
# ...
# +--------------------------------------+--------------------+------------+-------------------+-------+-------+---------------------------+
```

The image contains a script `/bin/test.bash` to check some operations.
This confirms that the VM is booted.

```bash
sudo docker compose exec controller /bin/test.bash
# + openstack server create --image cirros-0.5.2-x86_64-disk --flavor m1.medium ...
# + openstack server list
# +--------------------------------------+--------+--------+------------+-------------+-------------------+
# | ID                                   | Name   | Status | Task State | Power State | Networks          |
# +--------------------------------------+--------+--------+------------+-------------+-------------------+
# | 0c097d40-7bfe-4d1e-af01-02b95018397a | testvm | ACTIVE | -          | Running     | private=10.0.0.29 |
# +--------------------------------------+--------+--------+------------+-------------+-------------------+
```

# Reference

- https://github.com/janmattfeld/DockStack
- https://github.com/bodenr/docker-devstack
- https://github.com/ewindisch/dockenstack
