############ Ensure zero interaction ############
export DEBIAN_FRONTEND=noninteractive

############ Cleanup temporary files ############
while sudo lsof /var/lib/dpkg/lock-frontend; do sleep 10; done
sudo apt-get autoremove -y && sudo apt-get clean -y
