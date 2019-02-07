#!/bin/bash
#
# by philarmino


# Requirements

apt-get install pv -y -q

# SSH 

echo -e "\nSet PermitRootLogin to no in sshd_config ...\n" | pv -qL 23
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
echo -e "\nRestart service sshd ...\n" | pv -qL 23
systemctl restart sshd.service


# Setup Login Notifier (email)
echo -e "\nCreate Shell script for login notification ...\n" | pv -qL 23
echo -e "#!/bin/bash
echo "Login auf $(hostname) am $(date +%Y-%m-%d) um $(date +%H:%M)"
echo "Benutzer: $USER"
echo
finger" > /opt/shell-login.sh
chmod 755 /opt/shell-login.sh
echo -e "\nAdd entry in /etc/profile for login notification ...\n" | pv -qL 23

ETC_PROFILE_RC=$(grep "shell-login" /etc/profile)
if [ -z "$ETC_PROFILE_RC" ] ; then 
  read -p "Enter Email address for login notification" EMAIL
  echo "/opt/shell-login.sh | mailx -s "SSH Login auf $(hosname)" $EMAIL" >> /etc/profile
else
  echo -e "\nSkipped, already present ...\n" | pv -qL 23
fi  
