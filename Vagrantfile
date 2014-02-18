
CHEF_CLIENT_INSTALL = <<-EOF
#!/bin/sh
apt-get update
dpkg -l curl|grep -q ^ii || {
  apt-get install -y curl
}

test -d /opt/chef || {
  echo "Installing chef-client via omnibus"
  curl -L -s https://www.opscode.com/chef/install.sh | bash
}
EOF

Vagrant::configure("2") do |config|
  config.vm.box = "opscode-ubuntu-12.04-i386"
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04-i386_provisionerless.box"
  
  # Configure Selenium Grid
  config.vm.define :'selenium-solo' do |selenium_solo|
    selenium_solo.vm.network :private_network, ip: "10.212.0.11"
        selenium_solo.vm.hostname = "selenium.local.vm"
        selenium_solo.vm.provider :virtualbox do |vb|
          vb.customize [
                        "modifyvm", :id,
                        "--name", "selenium-solo",
                        "--memory", "512",
                        "--cpus", 1,
                       ]
        end
      selenium_solo.vm.provision :shell, :inline => CHEF_CLIENT_INSTALL
  end
end