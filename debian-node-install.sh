#!/bin/bash
declare LISKNET

USERLIST="kj jb"
TRUSTED_IPV4="89.239.217.12"

declare -A SSHKEYS

SSHKEYS[kj]="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAxPXpcIzDwNb2PaDfGaq8n8j9C6Uu4GhWiev0V5cYCoye8tmJoX2jeVB/jY9Sa+yVR2S4/jXhq+AxWk3oWoUzTnP5zE67/VZSxx7DjuP7yNNvZ+tCjPr2J8UVNYGaWL0uazg4gY7bn4d3W19m3vOvZ8/QdQsTIoFbZgQQ5rlrtHutbszDe9E5ZaZCoDxXm3aoBlz/ftJ+SCwhZ7taYDBDRIvvb8mmJSQgztjHMAB6UGuQYtrXBCHCw3gCVB5wLaXd2THeDok3EkTe9WDbrPU3ZI5RmhmxrNYN4DcNvHfWW8qqOrb4cxX7xKXW2/TzhYBW3voxnuwtn8S0EKU5sDGrHp7pjLFJLy5zX+Nqy6zvWwzMIWhPlHtZbowcDMTANspBNdVQF5ipz0qKNcJDLbmiUs+HMLBVOdhPWycVaFvBOVoHLlLWgWvpaTBZqWLnBnmtUloXbtwWgM5l63C1oKRkZBThe0dRcj6+r11pzc/6ZY0F5ldHBuA/HDL/cdQa8/LMb0075d9b4nhZzMnOZQt+kM4JTSLTb/wDyxJmA1+msigu47LEG5mcIdBvmDTcztoyhcVF8KfOlljL/ShYMxvx75BZyycAp3YthinYWia129+//GL7shjfjdzoqTu/G5VjhUrc1SmLBrfBXBdVsgh4QBBCugzq96SvLalBNuK96V8= kj@tickii.com"
SSHKEYS[jb]="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAhDyHV7vzvS7/MfqsoanrEkZc84mxnHisz187ri4xFQ6iXuW2tZscf8gWizh6Mw4DZ8caZbEoZBKhtXH3Yhj2ZjF1T0jHjFzsgE3603YWVkIS5Z/pAih2wm0e+7X5HYK1x60nuMyPXtGv1aJM6aAvhkNFfA1Hn1mbqZF3YDyBEy0VsR8IweIAMF6ESA3g4Cvut0lVnCxrDgbyTG3RMHKoyF8ozK/lQfbDlKVi5bsMaq6/pi6iPzCqE9LQoUeaeXH/LPweZUjgKIh9GgBw0rsRTezIUHvwGh+97hoaZZaSaYuRw551Afx54juH0exj5FWwoGOg/9fNIkxcLzrcxeDWCbY1Y8Qr5+tb6dpfXgDBuNUvka0uYRF70CktCVl3ZVCG06s1rwaXbdxDdZKt1KrfzZvhZ2LGDKdLmxxqGgDWTSN13xoJab35bAXLWdi7qeTnPAoNlxbyajVWX2YEQxqpxHMdr0cdfGzY2UmVmPI91cZ0NDnC2CjQkOd3ZXE4O+PpdWX/rA/uj+fsA1faaPjXF29okbBzwBjnrKEGEiOg56is+BEFNVF2BgapPoZwIbrtW49TbDnhTzq5UTNWEK1WpqS5xKhro3nM8QVVCqOSmPajLMl3MJQ8f7esdYfctc6qxmz/kLEmrJBCvhmSseqgvjgJ7HCYwU5waSeKv1AGmXk= jb@tickii.com"
SSHKEYS[lisk]="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAhDyHV7vzvS7/MfqsoanrEkZc84mxnHisz187ri4xFQ6iXuW2tZscf8gWizh6Mw4DZ8caZbEoZBKhtXH3Yhj2ZjF1T0jHjFzsgE3603YWVkIS5Z/pAih2wm0e+7X5HYK1x60nuMyPXtGv1aJM6aAvhkNFfA1Hn1mbqZF3YDyBEy0VsR8IweIAMF6ESA3g4Cvut0lVnCxrDgbyTG3RMHKoyF8ozK/lQfbDlKVi5bsMaq6/pi6iPzCqE9LQoUeaeXH/LPweZUjgKIh9GgBw0rsRTezIUHvwGh+97hoaZZaSaYuRw551Afx54juH0exj5FWwoGOg/9fNIkxcLzrcxeDWCbY1Y8Qr5+tb6dpfXgDBuNUvka0uYRF70CktCVl3ZVCG06s1rwaXbdxDdZKt1KrfzZvhZ2LGDKdLmxxqGgDWTSN13xoJab35bAXLWdi7qeTnPAoNlxbyajVWX2YEQxqpxHMdr0cdfGzY2UmVmPI91cZ0NDnC2CjQkOd3ZXE4O+PpdWX/rA/uj+fsA1faaPjXF29okbBzwBjnrKEGEiOg56is+BEFNVF2BgapPoZwIbrtW49TbDnhTzq5UTNWEK1WpqS5xKhro3nM8QVVCqOSmPajLMl3MJQ8f7esdYfctc6qxmz/kLEmrJBCvhmSseqgvjgJ7HCYwU5waSeKv1AGmXk= lisk@tickii.com"

function ruby {
	
	read -p "What version Ruby should be installed (2.3.1) ? " prompt
	RUBYVERSION = $prompt
	
	if [[ $RUBYVERSION == "" || $RUBYVERSION == " " ]]
	then
		RUBYVERSION = "2.3.1"
	fi
	
	apt-get update
	apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
	
	cd
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(rbenv init -)"' >> ~/.bashrc
	exec $SHELL
	
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
	echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
	exec $SHELL
	
	rbenv install $RUBYVERSION
	rbenv global $RUBYVERSION
	ruby -v
}

function basic_packages {
	
	echo "Installing lisk prerequisites and default Debain set..."
	apt-get update
	apt-get -y install ufw curl wget tar unzip zip sudo linux-headers-$(uname -r) mc joe dos2unix g++ gcc make tcpdump ngrep elinks git openssl ntp wget curl
	echo "Packages installed"
	
	echo "Setting locale"
	locale-gen en_US.UTF-8
	update-locale LANG=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8
	export LANGUAGE=en_US.UTF-8

}

function create_users {

	echo "Adding users and permissions..."
	
	addgroup wheel
	bash -c 'echo "%wheel ALL = (ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'
	bash -c 'echo "%sudo ALL = (ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'
	
	for user in $USERLIST;
	do
	        echo -n "$user..."
	        useradd -G wheel -s /bin/bash -m $user
	        mkdir /home/$user/.ssh
	        echo ${SSHKEYS[$user]} > /home/$user/.ssh/authorized_keys
	        chown $user:$user /home/$user/.ssh
	        chown $user:$user /home/$user/.ssh/authorized_keys
	        chmod 700 /home/$user/.ssh
	        chmod 600 /home/$user/.ssh/authorized_keys
	done
	
	echo "Done with users..."
}
	
function lisk {

	read -p "Install Lisk test or mainnet? <test/main> " prompt
	if [[ $prompt == "main" || $prompt == "Main" || $prompt == "MAIN" || $prompt == "m" ]]
	then
	    echo "Installing mainnet"
	    LISKNET="main"
	else
	    echo "Installing testnet"
	    LISKNET="test"
	fi
	
	echo "Using nodejs v0.12"
	curl -sL https://deb.nodesource.com/setup_0.12 | sudo -E bash -

	apt-get install -y nodejs
	
	echo -n "Adding wheel group and permissions for lisk..."
	
	useradd -G wheel -s /bin/bash -m lisk
	mkdir /home/lisk
	mkdir /home/lisk/.ssh
	echo ${SSHKEYS[lisk]} > /home/lisk/.ssh/authorized_keys
	chown -R lisk:lisk /home/lisk
	chmod 700 /home/lisk/.ssh
	chmod 600 /home/lisk/.ssh/authorized_keys
	
	cd /home/lisk
	sudo -u lisk wget https://downloads.lisk.io/scripts/installLisk.sh
	sudo -u lisk bash installLisk.sh install
			
	cd /home/lisk/lisk-$LISKNET
	
	export PATH="/home/lisk/lisk-$LISKNET/bin:/home/lisk/lisk-$LISKNET/pgsql/bin:$PATH"
	export LD_LIBRARY_PATH="/home/lisk/lisk-$LISKNET/pgsql/lib:$LD_LIBRARY_PATH"
			
	echo "export PATH=\"/home/lisk/lisk-$LISKNET/bin:/home/lisk/lisk-$LISKNET/pgsql/bin:\$PATH\"" >> /home/lisk/.bashrc
	echo "export LD_LIBRARY_PATH=\"/home/lisk/lisk-$LISKNET/pgsql/lib:\$LD_LIBRARY_PATH\"" >> /home/lisk/.bashrc
			
	echo "Updating node binaries..."
			
	sudo -u lisk bash lisk.sh stop
	sudo -u lisk wget https://downloads.lisk.io/lisk-node/lisk-node-Linux-x86_64.tar.gz
	sudo -u lisk tar xfv lisk-node-Linux-x86_64.tar.gz
	sudo -u lisk bash lisk.sh start
	
	read -p "Do you want to create a Dapp now? <y/N> " prompt
	
	if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
	then
	
		echo "Installing Dapp..."
		echo "Installing lisk Dapp tools"
		npm install -g lisk-cli
		npm install -g crypto-browserify
		npm install -g browserify-bignum
		
		sudo -u lisk bash lisk.sh stop
		sudo -u lisk ssh-keygen -t rsa -b 4096 -C "lisk@tickii.com"
		cat /home/lisk/.ssh/id_rsa.pub
		read -n1 -r -p "Copy above key and insert into allowed ssh keys in tickii repo..." key
		echo "Repo is located here: git@github.com:tickii/some-name-repo.git"
		sudo -u lisk lisk-cli dapps -a
		sudo -u lisk bash lisk.sh start
		echo "Resetting database..."
		killall node
		dropdb -U lisk lisk_$LISKNET
		createdb -U lisk lisk_$LISKNET
		sudo -u lisk bash lisk.sh restart
	fi
		
	if [[ $LISKNET == "main" ]]
	then
		sudo ufw allow 8000/tcp
	else
		sudo ufw allow 7000/tcp
	fi
	
	sudo ufw enable
		
	echo "Done with Lisk..."
}

function security {

	echo -n "Updating SSHd configuration..."
	sed -i.old -e "s/^Port 22$/Port 222/" -e "s/^PermitRootLogin without-password/PermitRootLogin no/" -e "s/^PermitRootLogin yes/PermitRootLogin no/"  -e "s/^#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
	echo "Done"
	
	echo "Restarting SSHd..."
	/etc/init.d/ssh restart
	
	echo "Setting up firewall.."
	
	ufw default deny incoming
	ufw default allow outgoing
	ufw allow 222/tcp
	
	echo "Setting up trusted IPs in firewall.."
	for ipv4address in $TRUSTED_IPV4;
	do
		echo "Allowing from $ipv4address..."
		sudo ufw allow from $ipv4address
	       
	done
	
	echo "Applying firewall..."
	ufw enable

}

read -p "Do you want to basic packages? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	basic_packages
fi

read -p "Do you want to create users? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	create_users
fi

read -p "Do you want to run security measures? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	security
fi

read -p "Do you want to install Lisk? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	lisk
fi

read -p "Do you want to run security measures? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	security
fi

read -p "Do you want to install ruby? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	ruby
fi

echo "All done, have fun :)"
