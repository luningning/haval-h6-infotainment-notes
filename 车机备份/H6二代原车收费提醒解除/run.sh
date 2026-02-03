#!/bin/sh
#东北虎哈弗H6二代车机全车解锁资料提取/安装脚本！
path=/mnt/udisk
newos=DuerOSActivate.apk
oldos=DuerOSActivate_bak.apk
newfile=$path/$newos
sys=/system/app/DuerOSActivate

if test -f ${newfile} ;then
	echo "发现破解os，开始破解原车接"
    mount -o remount rw /system
    cp $sys/$newos $path/$oldos -rf
    cp $path/$newos $sys/$newos -rf
    sleep 5
    reboot
else
	echo "提取已破解车机的os"
    cp $sys/$newos $path/$newos -rf
fi
