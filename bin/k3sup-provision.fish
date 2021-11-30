#! /usr/bin/env fish

set -x ssh_user shikun
set -x ssh_key $HOME/.ssh/home_id_rsa
set -x server_ip 10.10.0.50
set -x agent_list 10.10.0.51 10.10.0.52 10.10.0.53

k3sup install \
    --cluster \
    --ip $server_ip --user $ssh_user --ssh-key $ssh_key \
    --merge --local-path $HOME/.kube/kubeconfig.yml --context k3s \
    --k3s-channel latest \
    --k3s-extra-args '--disable servicelb,traefik,local-storage' \
    --print-command

for host in $agent_list
    k3sup join \
        --server-ip $server_ip --server-user $ssh_user --ip $host --user $ssh_user --ssh-key $ssh_key \
        --k3s-channel latest \
        --print-command
end
