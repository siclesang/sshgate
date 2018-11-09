
sshgate

ssh shell  堡垒机

1.限制用户可登录机器列表
2.录屏以备审计

使用方法
 mkdir $pwddir"/logs" && chmod 777 $pwddir"/logs"
 echo "/bin/bash $pwddir/run.sh" >> [/etc/profile |/etc/profile.d/xxx.sh | /etc/bashrc | .. ]






 |
 |---run.sh  # echo "/bin/bash $pwddir/run.sh" >> [/etc/profile | /etc/profile.d/xxx.sh | /etc/bashrc | .. ]
 |---main.sh # user selects hosts to login 
 |---acl
 |   |
 |   |--[named usergroup] #content(first column mast be ip or hostname):[ip|hostname] [host describtions]
 |   |--[named usergroup] #one group one acl file named usergroup
 |
 |---logs # note: users write privilege ,777 better 
 |   |
 |   |--yearmonthday  #log directory named yearmonthday
 |      |
 |      |---user_hourminutesecond #command record file
 |      |---user_hourminutesecond_timing #command record timing data file
