#file: docs/vagrant/vagrant-cheat-sheet.sh
# source: http://docs.vagrantup.com/v2/getting-started/index.html
# START == installation
# 1. download vagrant for your platform
# 2. download Oracle VirtualBox for your platform
# initialize
vagrant init hashicorp/precise32
# start the virual machine
vagrant up

# reload the vagrant configuration 
vagrant reload 

# access the vagrant host 
vagrant ssh

# check the ssh configuration 
vagrant ssh-config 


# STOP == installation
vagrant up
# ssh to it
vagrant ssh

config.vm.provider "vmware_fusion" do |v|
# file:~/Vagrantfile

VAGRANTFILE_API_VERSION = "2"
# the version of the vagrant file matters

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

   # the name of the box
   config.vm.box = "hashicorp/precise32"

   # the sync dir on the host and the vm , note default permissions
   config.vm.synced_folder 'C:/var', '/vagrant' ,
      owner: "root", group: "root" , :mount_option => ['dmode=775', 'fmode=775']

   # port forwarding for the maria db
   config.vm.network :forwarded_port, guest: 13306, host: 13306

   config.vm.network :forwarded_port, guest: 3000, host: 3000

   # port forwarding for Apache
   config.vm.network :forwarded_port, guest: 8080, host: 8080

   # symlinking ...
   config.vm.provider "virtualbox" do |v|
   v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
   end
end

#==========================================================
# -- VersionHistory --
#==========================================================
#
# export version=1.0.2
#
# 1.0.2 -- 2015-05-09 21:20:37 -- ysg -- /var to C:/var in win shared dir
# 1.0.1 -- 2014-08-21 17:21:55 -- ysg -- mounting , port forwarding, comments
# 1.0.0 -- ysg -- init
