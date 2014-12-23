Vagrant.configure('2') do |config|
  config.vm.define 'pcaps' do |c|
    c.vm.box = 'kaorimatz/fedora-21-x86_64'
    c.vm.provider :virtualbox do |v|
      v.name = 'pcaps'
    end
    c.vm.provision :shell do |s|
      s.inline = <<-EOS
      grubby --extlinux --update-kernel=/boot/vmlinuz-$(uname -r) --args=ipv6.disable=1
      echo '** Reboot is required to disable IPv6 **'
      yum -y update
      yum -y install kernel-modules-extra
      yum -y install tcpdump
      EOS
    end
  end
end
