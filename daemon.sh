#!/bin/bash

perc=0.5 #процент от максимальной памяти хоста при котором будет выслано уведовление
time=10 #задержка проверки в секундах
let "again = 10 * 60" #задержка перед повторной отправкой в минутах
memmax=$(free | grep Mem | awk '{print $2}') #максимальная память хоста
memtotal=$(free | grep Mem |awk '{print $3}') #текущая память
halfmem=$(bc<<<"scale=2;$memmax*$perc" | sed 's/\..*//') #рассчёт % от макс. памяти и удаление плавающей точки

while true
do
if [[ $halfmem -le $memtotal ]] #проверка 
then 
	memsend=$(free -h | grep Mem | awk '{print $3}')
	maxsend=$(free -h | grep Mem | awk '{print $2}')
	curl -X POST http://example.com/api/?hostname=$HOSTNAME\&memtotal=$maxsend/$memsend
	sleep $again
	#break
else	
	sleep $time
fi
done

