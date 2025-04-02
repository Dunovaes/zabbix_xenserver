#!/bin/bash

# Autor: Eduardo Novaes
# Descrição: Script para descobrir os Storage Repositories do XenServer
# Versão: 1.0
# Data: 14/09/2020
xenpass="/etc/zabbix/zabbix_agentd.d/xenserver/xen_passwd"
command="xe -pwf $xenpass sr-list type=lvmohba params=uuid | cut -d: -f2 | sort | uniq | sed s/\\s//g | sed /^$/d"
command2="xe -pwf $xenpass sr-list uuid=\$i type=lvmohba params=name-label | cut -d: -f2"
lines=$(eval $command | wc -l)
loop=1


inicio="{\"data\":[\\n"

for i in `eval $command`; do
    XENSRNAME=$(eval $command2)
    loop=$(($loop+1))

    if [ $loop -gt $lines ]; then
        data=${data}"{\"{#XENSR}\":\"$i\",\"{#XENSRNAME}\":\"$XENSRNAME\"}"
    else
        data=${data}"{\"{#XENSR}\":\"$i\",\"{#XENSRNAME}\":\"$XENSRNAME\"},\\n"
    fi


done

final="\\n]}"
echo -e $inicio$data$final

