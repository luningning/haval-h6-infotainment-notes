#!/bin/sh
am start com.android.settings/.Settings
DU_APP_PATH_BT="/data/app/com.dudu.autoui-1"
DU_APP_PATH_YW="/data/app/com.dudu.autoui-1"
sleep 2
if [ -d "$DU_APP_PATH_BT" ] ;then
rm /system/priv-app/Launcher8 -rf
rm /system/priv-app/Launcher9 -rf
sleep 2
mkdir /system/priv-app/Launcher8
mkdir /system/priv-app/Launcher9
chmod 755 /system/priv-app/Launcher8
chmod 755 /system/priv-app/Launcher9
mv "$DU_APP_PATH_BT"/* /system/priv-app/Launcher8
mv "$DU_APP_PATH_YW"/* /system/priv-app/Launcher9
chown root:root /system/priv-app/Launcher8
chown root:root /system/priv-app/Launcher9
  if [ $? -eq 0 ]; then
  sleep 2
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟主题目录移动成功" >> $path/run.log
  rm /data/app/"$DU_APP_PATH_BT" -rf
  rm /data/app/"$DU_APP_PATH_YW" -rf
  else
  echo $(date +'%Y-%m-%d %H:%M:%S')":嘟嘟主题目录移动失败" >> $path/run.log
  exit 1
  fi
sleep 3
sync
else
echo $(date +'%Y-%m-%d %H:%M:%S')":没有安装嘟嘟主题或已移动成功" >> $path/run.log
fi
