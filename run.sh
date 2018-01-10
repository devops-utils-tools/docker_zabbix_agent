#!/bin/bash
#zabbix__agent_run By:liuwei Mail:al6008@163com

export Zabbix_Server=${Zabbix_Server:-"172.16.110.88"}
export Zabbix_Agent_Name=${Zabbix_Agent_Name:-"Gitlab"}

grep -q ${Zabbix_Server} /usr/local/etc/zabbix_agentd.conf
if [ $? -ne 0 ];then
	sed -i "s@ServerActive=127.0.0.1@ServerActive=${Zabbix_Server}@g" /usr/local/etc/zabbix_agentd.conf
	sed -i "s@Server=127.0.0.1@Server=${Zabbix_Server}@g" /usr/local/etc/zabbix_agentd.conf
	sed -i "s@Hostname=Zabbix server@Hostname=${Zabbix_Agent_Name}@g" /usr/local/etc/zabbix_agentd.conf
	sed -i "s@# Include=/usr/local/etc/zabbix_agentd.conf.d/@Include=/usr/local/etc/zabbix_agentd.conf.d/@g" /usr/local/etc/zabbix_agentd.conf
	useradd -r -s /sbin/nologin zabbix &>/dev/null
fi

#停止服务
ps uax |grep zabbix |grep -v grep |awk '{print $2}'|xargs kill &>/dev/null

#启动服务
zabbix_agentd -c  /usr/local/etc/zabbix_agentd.conf
tail -f /tmp/zabbix_agentd.log && exit 0
exit 1
