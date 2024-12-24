echo "**** Initializing Snapshot creation ****"
############ Ensure zero interaction ############
export DEBIAN_FRONTEND=noninteractive

############ Update and Install packages ############
sudo apt-get update

while sudo lsof /var/lib/dpkg/lock-frontend; do sleep 10; done
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

############ Install Docker ############
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu focal stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt-get update

while sudo lsof /var/lib/dpkg/lock-frontend; do sleep 10; done
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

sudo groupadd docker || true
sudo gpasswd -a $USER docker

############ Setup SSH Certificates ############
sudo mv /root/certificate.pub /etc/ssh/certificate.pub
sudo chmod 644 /etc/ssh/certificate.pub
sudo chown root:root /etc/ssh/certificate.pub

sudo mv /root/portfolio-cert.pub /etc/ssh/id_ed25519-cert.pub
sudo chmod 644 /etc/ssh/id_ed25519-cert.pub
sudo chown root:root /etc/ssh/id_ed25519-cert.pub

sudo tee -a /etc/ssh/sshd_config <<EOF
PubkeyAuthentication yes
TrustedUserCAKeys /etc/ssh/certificate.pub
HostCertificate /etc/ssh/id_ed25519-cert.pub
EOF

sudo systemctl try-restart ssh
############ Set hostname ############
sudo hostnamectl set-hostname portfolio
############ Custom message ############
sudo sh -c 'echo "Welcome to Portfolio" > /etc/motd'
