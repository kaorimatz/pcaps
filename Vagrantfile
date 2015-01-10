Vagrant.configure('2') do |config|
  config.vm.define 'pcaps' do |c|
    c.vm.box = 'kaorimatz/fedora-rawhide-x86_64'
    c.vm.provider :virtualbox do |v|
      v.name = 'pcaps'
    end
    c.vm.provision :shell do |s|
      s.inline = <<-EOS
      if ! $(grep -qF ipv6.disable=1 /proc/cmdline); then
        grubby --extlinux --update-kernel=/boot/vmlinuz-$(uname -r) --args=ipv6.disable=1
        echo '** Reboot is required to disable IPv6 **'
      fi
      dnf -y update
      dnf -y install kernel-modules-extra
      dnf -y install openvswitch
      dnf -y install tcpdump
      EOS
    end
  end
end
