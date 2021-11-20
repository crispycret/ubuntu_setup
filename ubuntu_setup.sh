
#!/bin/sh
echo "\n\nThis script will help you save time in setting up a new ubuntu system.\n"

echo "\n\n[SETUP] Updating and Upgrading ...\n\n"
apt-get update -y
apt-get upgrade -y
echo "\n\n[SETUP] Complete.\n\n"

echo "\n\n[SETUP] Installing basic tools ...\n\n"
# nstall basic linux tools
apt-get install build-essential net-tools curl ufw git -y
echo "\n\n[SETUP] Complete.\n\n"

echo "\n\[SETUP] Setting up python environment ...\n\n"
# Setup python environment
apt-get install python-is-python3 pyton3-pip -y
apt-get install virtualenv virtualenvwrapper -y
echo "\n\n[SETUP] Complete.\n\n"

echo "\n\n[SETUP] Enable firewall (ufw)\n\n"
# Enable firewall
ufw enable
ufw status
echo "\n\n[SETUP] Complete.\n\n"

echo "\n\n[SETUP] Installing and setting up SSH ...\n\n"
# Install SSH
apt-get install openssh-server -y
ssh-keygen

# Allow only local network to access ssh
echo "sshd: 192.168.1." > /etc/hosts.allow
echo "sshd: ALL" > /etc/hosts.deny

# Allow X11 forwarding through SSH
# Append options to /etc/ssh/ssh_config
echo """
    X11Forwarding yes
    X11DisplayOffset 10
    PrintMotd no
    PrintLastLog yes
    TCPKeepAlive yes
""" >> /etc/ssh/ssh_config


# Restart sshd
service sshd restart
systemctl restart sshd
echo "\n\n[SETUP] Complete.\n\n"


# Setup shared folders



echo "\n\n[SETUP] Installing rust\n\n"
mkdir ~/opt
cd ~/opt

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
echo "\n\n[SETUP] Complete.\n\n"


echo "\n\n[SETUP] Installing Solana from source (may not work)\n\n"
# Install solana version 1.8.5 as of 11/20/21
wget https://github.com/solana-labs/solana/archive/refs/tags/v1.8.5.tar.gz
tar -xf v1.8.5.tar.gz
rm v1.8.5.tar.gz

# Install dependancy that gave me an error
apt-get install libudev-dev librocksdb-dev libclang-dev -y

cd solana-1.8.5
./scripts/cargo-install-all.sh .

echo "\n\n[SETUP] Complete.\n\n"
cd ~
