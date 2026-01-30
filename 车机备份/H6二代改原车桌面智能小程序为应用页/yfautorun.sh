#!/bin/sh

#请勿修改本脚本文件内容
iptables -A INPUT -p tcp --dport  5555 -j ACCEPT
setprop service.adb.tcp.port 5555
stop adbd
start adbd
path=`dirname $0`
mount -o remount rw $path
mount -o remount rw /
mount -o remount rw /system
sleep 10
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------开始------------------" >> $path/run.log
if [ -f /system/parker.txt ] ; then
mv $path/APK/DuerOSIoVaiapps.bak /system/app/DuerOSIoVaiapps/DuerOSIoVaiapps.apk
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":替换成功" >> $path/run.log
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":替换失败" >> $path/run.log
  fi
  
#pm disable-user com.dudu.autoui
 # if [ $? -eq 0 ]; then
 # sleep 2
 # echo $(date +'%Y-%m-%d %H:%M:%S')":禁用嘟嘟成功" >> $path/run.log
 # else
 # echo $(date +'%Y-%m-%d %H:%M:%S')":禁用嘟嘟失败" >> $path/run.log
 # fi
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------结束，即将重启让设置生效------------------" >> $path/run.log
rm $path/APK -rf
rm -rf $0
reboot
else
exit 1
fi
