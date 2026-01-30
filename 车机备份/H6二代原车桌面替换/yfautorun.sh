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
echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------开始------------------" >> $path/run.log
##启动原生安卓设置，用于卸载嘟嘟更新
am start com.android.settings/.Settings
sleep 20
SN=`getprop persist.vehicle.sn`
echo $(date +'%Y-%m-%d %H:%M:%S')"你的SN码:"$SN >> $path/run.log

JYQX() {
echo $(date +'%Y-%m-%d %H:%M:%S')":调用JYQX, $1!" >> $path/run.log
sleep 1
SN=`getprop persist.vehicle.sn`
sleep 1
M="H6"$SN"CJ"
sleep 1
Key=$(echo -n $M | md5sum | cut -d ' ' -f1)
sleep 1
UKey=$(cat $path/Key.txt)
if [ "$Key" == "$UKey" ] ; then
echo $(date +'%Y-%m-%d %H:%M:%S')":校验成功，即将开始扩容。" >> $path/run.log
echo $Key > /system/biaoji.txt
sleep 3
Kuo "3"
sleep 3
Runpj "4"
else
echo $(date +'%Y-%m-%d %H:%M:%S')":UKey不正确，请获取正确的KEY" >> $path/run.log
exit
fi
}

Kuo() {
if [ -f /system/Kuo.sh ] ;then
echo $(date +'%Y-%m-%d %H:%M:%S')":已经扩容" >> $path/run.log
   if [ -f $path/Kuo.sh ] ;then
   #重置扩容文件
     cp -a $path/yfbtconfiginit.sh /system/bin/yfbtconfiginit.sh
     sleep 2
     cp -a $path/Kuo.sh /system/
     if [ $? -eq 0 ]; then
     echo $(date +'%Y-%m-%d %H:%M:%S')":选择了重置扩容文件，扩容文件重置成功" >> $path/run.log
       else
     echo $(date +'%Y-%m-%d %H:%M:%S')":选择了重置扩容文件，扩容文件重置失败" >> $path/run.log
     fi
     else
   echo $(date +'%Y-%m-%d %H:%M:%S')":已扩容，没有选择重置扩容" >> $path/run.log
fi

else
 if [ -f $path/Kuo.sh ] ;then
echo $(date +'%Y-%m-%d %H:%M:%S')":扩容开始" >> $path/run.log
echo $(date +'%Y-%m-%d %H:%M:%S')":调用Kuo, $1!" >> $path/run.log
echo $(date +'%Y-%m-%d %H:%M:%S')":开始删除原车百度地图数据！" >> $path/run.log
rm -rf /map/BaiduMapAuto/*
if [ $? -eq 0 ]; then
    echo $(date +'%Y-%m-%d %H:%M:%S')":百度地图数据清理完成。" >> $path/run.log
    sleep 2
else
    echo $(date +'%Y-%m-%d %H:%M:%S')":百度地图数据清理失败。" >> $path/run.log
fi


mkdir -p /map/Kuo
if [ $? -eq 0 ]; then
    echo $(date +'%Y-%m-%d %H:%M:%S')":链接目录创建成功。" >> $path/run.log
    mount -o remount rw /map/Kuo
    sleep 3
else
    echo $(date +'%Y-%m-%d %H:%M:%S')":链接目录创建失败。" >> $path/run.log
    sleep 3
    exit 1
fi


echo $(date +'%Y-%m-%d %H:%M:%S')":开始移动数据目录" >> $path/run.log
cp -a /data/app /map/Kuo
if [ $? -eq 0 ]; then
  echo $(date +'%Y-%m-%d %H:%M:%S')":APP移动成功" >> $path/run.log
  sleep 3
else
  echo $(date +'%Y-%m-%d %H:%M:%S')":APP移动失败" >> $path/run.log
  rm /map/Kuo -rf
  sleep 3
  exit 1
fi

sync
cp -a /data/media /map/Kuo
if [ $? -eq 0 ]; then
  echo $(date +'%Y-%m-%d %H:%M:%S')":MEDIA移动成功" >> $path/run.log
else
  echo $(date +'%Y-%m-%d %H:%M:%S')":MEDIA移动失败" >> $path/run.log
  rm /map/Kuo -rf
  exit 1
fi
sleep 3
sync
cp -a /data/data /map/Kuo
if [ $? -eq 0 ]; then
  echo $(date +'%Y-%m-%d %H:%M:%S')":DATA移动成功" >> $path/run.log
else
  echo $(date +'%Y-%m-%d %H:%M:%S')":DATA移动失败" >> $path/run.log
  rm /map/Kuo -rf
  exit 1
fi
sync

sleep 3
cp -a $path/yfbtconfiginit.sh /system/bin/yfbtconfiginit.sh
if [ $? -eq 0 ]; then
  echo $(date +'%Y-%m-%d %H:%M:%S')":yfbtconfiginit.sh设置成功" >> $path/run.log
else
  echo $(date +'%Y-%m-%d %H:%M:%S')":yfbtconfiginit.sh设置失败" >> $path/run.log
  exit 1
fi
sleep 3

cp -a $path/Kuo.sh /system/
if [ $? -eq 0 ]; then
  echo $(date +'%Y-%m-%d %H:%M:%S')":Kuo.sh设置成功" >> $path/run.log
  sleep 1
   if [ -d /system/priv-app/BdPrivacy ] ;then
   sleep 1
   echo $(date +'%Y-%m-%d %H:%M:%S')":还未破解，即将开始破解" >> $path/run.log
   else
   echo $(date +'%Y-%m-%d %H:%M:%S')":已破解过，即将重启让扩容生效" >> $path/run.log
   sleep 1
   reboot
   fi
else
  echo $(date +'%Y-%m-%d %H:%M:%S')":Kuo.sh设置失败" >> $path/run.log
  exit 1
fi

sleep 3
else 
echo $(date +'%Y-%m-%d %H:%M:%S')":没有选择扩容" >> $path/run.log
fi


fi
}

Runpj() {
echo "调用runPJ, $1!" >> $path/run.log
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
APK_FILES=$(ls "$path"/APK/*.apk)
if [ -z "$APK_FILES" ]; then
echo $(date +'%Y-%m-%d %H:%M:%S')":没有搜索到apk安装包" >> $path/run.log
fi
# loop：install apk
for apk in $APK_FILES; do
pm install -r "$apk"
if [ $? -eq 0 ]; then
  echo $(date +'%Y-%m-%d %H:%M:%S')$apk"安装成功!" >> $path/run.log
else
  echo $(date +'%Y-%m-%d %H:%M:%S')$apk"安装失败!" >> $path/run.log
fi
sync
done
sleep 2
echo $(date +'%Y-%m-%d %H:%M:%S')":APK安装完成" >> $path/run.log
sleep 3
#优化导航栏
settings put global policy_control immersive.full=apps,-com.yftech.launcher,-com.yftech.settings,-com.baidu.naviauto,-com.yftech.btphone,-com.yftech.music.player,-com.yftech.media.player,-com.yftech.radio,-com.yftech.vehiclecenter,-com.yftech.pkiservice,-com.baidu.car.radio,-com.baidu.iov.faceos,-com.baidu.iov.dueros.videoplayer,-com.baidu.iov.aiapps,-com.baidu.car.theme,-com.baidu.bodyguard,-com.baidu.iov.feedback,-com.baidu.xiaoduos.messageserver
echo $(date +'%Y-%m-%d %H:%M:%S')":导航栏优化成功" >> $path/run.log


#秒起嘟嘟设置Pro
sleep 2
if [ -d /data/app/com.dudu.autoui-* ] ;then
rm /system/priv-app/Launcher1 -rf
sleep 2
mv /data/app/com.dudu.autoui-* /system/priv-app/Launcher1
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟Pro目录移动成功" >> $path/run.log
  rm /data/app/com.dudu.autoui-* -rf
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟Pro目录移动失败" >> $path/run.log
  exit 1
  fi
sleep 3
sync
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有安装嘟嘟Pro桌面或已移动成功" >> $path/run.log
fi

#秒起嘟嘟mini
sleep 2
if [ -d /data/app/com.wow.carlauncher.mini-* ] ;then
rm /system/priv-app/Launcher1 -rf
sleep 2
mv /data/app/com.wow.carlauncher.mini-* /system/priv-app/Launcher1
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟mini目录移动成功" >> $path/run.log
  rm /data/app/com.wow.carlauncher.mini-* -rf
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟mini目录移动失败" >> $path/run.log
  fi
sleep 3
sync
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有安装嘟嘟mini桌面或已移动成功" >> $path/run.log
fi

#秒起嘟嘟普通版
sleep 2
if [ -d /data/app/com.wow.carlauncher-* ] ;then
rm /system/priv-app/Launcher1 -rf
sleep 2
mv /data/app/com.wow.carlauncher-* /system/priv-app/Launcher1
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟普通版目录移动成功" >> $path/run.log
  rm /data/app/com.wow.carlauncher-* -rf
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟普通版目录移动失败" >> $path/run.log
  fi
sleep 3
sync
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有安装嘟嘟普通版桌面或已移动成功" >> $path/run.log
fi

#秒起氢桌面
sleep 2
if [ -d /data/app/com.mcar.auto-* ] ;then
rm /system/priv-app/Launcher1 -rf
sleep 2
mv /data/app/com.mcar.auto-* /system/priv-app/Launcher1
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":氢桌面目录移动成功" >> $path/run.log
  rm /data/app/com.mcar.auto-* -rf
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":氢桌面目录移动失败" >> $path/run.log
  fi
sleep 3
sync
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有安装氢桌面或已移动成功" >> $path/run.log
fi


#嘟嘟夜晚主题系统化
sleep 2
if [ -d /data/app/com.dudu.autoui.theme.base.yw* ] ;then
rm /system/priv-app/Launcher9 -rf
sleep 2
mv /data/app/com.dudu.autoui.theme.base.yw* /system/priv-app/Launcher9
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟夜晚主题设置成功" >> $path/run.log
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟夜晚主题设置失败" >> $path/run.log
  fi
sleep 3
sync
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有安装夜晚主题或已移动成功" >> $path/run.log
fi

#嘟嘟白天主题系统化
sleep 2
if [ -d /data/app/com.dudu.autoui.theme.base.bt* ] ;then
rm /system/priv-app/Launcher10 -rf
sleep 2
mv /data/app/com.dudu.autoui.theme.base.bt* /system/priv-app/Launcher10
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟白天主题设置成功" >> $path/run.log
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟白天主题设置失败" >> $path/run.log
  fi
sleep 3
sync
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有安装白天主题或已移动成功" >> $path/run.log
fi
##替换原车桌面
sleep 2
cp -a $path/APK/Launcher3.bak /system/priv-app/Launcher3/Launcher3.apk
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":原车桌面替换成功" >> $path/run.log
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":原车桌面替换失败" >> $path/run.log
  fi
sleep 2

##替换原车小程序为应用页
mv $path/APK/DuerOSIoVaiapps.bak /system/app/DuerOSIoVaiapps/DuerOSIoVaiapps.apk
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":小程序替换成功" >> $path/run.log
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":小程序替换失败" >> $path/run.log
  fi
sleep 2

 if [ -f $path/APK/abd.bak ] ;then
sleep 2
SN=`getprop persist.vehicle.sn`
sleep 1
M="H6"$SN"CJ"
sleep 1
Key=$(echo -n $M | md5sum | cut -d ' ' -f1)
sleep 1
UKey=$(cat $path/APK/Key.txt)
if [ "$Key" == "$UKey" ] ; then
mv $path/APK/abd.bak /system/app/DuerOSActivate/DuerOSActivate.apk
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":成功" >> $path/run.log
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":失败" >> $path/run.log
  fi
sleep 3

cp -a $path/APK/bd.sh /system/bd.sh
sync
else
echo $(date +'%Y-%m-%d %H:%M:%S')":未授权" >> $path/run.log
fi
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有发现文件。" >> $path/run.log
fi

if [ -f /system/bd.sh ] ;then
cp -a $path/APK/prefs_amap.xml /data/data/com.baidu.che.codriver/shared_prefs/
else
echo $(date +'%Y-%m-%d %H:%M:%S')":还未得到授权，无法配置。" >> $path/run.log
fi



echo $(date +'%Y-%m-%d %H:%M:%S')":-------------------结束------------------" >> $path/run.log
rm $path/Kuo.sh -rf
rm $path/APK -rf
rm -rf $0
reboot

}

if [ -f /system/biaoji.txt ] || [ -f /system/parker.txt ]; then
Kuo "3"
sleep 3
Runpj "4"
else
JYQX "1"
fi
