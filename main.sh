#!/bin/bash
#name: sshgate
#author: siclesang@163.com
#date: 2018/11/09
#description:
# |
# |---run.sh  # echo "/bin/bash $pwddir/run.sh" >> [/etc/profile | /etc/profile.d/xxx.sh | /etc/bashrc | .. ]
# |---main.sh # user selects hosts to login 
# |---acl
# |   |
# |   |--[named usergroup] #content(first column mast be ip or hostname):[ip|hostname] [host describtions]
# |   |--[named usergroup] #one group one acl file named usergroup
# |
# |---logs  # note: users write privilege ,777 better
# |   |
# |   |--yearmonthday  #log directory named yearmonthday
# |   	 |
# |      |---user_hourminutesecond #command record file
# |      |---user_hourminutesecond_timing #command record timing data file


trap "exit" SIGINT SIGHUP SIGABRT SIGTERM

function readUserInput(){
	#$1 : input prompt
	#$2 : assign value to vars
	read -p "$1" $2
	
}


function loginUi(){
	#./acl/[groupname] file
	# show  ip or hostname to user selecting 
	if [ -r $uifile ]
	then
		cat -b  $uifile
	fi
}



function userAction(){

	sed -n $userSelect' p' $uifile
	if [ $? -eq 0 ]
	then
		hostip=$(sed -n $userSelect' p' $uifile|awk '{print $1}'|tr -d " ")
		readUserInput "input login username:" luser
		ssh  $luser'@'$hostip
	fi
}

function replay(){

	continue
}


function acladmin(){

	continue
}


userSelect=''
groupname=`id -ng $USER`
[ `id -u  $USER` -le 900 ] && exit
pwddir=$(cd $(dirname $0) && pwd)
acldir=$pwddir"/acl"
logsdir=$pwddir"/logs"
[ ! -d $acldir ] && mkdir $acldir
[ ! -d $logsdir ] && mkdir $logsdir 


uifile=$acldir"/"$groupname


while true 
do 
	loginUi 
	readUserInput "Pls input the number:" userSelect
	userAction 
done

