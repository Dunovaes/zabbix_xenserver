#!/bin/bash

# Autor: Eduardo Novaes
# Descrição: Script para descobrir a memoria do XenServer
# Versão: 1.0
# Data: 14/09/2020
uuid=$1
xenpass="/etc/zabbix/zabbix_agentd.d/xenserver/xen_passwd"

array=($(xe -pwf $xenpass pif-list uuid=$uuid  params=carrier,speed,duplex | cut -d: -f2 | sed s/^" "//g | sed 's/Mbit\/s//'))

data="{\"XENNETWORKSTATE\":\"${array[0]}\",\"XENNETWORKSPEED\":\"${array[1]}\",\"XENNETWORKDUPLEX\":\"${array[2]}\"}"

inicio="{\"data\":\\n"
final="\\n}"
echo -e $inicio$data$final
