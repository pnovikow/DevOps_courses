# install packer,vagrant,virtualbox

# 2.1 create box with packer
#create and setting ubuntu1804.json file
#create and setting pressed.cfg
#creat dir scripts and create, setting 2 file(cleanup.sh,init.sh) with dir script
#setting .json file
$ packer build ubuntu1804.json

#2.2 run VM
$ packer build ubuntu-18.04.1.box.json
#create and setting vagrantfile with ubuntu1804.box
$ vagrant up
# connect in VM
$vagrant ssh

#2.3 add chef 
#install chef,ruby
$ gem install bundler
#Create directory for chef project
$ mkdir chef-solo-quick-start
$ cd chef-solo-quick-start
#Create 'Gemfile' for bundler
$ echo 'source "https://rubygems.org"' >> Gemfile
$ echo '' >> Gemfile
$ echo 'gem "knife-solo"' >> Gemfile
$ echo 'gem "knife-solo_data_bag"' >> Gemfile
$ echo 'gem "librarian-chef"' >> Gemfile
$ bundle install
$ knife solo init .
#Adding cookbooks to Cheffile
echo "cookbook 'chef-solo-search'" >> Cheffile
echo "cookbook 'sudo'" >> Cheffile
echo "cookbook 'users'" >> Cheffile
echo "cookbook 'nginx'" >> Cheffile
echo "cookbook 'java'" >> Cheffile
echo "cookbook 'Tomcat'" >> Cheffile
echo "cookbook 'mysql'" >> Cheffile
#librarian-chef install
#setting vagrant file

#2.4 setting port
open virtual box and set port

#2.5 create pattern VM with install mariadb
#add cookbook to cheffile
echo "cookbook 'mariadb'" >> Cheffile
