#!/bin/bash

perc=0.5
memmax=$(free | grep -n 2 | awk '{print $2}')
memtotal=$(free | grep -n 2 |awk '{print $3}')
halfmem=$(bc<<<"scale=2;$memmax*$perc" | sed 's/\..*//')

echo $halfmem, $memtotal
if [[ $halfmem -ge $memtotal ]]
	then curl -X POST http://127.0.0.1:3000/api/?hostname=$HOSTNAME\&memtotal=$memtotal
fi


