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
sleep 3
path=`dirname $0`
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------开始执行脚本------------------" >> $path/run.log


#开始--------执行解除收费提醒
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------开始执行解除收费提醒解除------------------" >> $path/run.log
if test -f $path/apk/DuerOSActivate.apk ;then
  cp /system/app/DuerOSActivate/DuerOSActivate.apk $path/apk/DuerOSActivate_bak.apk -rf
  cp $path/apk/DuerOSActivate.apk /system/app/DuerOSActivate/DuerOSActivate.apk -rf
  sleep 5
fi
#开始--------执行秒起嘟嘟桌面操作
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------开始执行秒起嘟嘟桌面操作------------------" >> $path/run.log
sh $path/file/miaoqidudu.sh
#开始--------设置语音控制高德地图
mkdir -p /data/data/com.baidu.che.codriver/shared_prefs/
cp -a  $path/file/prefs_amap.xml /data/data/com.baidu.che.codriver/shared_prefs/
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------设置语音控制高德地图结束------------------" >> $path/run.log

sleep 10
reboot