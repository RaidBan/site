#!/bin/bash

perc=0.5 #процент от максимальной памяти хоста при котором будет выслано уведовление
memmax=$(free | grep Mem | awk '{print $2}') #максимальная память хоста
memtotal=$(free | grep Mem |awk '{print $3}') #текущая память
halfmem=$(bc<<<"scale=2;$memmax*$perc" | sed 's/\..*//') #рассчёт % от макс. памяти и удаление плавающей точки
if [[ $halfmem -le $memtotal ]] #проверка 
then 
	memsend=$(free -h | grep Mem | awk '{print $3}')
	maxsend=$(free -h | grep Mem | awk '{print $2}')
	curl -X POST http://127.0.0.1:3000/api/?hostname=$HOSTNAME\&memtotal=$maxsend/$memsend
fi

