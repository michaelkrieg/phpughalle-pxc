# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

INSTANCES=3

DOMAIN="pxc.cluster.local"

MEMORY=256

SUBNET="172.23.77"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#####
##### the cluster nodes:
#####
  INSTANCES.times do |i|
    config.vm.define "pxc#{i + 1}".to_sym do |vmconfig|
      vmconfig.vm.box     = "redtag-debian-71-x64-vbox4210"
      vmconfig.vm.box_url = "http://files.red-tag.de/vagrant/debian-71-x64-vbox4210.box"

      vmconfig.vm.network :private_network, ip: "#{SUBNET}.%d" % (10 + i + 1)
      vmconfig.vm.host_name = "pxc#{i + 1}.#{DOMAIN}"

      vmconfig.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", MEMORY]
      end


      # Install r10k using the shell provisioner and download the Puppet modules
      config.vm.provision :shell, :path => "bootstrap.sh"
      
      vmconfig.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "site.pp"
        puppet.options = [
          "--verbose",
          "--modulepath=/vagrant/modules:/vagrant/local_modules"
        ]
      end
    end
  end

end

