#!/bin/bash
#
# by philarmino


# Requirements

apt-get install pv 

# SSH 

echo -e "\nSet PermitRootLogin to no in sshd_config ...\n" | pv -qL 23
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config



# 
