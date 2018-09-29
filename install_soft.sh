#!/bin/bash


set -e 
echo "*** this script install software for  ubuntu/debian***"

if [ $(id -u) -ne 0 ]; then
	echo $0 need supervisor privilege
	exit 1
fi



echo "
1. install all 

2. git
3. vim
4. openssh-server
5. visual studio code
5. google chrome
6. vscode 
7. wine 
8. play on linux
"


function install_all(){
	ubt_git
	ubt_vim
	ubt_openssh_server
	ubt_chrome
	ubt_vscode	
	ubt_wine
	ubt_play_on_linux
}



ubt_git(){	 
	apt install -y git
}
ubt_vim(){	
	apt install -y vim
}
ubt_openssh_server(){	
	apt install -y openssh-server
}


#ubuntu 常用第三方软件源

#chrome
ubt_chrome(){
	wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  |  apt-key add -
	apt-get update
	apt-get install google-chrome-stable
}



#vscode 
ubt_vscode(){
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	apt-get update
	apt-get install -y apt-transport-https    code
}


#Shadowsock-Qt5
ubt_ssqt5(){
	add-apt-repository ppa:hzwhuang/ss-qt5
	apt-get update
	apt-get install -y shadowsocks-qt5
}

#WineHQ-Stable
ubt_wine(){
	dpkg --add-architecture i386
	wget -nc https://dl.winehq.org/wine-builds/Release.key
	apt-key add Release.key
	apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
	apt-get update
	apt-get install -y --install-recommends winehq-stable
}

#PlayOnLinux
ubt_play_on_linux(){
	wget -q "http://deb.playonlinux.com/public.gpg" -O- |  apt-key add -
	wget http://deb.playonlinux.com/playonlinux_trusty.list -O /etc/apt/sources.list.d/playonlinux.list
	apt-get update
	apt-get install -y playonlinux
}


######## main #########
declare -i choice

read -p "select your choice:  " choice

if [ $choice -gt 6 -o $choice -lt 1 ]
then
	echo "select invalide"
	exit
fi

apt update
case  $choice in
	1)
		install_all;;
	2)
		ubt_git;;
	3)
		ubt_vim;;
	4)
		ubt_openssh_server;;
	5)
		ubt_chrome;;
	6)
		ubt_vscode;;
	7)
		ubt_wine;;
	8)
		ubt_play_on_linux;;
esac

