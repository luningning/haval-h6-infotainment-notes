#!/bin/sh
# 请勿修改本脚本文件内容

path=$(dirname "$0")
LOG="$path/run.log"

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S'): $*" >> "$LOG"
}

# ADB over TCP
iptables -A INPUT -p tcp --dport 5555 -j ACCEPT
setprop service.adb.tcp.port 5555
stop adbd
start adbd

# Remount partitions rw
mount -o remount rw "$path"
mount -o remount rw /
mount -o remount rw /system
sleep 3

log "-------------------开始执行脚本------------------"

# 解除安装限制，删除外卖、酒店
if [ -d /system/priv-app/BdPrivacy ]; then
  rm -rf /system/priv-app/BdPrivacy
  sleep 2
  log "解除限制成功"
  reboot
  exit 0
else
  log "没有发现BdPrivacy"
fi

rm -rf /system/app/DuerOSAutohavalWaiMai
rm -rf /system/app/DuerOSAutoHotelhaval

# 解除收费提醒
log "-------------------开始执行解除收费提醒------------------"
if [ -f "$path/apk/DuerOSActivate.apk" ]; then
  cp -f /system/app/DuerOSActivate/DuerOSActivate.apk "$path/apk/DuerOSActivate_bak.apk" 2>/dev/null || true
  cp -f "$path/apk/DuerOSActivate.apk" /system/app/DuerOSActivate/DuerOSActivate.apk
  sleep 5
fi

# 安装软件
pm install -r "$path/apk/DuDuLauncher_1.015.apk"
pm install -r "$path/apk/酷我音乐6.0.0.apk"
sync
sleep 2

# 替换原车小程序为应用页
if mv "$path/apk/DuerOSIoVaiapps.bak" /system/app/DuerOSIoVaiapps/DuerOSIoVaiapps.apk 2>/dev/null; then
  log "小程序替换成功"
else
  log "小程序替换失败"
fi
sleep 2

# 替换原车桌面
if cp -f "$path/apk/Launcher3.bak" /system/priv-app/Launcher3/Launcher3.apk 2>/dev/null; then
  log "原车桌面替换成功"
else
  log "原车桌面替换失败"
fi
sleep 2

# 秒起嘟嘟桌面
log "-------------------开始执行秒起嘟嘟桌面操作------------------"
sh "$path/file/miaoqidudu.sh"

# 设置语音控制高德地图
mkdir -p /data/data/com.baidu.che.codriver/shared_prefs/
cp -f "$path/file/prefs_amap.xml" /data/data/com.baidu.che.codriver/shared_prefs/
log "-------------------设置语音控制高德地图结束------------------"

# 优化导航栏
settings put global policy_control immersive.full=apps,-com.yftech.launcher,-com.yftech.settings,-com.baidu.naviauto,-com.yftech.btphone,-com.yftech.music.player,-com.yftech.media.player,-com.yftech.radio,-com.yftech.vehiclecenter,-com.yftech.pkiservice,-com.baidu.car.radio,-com.baidu.iov.faceos,-com.baidu.iov.dueros.videoplayer,-com.baidu.iov.aiapps,-com.baidu.car.theme,-com.baidu.bodyguard,-com.baidu.iov.feedback,-com.baidu.xiaoduos.messageserver
log "导航栏优化成功"

sleep 10
reboot
