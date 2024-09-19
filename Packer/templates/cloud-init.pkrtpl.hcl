#cloud-config
# The above header must generally appear on the first line of a cloud config
# file, but all other lines that begin with a # are optional comments.
packages:
    - apt-transport-https
    - ca-certificates
    - curl
    - gnupg-agent
    - software-properties-common

ssh_pwauth: false
users:
- name: briantical
  gecos: Default User
  groups: users,admin,wheel
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  lock_passwd: true

# create the docker group
groups:
    - docker

# Add default auto created user to docker group
system_info:
default_user:
    groups: [docker]

runcmd:
    ## Configure Tailscale
    # One-command install, from https://tailscale.com/download/
    - ['sh', '-c', 'curl -fsSL https://tailscale.com/install.sh | sh']
    # Set sysctl settings for IP forwarding (useful when configuring an exit node)
    - ['sh', '-c', "echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf && echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf && sudo sysctl -p /etc/sysctl.d/99-tailscale.conf" ]
    # Generate an auth key from your Admin console
    # https://login.tailscale.com/admin/settings/keys
    # and replace the placeholder below
    - ['tailscale', 'up', '--authkey=${tailscale_auth_key}']
    # (Optional) Include this line to make this node available over Tailscale SSH
    - ['tailscale', 'set', '--ssh']
    # (Optional) Include this line to configure this machine as an exit node
    - ['tailscale', 'set', '--advertise-exit-node']

    ## Configure Docker
    # Install Docker
    - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    - apt-get update -y
    - apt-get install -y docker-ce docker-ce-cli containerd.io
    - systemctl start docker
    - systemctl enable docker

    # Configure Root Certificate
    - mv certificate.pub /etc/ssh/certificate.pub
    - chmod 644 /etc/ssh/certificate.pub
    - chown root:root /etc/ssh/certificate.pub
    - tee -a /etc/ssh/sshd_config << EOF
        # Root CA SSH Config
        PubkeyAuthentication yes
        TrustedUserCAKeys /etc/ssh/numida_ca.pub
        EOF
    - systemctl try-restart ssh

    # Set Hostname
    hostnamectl set-hostname briantical-base-ubuntu

    # Set custom welcome message
    sh -c 'echo "Welcome to Briantical Base Ubuntu" > /etc/motd'

