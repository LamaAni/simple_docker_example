FROM ubuntu:latest

USER root

# gernal linux args
ARG DEBIAN_FRONTEND=noninteractive
ENV TERM linux

# initialzing apt.
# and then setting the local to match us. (locals and on)
RUN apt-get update -yqq &&\
    apt-get upgrade -yqq &&\
    apt-get install -yqq --no-install-recommends apt-utils&&\
    # locale
    apt-get install -yqq --no-install-recommends locales &&\
    sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen &&\
    locale-gen &&\
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# install tools
RUN apt-get install -yqq\
    curl\
    gnupg\
    htop\
    sudo\
    # networking
    netcat\
    nmap\
    iputils-ping\
    # git
    git

########### kubernetes

# install kubectl tool
RUN curl -o /usr/local/bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.9.11/bin/linux/amd64/kubectl &&\
    chmod +x /usr/local/bin/kubectl

###########
# config

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# do nothing.
ENTRYPOINT ["/entrypoint.sh"]