Vagrant.configure("2") do |config|
  # CI Server Configuration
  config.vm.define "ciserver" do |ci|
    ci.vm.box = "ubuntu/jammy64"
    ci.vm.hostname = "ciserver"
    
    # Network configuration for CI Server
    ci.vm.network "private_network", ip: "192.168.33.10"
    ci.vm.network "forwarded_port", guest: 8080, host: 8088  # Forwarding port 8080
    ci.vm.network "forwarded_port", guest: 9000, host: 9002  # Forwarding port 9000
    ci.vm.network "forwarded_port", guest: 22, host: 2222 
    ci.vm.network "forwarded_port", guest: 3000, host: 3001 
    ci.vm.network "forwarded_port", guest: 8000, host: 7999  
     # SSH access

    # VirtualBox provider configuration
    ci.vm.provider "virtualbox" do |vb|
      vb.memory = "5120"
      vb.cpus = 4
    end
  end

  # CD Server Configuration
  config.vm.define "cdserver" do |cd|
    cd.vm.box = "ubuntu/jammy64"
    cd.vm.hostname = "cdserver"
    
    # Network configuration for CD Server
    cd.vm.network "private_network", ip: "192.168.33.11"
    cd.vm.network "forwarded_port", guest: 9090, host: 9091   # Forwarding port 9090
    cd.vm.network "forwarded_port", guest: 80, host: 8082     # Forwarding HTTP port
    cd.vm.network "forwarded_port", guest: 8080, host: 8023
    cd.vm.network "forwarded_port", guest: 443, host: 420
    # VirtualBox provider configuration
    cd.vm.provider "virtualbox" do |vb|
      vb.memory = "5120"
      vb.cpus = 4
    end
  end
     # Jenkins Agent Configuration
  config.vm.define "Agent" do |agent|
    agent.vm.box = "ubuntu/jammy64"
    agent.vm.hostname = "JenkinsAgent"
    
    # Network configuration for Jenkins Agent
    agent.vm.network "private_network", ip: "192.168.33.12"
	agent.vm.network "forwarded_port", guest: 22, host: 2231

    # VirtualBox provider configuration
    agent.vm.provider "virtualbox" do |vb|
      vb.memory = "5120"
      vb.cpus = 4
    end
  end
end
