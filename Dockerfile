from debian:bullseye-slim

RUN useradd -ms /bin/bash admin

ARG OS=Debian_11
ARG CRIO_VERSION=1.25
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update -qq \
    && apt-get install -y -qq --no-install-recommends \
               apt-transport-https \
               ca-certificates \
               curl \
               gnupg2 \
    && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /"|tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
    &&    echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS/ /"|tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list \
    && curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION/$OS/Release.key | apt-key add - \
    && curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | apt-key add - \
    && apt-get update -qq \
    && apt-get install -y -qq --no-install-recommends \
               cri-tools \
               skopeo \
