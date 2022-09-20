# install vagrant on windows
wget https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_windows_amd64.msi
wget https://releases.hashicorp.com/vagrant-vmware-utility/1.0.21/vagrant-vmware-utility_1.0.21_x86_64.msi
vagrant plugin install vagrant-vmware-desktop


vagrant init
# default download box to ~/.vagrant.d/boxes, can copy to each other
# remember to set HTTP_PROXY="http://127.0.0.1:58895"  HTTPS_PROXY="http://127.0.0.1:58895" ENVIRONMENT


vagrant destroy -f


vagrant up


vagrant ssh
# default login user/password is vagrant/vagrant， use su root to switch to root user


# reload
vagrant reload
# run below command to stop
vagrant halt
# run below command to destroy