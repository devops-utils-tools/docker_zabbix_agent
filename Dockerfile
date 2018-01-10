from centos:7.2.1511
maintainer By:liuwei "al6008@163.com"
run yum install -y net-tools make gcc-c++ autoconf openssl openssl-devel openldap-clients curl iproute &&\
	localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 &&\
	export LC_ALL=zh_CN.utf8 &&\
   	yum clean all

env LC_ALL zh_CN.utf8

#zabbix
add zabbix-3.0.14.tar.gz /
copy zabbix-3.0.14.tar.gz /zabbix-3.0.14.tar.gz
run cd /zabbix-3.0.14 &&\
	./configure --enable-agent &&\
	make -j &&make install &&\ 
	rm -rf /zabbix*
add run.sh /run.sh
cmd ["/bin/bash","/run.sh"]
