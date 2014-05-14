VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.hostname = "local.lc"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :private_network, ip: "192.168.10.10"

  config.vm.synced_folder "public", "/var/www"

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # remove: stdin: is not a tty 
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path    = "puppet/manifests"
    puppet.module_path       = "puppet/modules"
    puppet.manifest_file     = "provision.pp"
    #puppet.options = "--verbose --debug"
  end

end
