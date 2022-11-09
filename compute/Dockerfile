FROM ubuntu:20.04

EXPOSE 80 5000 8773 8774 8775 8776 9292
ENV DEBIAN_FRONTEND=noninteractive
ENV DEVSTACK_COMMIT=a4680766515ed9317b71cfb39cd0d75dc04f3d9c

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates=20211016~20.04.1 \
    patch=2.7.6-6 \
    systemd=245.4-4ubuntu3.18 \
    sudo=1.8.31-1ubuntu1.2 \
    iproute2=5.5.0-1ubuntu1 \
    lsb=11.1.0ubuntu2 \
    git=1:2.25.1-1ubuntu3.6 \
    curl=7.68.0-1ubuntu2.14 \
    init=1.57 \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/* \
  && curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /bin/wait-for-it.sh \
  && chmod a+x /bin/wait-for-it.sh \
  && useradd -s /bin/bash -d /opt/stack -m stack \
  && mkdir -p /etc/sudoers.d/ \
  && echo "stack ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/stack

WORKDIR /opt/stack
RUN git clone https://github.com/openstack/devstack.git \
  && git -C ./devstack checkout $DEVSTACK_COMMIT \
  && chown -R stack:stack ./devstack

COPY compute/local.conf /opt/stack/devstack/
COPY compute/devstack.service /etc/systemd/system/
COPY 0001-devstack-disable-ovs.patch /opt/stack/

RUN patch -d ./devstack -p1 < 0001-devstack-disable-ovs.patch \
  && systemctl enable devstack

STOPSIGNAL SIGRTMIN+3
CMD [ "/sbin/init" ]
