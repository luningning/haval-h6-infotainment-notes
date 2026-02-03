#!/bin/sh
am start com.android.settings/.Settings
#秒起嘟嘟设置Pro
sleep 2
if [ -d /data/app/com.dudu.autoui-1 ] ;then
rm /system/priv-app/Launcher4 -rf
sleep 2
mkdir /system/priv-app/Launcher4
chmod 755 /system/priv-app/Launcher4
mv /data/app/com.dudu.autoui-1/* /system/priv-app/Launcher4
chown root:root /system/priv-app/Launcher4
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟Pro目录移动成功" >> $path/run.log
  rm /data/app/com.dudu.autoui-1 -rf
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟Pro目录移动失败" >> $path/run.log
  exit 1
  fi
sleep 3
sync
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有安装嘟嘟Pro桌面或已移动成功" >> $path/run.log
fi
