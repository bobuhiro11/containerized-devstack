FROM ubuntu:24.04

EXPOSE 80 5000 8773 8774 8775 8776 9292
ENV DEBIAN_FRONTEND=noninteractive
ENV DEVSTACK_COMMIT=608ae718fca61e557b315f87900a54a7fb40b07e

ENV OS_REGION_NAME=RegionOne
ENV OS_PROJECT_DOMAIN_ID=default
ENV OS_CACERT=
ENV OS_AUTH_URL=http://172.28.0.2/identity
ENV OS_TENANT_NAME=admin
ENV OS_USER_DOMAIN_ID=default
ENV OS_USERNAME=admin
ENV OS_VOLUME_API_VERSION=3
ENV OS_AUTH_TYPE=password
ENV OS_PROJECT_NAME=admin
ENV OS_PASSWORD=password
ENV OS_IDENTITY_API_VERSION=3

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    patch \
    systemd \
    sudo \
    iproute2 \
    lsb-release \
    git \
    curl \
    init \
    ebtables \
    jq \
    openvswitch-switch \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/* \
  && curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /bin/wait-for-it.sh \
  && chmod a+x /bin/wait-for-it.sh \
  && useradd -s /bin/bash -d /opt/stack -m stack \
  && mkdir -p /etc/sudoers.d/ \
  && echo "stack ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/stack \
  # https://review.opendev.org/c/openstack/devstack/+/838645 \
  && chmod +x /opt/stack \
  && systemctl enable openvswitch-switch.service

WORKDIR /opt/stack
RUN git clone https://github.com/openstack/devstack.git \
  && git -C ./devstack checkout $DEVSTACK_COMMIT \
  && chown -R stack:stack ./devstack

COPY compute/local.conf /opt/stack/devstack/
COPY compute/devstack.service /etc/systemd/system/
COPY test.bash /bin/
COPY pre-commit.bash /bin/

RUN systemctl enable devstack

STOPSIGNAL SIGRTMIN+3
CMD [ "/sbin/init" ]
