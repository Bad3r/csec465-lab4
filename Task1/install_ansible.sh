#! /bin/bash
: <<'END'
A simple script that updates the system and installs ansible on Ubuntu 18.4
END

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install python python-pip python-apt software-properties-common -y

sudo apt-add-repository ppa:ansible/ansible

sudo apt update

sudo apt install ansible


