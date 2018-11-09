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
# |---logs # note: users write privilege ,777 better 
# |   |
# |   |--yearmonthday  #log directory named yearmonthday
# |      |
# |      |---user_hourminutesecond #command record file
# |      |---user_hourminutesecond_timing #command record timing data file



[ `id -u  $USER` -lt 1000 ] && exit
pwddir=$(cd $(dirname $0) && pwd)

logsdir=$pwddir"/logs"
[ ! -d $logsdir ] && mkdir $logsdir


time_start=`date +%Y%m%d%H%M%S`
#yearmonthday(20181109)
day=${time_start:0:8}
#hourmintesecond(172511)
hms=${time_start:8:6}

oplogdir=$logsdir"/"$day


[ ! -d $oplogdir ] && mkdir $oplogdir && chmod 777 $oplogdir

# timing data file
lptimefile=$oplogdir"/"$USER"_"$hms"_timing"

# command record file
lpopfile=$oplogdir"/"$USER"_"$hms

# start record 
script --timing=$lptimefile -f  $lpopfile -c "sh $pwddir'/'main.sh" -q


pkill -t -kill  ${SSH_TTY#'/dev/'}
