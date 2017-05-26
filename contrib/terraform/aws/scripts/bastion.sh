#!/bin/bash

apt-get update
apt-get -y install python-pip python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev
pip install --upgrade pip
pip install ansible netaddr

git clone https://github.com/stanchan/fusion.git /opt/fusion
#printf '\n## Support Python 3 for Ubuntu 16.04\nansible_python_interpreter: /usr/bin/python3' >> /opt/fusion/inventory/group_vars/all.yml

if [[ ! -d ~/.ssh ]]; then
	mkdir ~/.ssh
fi

if [[ ! -f ~/.ssh/id_rsa ]]; then
	if [[ -f /tmp/id_rsa ]]; then
		mv /tmp/id_rsa ~/.ssh/id_rsa
		chmod 600 ~/.ssh/id_rsa
		chown $(id -nu) ~/.ssh/id_rsa
	fi
fi
