#!bin/bash
cd ~
yum update
yum install wget
yum install git
echo  "installation of git has been completed"
local_path="/root/chef_repository/chef/chef-repo"
git clone https://github.com/duddumounika/chef_repository.git
echo "cloning from github repository"
[ -f chefdk-2.5.3-1.el7.x86_64.rpm ] && echo "chef is already installed" || \
(
wget https://packages.chef.io/files/stable/chefdk/2.5.3/el/7/chefdk-2.5.3-1.el7.x86_64.rpm
rpm -Uvh https://packages.chef.io/files/stable/chefdk/2.4.17/el/7/chefdk-2.4.17-1.el7.x86_64.rpm
)
echo "chef got installed.Its version is"
chef -v 
curl -L https://www.opscode.com/chef/install.sh | bash
echo "chef-solo got installed.Its version is"
chef-solo -v
[ -f master ] && echo "extracting not needed" || \
(
wget http://github.com/opscode/chef-repo/tarball/master
tar zxvf master
)
mv chef-boneyard-chef-repo-605eeda/* $local_path/
mkdir $local_path/.chef
echo " cookbook_path [ '/root/chef_repository/chef/chef-repo/cookbooks' ]" > $local_path/.chef/knife.rb
cd $local_path
echo "Running of cookbooks"
chef-solo -c solo.rb -j web.json
cd root/
#\rm -rf chefdk_2.4.17-1_amd64.deb chef-boneyard-chef-repo-605eeda master
