# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

if  !Vagrant.has_plugin?("vagrant-reload")
    system('vagrant plugin install vagrant-reload')
    raise("Missing Plugins installed. Run vagrant command again.");
end

if  !Vagrant.has_plugin?("vagrant-vbguest")
    system('vagrant plugin install vagrant-vbguest')
    raise("Missing Plugins installed. Run vagrant command again.");
end

Vagrant.configure(2) do |config|

  config.ssh.forward_agent = true
  config.vbguest.auto_update = true

  config.vm.define "asteriskdev" do |asteriskdev|
    asteriskdev.vm.box = "centos/8"
    asteriskdev.vm.network "private_network", ip: "10.100.100.11"
    asteriskdev.vm.network :forwarded_port, guest: 22, host: 2020, id: "ssh", auto_correct: true 
    asteriskdev.vm.hostname = "asterisk.dev.vm"

    # Check if this is the first run
    if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/asteriskdev/*").empty? || ARGV[1] == '--provision'
      print "Gerrit Username: "
      gerritusername = STDIN.gets.chomp
      print "Full Name: "
      fullname = STDIN.gets.chomp
      print "Email: "
      email = STDIN.gets.chomp
      cmd = "git config --global user.name \"#{fullname}\"; git config --global user.email \"#{email}\";
                touch ~/.ssh/config;
                echo -e \"Host asterisk\n Hostname gerrit.asterisk.org\n Port 29418\n User #{gerritusername}\n\" > ~/.ssh/config;
                echo -e #{gerritusername} > /tmp/gerritusername;"
      asteriskdev.vm.provision :shell, :inline => cmd, :privileged => false
    end

    asteriskdev.vm.provision :shell, path: "linux-shell/asterisk.sh"
    asteriskdev.vm.provision :shell, path: "linux-shell/vagrant-asterisk-dev.sh", privileged: false

    asteriskdev.vm.provider "virtualbox" do |vb|
       vb.name = "Asterisk Development and Test Environment"
         vb.memory = 1024
         vb.cpus = 2
    end

  end

end

