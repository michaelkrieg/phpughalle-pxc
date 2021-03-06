# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

INSTANCES=3

DOMAIN="pxc.cluster.local"

MEMORY=384

SUBNET="172.23.77"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

if Vagrant.has_plugin?('vagrant-vbguest')
  class GuestAdditionsFixer < VagrantVbguest::Installers::Debian
    def install(opts=nil, &block)
      super
      communicate.sudo('([ -e /opt/VBoxGuestAdditions-4.3.10 ] && sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions) || true')
    end
  end
end


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
        puppet.hiera_config_path = "hiera.yaml"
        puppet.options = [
          "--verbose",
          "--modulepath=/vagrant/modules:/vagrant/local_modules"
        ]
      end
    end
  end

end

