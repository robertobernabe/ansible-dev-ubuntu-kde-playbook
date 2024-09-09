FROM ubuntu:24.04

# Set the frontend to 'noninteractive' to avoid prompts
ARG DEBIAN_FRONTEND=noninteractive
# Set timezone
ENV TZ=Europe/Berlin

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
# This variable is used to break system packages when installing Python packages using pip at system level.
ENV PIP_BREAK_SYSTEM_PACKAGES="1"

# Install apt packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
        apt-utils \
        apt-transport-https \
        gnupg-agent \
        ca-certificates \
        curl \
        git \
        gnupg \
        jq \
        language-pack-en-base \
        locales \
        openssh-client \
        python3 \
        python3-pip \
        python3-venv \
        software-properties-common \
        sshpass \
        vim

RUN dpkg-reconfigure locales \
        && locale-gen en_US.UTF-8 \
        && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Install pip modules
RUN pip3 install --no-cache-dir \
        ansible==9.9.0 \
        molecule[ansible]==24.7.0 \
        molecule-plugins[docker]==23.5.3 \
        ansible-lint==24.7.0 \
        yamllint==1.35.1\
        requests==2.32.3

# Install Docker for running docker in docker
RUN  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive.gpg \
        &&  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
        && apt-get update \
        && apt-get install -y docker-ce docker-ce-cli containerd.io


COPY entrypoint.sh /opt/entrypoint.sh

# Run the entrypoint when image is ran
ENTRYPOINT [ "/bin/bash", "/opt/entrypoint.sh" ]
