#!/bin/bash


# Install script to provision server

curUser=$(whoami)
if [[ $curUser=="vagrant" ]]
then
    # The next two lines set up vagrant to always log you in to the shared
    # directory so that your work is easily visible/accessible from the host.
    cd /vagrant
    echo "cd /vagrant" | sudo tee -a ~vagrant/.profile
else
    # If you are actually deploying this on a server somewhere, then here is
    # where you should set up the server directories
    echo "Not implemented"
fi

# OS
sudo apt-get update

# Tools
sudo apt-get -y install build-essential # g++, make, etc.
sudo apt-get -y install git curl

# MySQL
mysqlTempPass="foo"
sudo DEBIAN_FRONTEND=noninteractive apt-get -q -y install mysql-server
mysqladmin -u root password $mysqlTempPass
sudo mysql -u root --password=$mysqlTempPass < ./scripts/mysql/schema.sql

#Node
sudo apt-get -y install python-software-properties
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get -y update
sudo apt-get -y install nodejs nodejs-dev npm
#NODEJS_MAJOR_VERSION=0.10
#sudo -u vagrant git clone git://github.com/creationix/nvm.git ~vagrant/nvm
#echo '. ~/nvm/nvm.sh' | tee -a ~vagrant/.profile
#source ~vagrant/nvm/nvm.sh
#nvm install v0.10
#
#echo "nvm use $NODEJS_MAJOR_VERSION" | tee -a ~vagrant/.profile
#source ~vagrant/nvm/nvm.sh
#nvm use $NODEJS_MAJOR_VERSION
