#!/bin/bash

USERLIST="kj jb"

declare -A SSHKEYS
SSHKEYS[kj]="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAxPXpcIzDwNb2PaDfGaq8n8j9C6Uu4GhWiev0V5cYCoye8tmJoX2jeVB/jY9Sa+yVR2S4/jXhq+AxWk3oWoUzTnP5zE67/VZSxx7DjuP7yNNvZ+tCjPr2J8UVNYGaWL0uazg4gY7bn4d3W19m3vOvZ8/QdQsTIoFbZgQQ5rlrtHutbszDe9E5ZaZCoDxXm3aoBlz/ftJ+SCwhZ7taYDBDRIvvb8mmJSQgztjHMAB6UGuQYtrXBCHCw3gCVB5wLaXd2THeDok3EkTe9WDbrPU3ZI5RmhmxrNYN4DcNvHfWW8qqOrb4cxX7xKXW2/TzhYBW3voxnuwtn8S0EKU5sDGrHp7pjLFJLy5zX+Nqy6zvWwzMIWhPlHtZbowcDMTANspBNdVQF5ipz0qKNcJDLbmiUs+HMLBVOdhPWycVaFvBOVoHLlLWgWvpaTBZqWLnBnmtUloXbtwWgM5l63C1oKRkZBThe0dRcj6+r11pzc/6ZY0F5ldHBuA/HDL/cdQa8/LMb0075d9b4nhZzMnOZQt+kM4JTSLTb/wDyxJmA1+msigu47LEG5mcIdBvmDTcztoyhcVF8KfOlljL/ShYMxvx75BZyycAp3YthinYWia129+//GL7shjfjdzoqTu/G5VjhUrc1SmLBrfBXBdVsgh4QBBCugzq96SvLalBNuK96V8= kj@tickii.com"
SSHKEYS[jb]="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAhDyHV7vzvS7/MfqsoanrEkZc84mxnHisz187ri4xFQ6iXuW2tZscf8gWizh6Mw4DZ8caZbEoZBKhtXH3Yhj2ZjF1T0jHjFzsgE3603YWVkIS5Z/pAih2wm0e+7X5HYK1x60nuMyPXtGv1aJM6aAvhkNFfA1Hn1mbqZF3YDyBEy0VsR8IweIAMF6ESA3g4Cvut0lVnCxrDgbyTG3RMHKoyF8ozK/lQfbDlKVi5bsMaq6/pi6iPzCqE9LQoUeaeXH/LPweZUjgKIh9GgBw0rsRTezIUHvwGh+97hoaZZaSaYuRw551Afx54juH0exj5FWwoGOg/9fNIkxcLzrcxeDWCbY1Y8Qr5+tb6dpfXgDBuNUvka0uYRF70CktCVl3ZVCG06s1rwaXbdxDdZKt1KrfzZvhZ2LGDKdLmxxqGgDWTSN13xoJab35bAXLWdi7qeTnPAoNlxbyajVWX2YEQxqpxHMdr0cdfGzY2UmVmPI91cZ0NDnC2CjQkOd3ZXE4O+PpdWX/rA/uj+fsA1faaPjXF29okbBzwBjnrKEGEiOg56is+BEFNVF2BgapPoZwIbrtW49TbDnhTzq5UTNWEK1WpqS5xKhro3nM8QVVCqOSmPajLMl3MJQ8f7esdYfctc6qxmz/kLEmrJBCvhmSseqgvjgJ7HCYwU5waSeKv1AGmXk= jb@tickii.com"
echo "Installing default Debain set..."

apt-get update
apt-get -y install sudo linux-headers-$(uname -r) mc joe dos2unix g++ gcc make tcpdump ngrep elinks git curl openssl ntp

echo "Packages installed"

echo -n "Adding users..."

for user in $USERLIST;
do
        echo -n "$user..."
        useradd -G sudo -s /bin/bash -m $user
        mkdir /home/$user/.ssh
        echo ${SSHKEYS[$user]} > /home/$user/.ssh/authorized_keys
        chown $user:$user /home/$user/.ssh
        chown $user:$user /home/$user/.ssh/authorized_keys
        chmod 700 /home/$user/.ssh
        chmod 600 /home/$user/.ssh/authorized_keys
done

echo "Done"

echo -n "Updating SSHd configuration..."
sed -i.old -e "s/^Port 22$/Port 222/" -e "s/^PermitRootLogin without-password/PermitRootLogin no/" -e "s/^PermitRootLogin yes/PermitRootLogin no/"  -e "s/^#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
echo "Done"

echo "Restarting SSHd..."
/etc/init.d/ssh restart

echo "All done, have fun..."
