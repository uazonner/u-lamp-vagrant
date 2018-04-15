# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/trusty32"

    # Mount shared folder using NFS
    config.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "www-data", mount_options: ["dmode=775","fmode=775"]
       #id: "core",
       #:nfs => true,
       #:mount_options => ['nolock,vers=3,udp,noatime']

    # Do some network configuration
    config.vm.network "public_network", ip: "192.168.0.150"
    config.vm.define  "dev" do |dev|
    end

    # Assign a quarter of host memory and all available CPU's to VM
    # Depending on host OS this has to be done differently.
    config.vm.provider :virtualbox do |vb|
        host = RbConfig::CONFIG['host_os']

        if host =~ /darwin/
            cpus = `sysctl -n hw.ncpu`.to_i
            mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 2

        elsif host =~ /linux/
            cpus = `nproc`.to_i
            mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 2048 / 2

        # Windows...
        else
            cpus = 2
            mem = 2048
        end

        vb.customize ["modifyvm", :id, "--memory", mem]
        vb.customize ["modifyvm", :id, "--cpus", cpus]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

    config.vm.provision :shell, :path => "bootstrap.sh"

end