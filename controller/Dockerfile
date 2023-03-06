FROM ubuntu:20.04

EXPOSE 80 5000 8773 8774 8775 8776 9292
ENV DEBIAN_FRONTEND=noninteractive
ENV DEVSTACK_COMMIT=ab8e51eb49068a8c5004007c18fdfb9b1fcc0954

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    patch \
    systemd \
    sudo \
    iproute2 \
    lsb \
    git \
    curl \
    init \
    ebtables \
    jq \
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

COPY controller/local.conf /opt/stack/devstack/
COPY controller/devstack.service /etc/systemd/system/
COPY iscsid.service /etc/systemd/system/

RUN systemctl enable devstack

STOPSIGNAL SIGRTMIN+3
CMD [ "/sbin/init" ]
