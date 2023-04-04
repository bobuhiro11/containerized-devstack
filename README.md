# containerized-devstack

This project easily deploys OpenStack in docker & docker-compose.
This is mainly for development purpose.

NOTE: This is only tested on x64 Ubuntu 20.04 machine. It may work
on other Linux Distributions. Other CPU architectures and operating
systems cannot be supported.

# Usage

`docker-compose` will execute the initialization process of the
devstack and automatically launch the major OpenStack components.
This will take about 30 minutes.

```bash
sudo docker-compose up -d
sudo docker-compose logs -f
# controller    | This is your host IP address: 172.28.0.2
# controller    | Horizon is now available at http://172.28.0.2/dashboard
# controller    | Keystone is serving at http://172.28.0.2/identity/
# controller    | The default users are: admin and demo
# controller    | The password: nomoresecret
# controller    |
# controller    | Services are running under systemd unit files.
# controller    | For more information see:
# controller    | https://docs.openstack.org/devstack/latest/systemd.html
# controller    |
# controller    | DevStack Version: 2023.1
# controller    | Change:
# controller    | OS Version: Ubuntu 20.04 focal
```

You can use the OpenStack CLI in the container.

```bash
sudo docker-compose exec --user stack controller /bin/bash -c 'openstack image list'
# +--------------------------------------+--------------------------+--------+
# | ID                                   | Name                     | Status |
# +--------------------------------------+--------------------------+--------+
# | 77b07900-9dab-4ba9-b169-883868e8ecf9 | cirros-0.5.2-x86_64-disk | active |
# +--------------------------------------+--------------------------+--------+
```

# Reference

- https://github.com/janmattfeld/DockStack
- https://github.com/bodenr/docker-devstack
- https://github.com/ewindisch/dockenstack
