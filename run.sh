#!/bin/sh
#东北虎哈弗H6二代车机全车解锁资料提取/安装脚本！
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
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------开始------------------" >> $path/run.log
# 以下执行秒起嘟嘟桌面操作
#sh /mnt/udisk/miaoqidudu.sh
#sh /mnt/udisk/duduzhuti.sh
#reboot
mkdir -p /data/data/com.baidu.che.codriver/shared_prefs/
cp -a  $path/prefs_amap.xml /data/data/com.baidu.che.codriver/shared_prefs/
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------结束------------------" >> $path/run.log
sleep 30
reboot