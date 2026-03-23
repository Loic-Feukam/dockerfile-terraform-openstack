# Dockerfile pour Terraform sur Ubuntu 22.04 amd64 via le dépôt officiel
FROM ubuntu:22.04

# Installer les dépendances nécessaires pour ajouter le dépôt
RUN apt update && apt install -y --no-install-recommends \
    curl \
    wget \
    make \
    gnupg \
    lsb-release \
    software-properties-common \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Add GPG key official HashiCorp

RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add repository

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/hashicorp.list

# Installation of Terraform and Openstack 

RUN apt update && apt install -y terraform \
    python3-pip \
    && pip3 install openstacksdk python-openstackclient \
    && rm -rf /var/lib/apt/lists/* 

# Commande par défaut

CMD ["tail" , "-f" , "/dev/null"]

