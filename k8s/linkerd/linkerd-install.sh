#!/bin/bash
# NOTE: installing linkerd with CLI

# Download binaries to some temp location
mkdir -p /tmp/linkerd-install
cd /tmp/linkerd-install


#######################
#     Install HELM    #
#######################
helm version > /dev/null 2>&1
if [ $? -ne 0 ]; then
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
else
    echo "helm is already installed"
fi

##############################
#     Install linkerd CLI    #
##############################
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh
export PATH=$PATH:$HOME/.linkerd2/bin
linkerd version

######################################
#    Install linkerd control-plane   #
######################################

# Validate K8s cluster to install linkerd
linkerd check --pre

linkerd install --crds | kubectl apply -f -
linkerd install --set proxyInit.runAsRoot=true | kubectl apply -f -
sleep 45
linkerd check  # Verify linkerd
