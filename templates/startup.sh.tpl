sudo yum -y install nfs-utils
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo yum install -y epel-release
sudo yum install -y python-pip
sudo pip install docker-compose
sudo yum upgrade -y python*
sudo yum -y install git
git clone https://github.com/aws/efs-utils
sudo yum -y install make
sudo yum -y install rpm-build
cd efs-utils; sudo make rpm; sudo yum -y install ./build/amazon-efs-utils*rpm


sudo mkdir /opt/wordpress
sudo mount -t efs ${efs_mount_id}:/ /opt/wordpress

cat << EOF > /tmp/docker-compose.yaml
${docker_compose}
EOF

docker-compose --file=/tmp/docker-compose.yaml
