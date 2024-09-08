Vagrant.configure("2") do |config|
  # CI Server Configuration
  config.vm.define "ci_server" do |ci|
    ci.vm.box = "ubuntu/jammy64"
    
    # Network configuration for CI Server
    ci.vm.network "private_network", ip: "192.168.33.10"
    ci.vm.network "forwarded_port", guest: 8080, host: 8081  # Forwarding port 8080
    ci.vm.network "forwarded_port", guest: 9000, host: 9002  # Forwarding port 9000
    ci.vm.network "forwarded_port", guest: 22, host: 2222    # SSH access

    # VirtualBox provider configuration
    ci.vm.provider "virtualbox" do |vb|
      vb.memory = "5096"
      vb.cpus = "4"
    end

    # Provisioning for CI Server
    ci.vm.provision "shell", inline: <<-SHELL
#!/bin/bash
# For Ubuntu 22.04
# Intsalling Java
sudo apt update -y
sudo apt install openjdk-17-jre -y
sudo apt install openjdk-17-jdk -y
java --version

# Installing Jenkins
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y

# Installing Docker 
#!/bin/bash
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
sudo chmod 777 /var/run/docker.sock

# If you don't want to install Jenkins, you can create a container of Jenkins
# docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-container jenkins/jenkins:lts

# Run Docker Container of Sonarqube
#!/bin/bash
docker run -d  --name sonar -p 9000:9000 sonarqube:lts-community


# Installing AWS CLI
#!/bin/bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# Installing Trivy
#!/bin/bash
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update
sudo apt install trivy -y
    SHELL
  end

  # CD Server Configuration
  config.vm.define "cd_server" do |cd|
    cd.vm.box = "ubuntu/jammy64"
    
    # Network configuration for CD Server
    cd.vm.network "private_network", ip: "192.168.33.11"
    cd.vm.network "forwarded_port", guest: 9090, host: 9091   # Forwarding port 9090
    cd.vm.network "forwarded_port", guest: 80, host: 8080     # Forwarding HTTP port

    # VirtualBox provider configuration
    cd.vm.provider "virtualbox" do |vb|
      vb.memory = "5096"
      vb.cpus = "4"
    end

    # Provisioning for CD Server
    cd.vm.provision "shell", inline: <<-SHELL
#!/bin/bash
# Install Docker
sudo apt update -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu

# Installing AWS CLI
#!/bin/bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# Installing Kubectl
#!/bin/bash
sudo apt update
sudo apt install curl -y
sudo curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client


# Installing eksctl
#! /bin/bash
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version



# Intalling Helm
#! /bin/bash
sudo snap install helm --classic
    SHELL
  end
end
