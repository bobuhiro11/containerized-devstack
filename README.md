# containerized-devstack

This project easily deploys OpenStack in docker & docker-compose.
This is mainly for development purpose.

# Usage

`docker-compose` will execute the initialization process of the
devstack and automatically launch the major OpenStack components. 
This will take about 30 minutes.

```bash
$ sudo docker-compose up -d

$ sudo docker-compose logs -f
devstack_1  | This is your host IP address: 172.28.0.2
devstack_1  | Horizon is now available at http://172.28.0.2/dashboard
devstack_1  | Keystone is serving at http://172.28.0.2/identity/
devstack_1  | The default users are: admin and demo
devstack_1  | The password: nomoresecret
devstack_1  |
devstack_1  | Services are running under systemd unit files.
devstack_1  | For more information see:
devstack_1  | https://docs.openstack.org/devstack/latest/systemd.html
devstack_1  |
devstack_1  | DevStack Version: wallaby
devstack_1  | Change:
devstack_1  | OS Version: Ubuntu 20.04 focal
```

You can use the OpenStack CLI in the container.

```bash
$ sudo docker-compose exec \
  --user stack \
  devstack \
  /bin/bash -c 'source devstack/openrc admin admin; exec /bin/bash'

stack@538b06c0fc0b:~$ openstack endpoint list
+----------------------------------+-----------+--------------+----------------+---------+-----------+---------------------------------------------+
| ID                               | Region    | Service Name | Service Type   | Enabled | Interface | URL                                         |
+----------------------------------+-----------+--------------+----------------+---------+-----------+---------------------------------------------+
| 3f865729db974cae886b8e29cbbb91ed | RegionOne | nova_legacy  | compute_legacy | True    | public    | http://172.28.0.2/compute/v2/$(project_id)s |
| 5b4723017af2441dbd7bbccc7f196d49 | RegionOne | keystone     | identity       | True    | admin     | http://172.28.0.2/identity                  |
| 5cfe0eae065c47bbb649937036021f6b | RegionOne | keystone     | identity       | True    | public    | http://172.28.0.2/identity                  |
| 67c0675c2898463b8d0284206bf58ba9 | RegionOne | glance       | image          | True    | public    | http://172.28.0.2/image                     |
| b8181b82dc124c089e8cd38fc23e58e8 | RegionOne | placement    | placement      | True    | public    | http://172.28.0.2/placement                 |
| e17fe28cb31d478c81a3d9b597850ad5 | RegionOne | nova         | compute        | True    | public    | http://172.28.0.2/compute/v2.1              |
+----------------------------------+-----------+--------------+----------------+---------+-----------+---------------------------------------------+
```

# Reference

- https://github.com/janmattfeld/DockStack
- https://github.com/bodenr/docker-devstack
- https://github.com/ewindisch/dockenstack
