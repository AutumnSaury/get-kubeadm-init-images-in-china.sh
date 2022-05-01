#!/bin/bash

if [[ $UID -ne 0 ]]; then
  echo 'Please run this script as root.'
  exit 0
fi

for origin in $(kubeadm config images list); do
    mirror=$(echo -e $origin | awk '{sub(/k8s\.gcr\.io(\/coredns)?/, "registry.cn-hangzhou.aliyuncs.com/google_containers"); print $0}')
    docker pull $mirror
    docker tag $mirror $origin
    docker rmi $mirror
done

echo 'Done.'
