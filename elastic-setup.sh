#!/usr/bin/env bash

# Update and prepare OS
echo "rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch"
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
echo "cp ${PWD}/elastic.repo /etc/yum.repo.d/"
cp "${PWD}"/elastic.repo /etc/yum.repos.d/
echo "yum update -y && yum upgrade -y && yum distro-sync -y"
yum update -y && yum upgrade -y && yum distro-sync -y
echo "yum install -y java-latest-openjdk"
yum install -y java-latest-openjdk


# Install elasticsearch
echo "yum install -y elasticsearch"
yum install -y elasticsearch
echo "cp ${PWD}/elasticsearch.service /usr/lib/systemd/system/elasticsearch.service"
cp "${PWD}"/elasticsearch.service /usr/lib/systemd/system/elasticsearch.service
echo "cp ${PWD}/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml"
cp "${PWD}"/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
echo "systemctl daemon-reload"
systemctl daemon-reload
echo "systemctl enable elasticsearch.service"
systemctl enable elasticsearch.service
echo "systemctl start elasticsearch.service"
systemctl start elasticsearch.service

# Reboot to be up to date
echo "reboot"
reboot
