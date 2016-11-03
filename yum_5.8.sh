#!/bin/bash 
#删除原有的yum软件包
rpm -aq|grep yum|xargs rpm -e --nodeps 

#下载软件包
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/yum-3.2.22-40.el5.centos.noarch.rpm 
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/yum-metadata-parser-1.1.2-4.el5.x86_64.rpm 
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/yum-fastestmirror-1.1.16-21.el5.centos.noarch.rpm 
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/python-iniparse-0.2.3-6.el5.noarch.rpm 
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/centos-release-5-11.el5.centos.x86_64.rpm 
wget http://mirrors.163.com/centos/5/os/x86_64/CentOS/centos-release-notes-5.11-0.x86_64.rpm

#下载配置文件，并进行替换 
wget http://mirrors.163.com/.help/CentOS5-Base-163.repo
sed -i "s/\$releasever/5/g" /rootCentOS5-Base-163.repo
 
#备份原配置文件，复制新的配置文件
for f in /etc/yum.repos.d/*.repo; do mv ${f} ${f}.bak ; done 
cp /root/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo 

#安装相关软件
rpm -ivh --force *.rpm

#清理，生成缓存
yum clean all 
yum makecache