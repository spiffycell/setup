#!/bin/bash

set -eEu
set -o pipefail

# vars
K8S_KEY_URL='https://packages.cloud.google.com/apt/doc/apt-key.gpg'
POD_NET_CIDR_BLOCK=''
APISERV_ADDR=''
WORKER_NODES=()
FLANNEL_URL='https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml'

# set hostname
sudo hostnamectl set-hostname master-node

# install deps for k8s
sudo apt-get install apt-transport-https curl

# get key add to package repo
curl -s 'https://packages.cloud.google.com/apt/doc/apt-key.gpg' | sudo apt-key add -

# install packages and validate version
sudo apt-get update
sudo apt-get install kubeadm kubelet kubectl
kubeadm version && kubelet --version && kubectl version
exit 0

# run 
kubeadm init --pod-network=$POD_NET_CIDR_BLOCK --apiserver-advertise-address=$APISERV_ADDR


# set up config file
# does this need to be run for each user on their local systems?
# or just on the master node?
if [[ $(id -u) != 0 ]]; then
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
    chown $(id -u):$(id -g) $HOME/.kube/config
else
    sudo export KUBECONFIG = /etc/kubernetes/admin.conf
fi

for node in "${WORKER_NODES[@]}"
do
    kubeadm join $node --token $token --discovery-token-ca-cert-hash $hash
done

# validate node creation
kubectl get notes

# set up pod network
# grab flannel playbook
kubectl apply -f $FLANNEL_URL

# verify node status of READY
kubectl get nodes

# deploy an application
kubectl create deployment $APP_NAME --image=$IMAGE_NAME
kubectl get deployment $APP_NAME

# create service for app
kubectl create service nodeport $APP_NAME --tcp=$APP_PORT_IN:$APP_PORT_OUT
kubectl get svc
curl localhost:$SVC_PORT
