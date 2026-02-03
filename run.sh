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

#开始--------解除安装限制，删除外卖、酒店
if [ -d /system/priv-app/BdPrivacy ] ;then
rm /system/priv-app/BdPrivacy -rf
sleep 2
echo $(date +'%Y-%m-%d %H:%M:%S')":解除限制成功" >> $path/run.log
reboot
return 0
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有发现BdPrivacy" >> $path/run.log
fi
rm -r /system/app/DuerOSAutohavalWaiMai
rm -r /system/app/DuerOSAutoHotelhaval
#开始--------执行解除收费提醒
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------开始执行解除收费提醒解除------------------" >> $path/run.log
if test -f $path/apk/DuerOSActivate.apk ;then
  cp /system/app/DuerOSActivate/DuerOSActivate.apk $path/apk/DuerOSActivate_bak.apk -rf
  cp $path/apk/DuerOSActivate.apk /system/app/DuerOSActivate/DuerOSActivate.apk -rf
  sleep 5
fi
#开始--------安装软件嘟嘟
pm install -r $path/apk/DuDuLauncher_1.015.apk
pm install -r $path/apk/酷我音乐6.0.0.apk
sync
sleep 2
#开始--------替换原车小程序为应用页
mv $path/apk/DuerOSIoVaiapps.bak /system/app/DuerOSIoVaiapps/DuerOSIoVaiapps.apk
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":小程序替换成功" >> $path/run.log
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":小程序替换失败" >> $path/run.log
  fi
sleep 2
#开始--------替换原车桌面
sleep 2
cp -a $path/apk/Launcher3.bak /system/priv-app/Launcher3/Launcher3.apk
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":原车桌面替换成功" >> $path/run.log
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":原车桌面替换失败" >> $path/run.log
  fi
sleep 2
#开始--------执行秒起嘟嘟桌面操作
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------开始执行秒起嘟嘟桌面操作------------------" >> $path/run.log
sh $path/file/miaoqidudu.sh
#开始--------设置语音控制高德地图
mkdir -p /data/data/com.baidu.che.codriver/shared_prefs/
cp -a  $path/file/prefs_amap.xml /data/data/com.baidu.che.codriver/shared_prefs/
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------设置语音控制高德地图结束------------------" >> $path/run.log
#开始--------优化导航栏
settings put global policy_control immersive.full=apps,-com.yftech.launcher,-com.yftech.settings,-com.baidu.naviauto,-com.yftech.btphone,-com.yftech.music.player,-com.yftech.media.player,-com.yftech.radio,-com.yftech.vehiclecenter,-com.yftech.pkiservice,-com.baidu.car.radio,-com.baidu.iov.faceos,-com.baidu.iov.dueros.videoplayer,-com.baidu.iov.aiapps,-com.baidu.car.theme,-com.baidu.bodyguard,-com.baidu.iov.feedback,-com.baidu.xiaoduos.messageserver
echo $(date +'%Y-%m-%d %H:%M:%S')":导航栏优化成功" >> $path/run.log

sleep 10
reboot