#!/bin/bash

https://github.com/LazuliKao/luci-theme-fluent

$ https://github.com/jameslau-tech/fanchmwrt
1) kernel patch: target/linux/generic/hack-6.12/950-fwx-nf-conn-struct-user-hook.patch
2) new package：package/fcm
3）new feed
src-git fanchmwrt https://github.com/fanchmwrt/fanchmwrt-packages.git

https://github.com/he-yu-qing/2512immortalwrt-mt798x-rebase/tree/25.12
https://github.com/zjuahhy/immortalwrt-mt798x-rebase/
https://github.com/VIKINGYFY/CloseWRT-CI
https://github.com/Yuzhii0718
https://github.com/x-wrt

#节点订阅
https://github.com/beck-8/subs-check
https://github.com/shuaidaoya/FreeNodes
#https://github.com/bia-pain-bache/BPB-Worker-Panel
https://github.com/getumbrel/umbrel

#OpenClaw
https://github.com/fabricio3g/microbot-claw
https://github.com/lzylipu/openclaw-skill-openwrt-redial
https://github.com/duomi998/luci-app-openclaw-js

# 固件版本名称自定义
#sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='OpenWrt By gino $(date +"%Y%m%d")'/g" package/base-files/files/etc/openwrt_release

# 删除原默认主题
#rm -rf package/lean/luci-theme-bootstrap

# fam app
CONFIG_PACKAGE_fwxd=y
CONFIG_PACKAGE_libfwx_common=y
CONFIG_PACKAGE_kmod-fwx=y
CONFIG_PACKAGE_luci-app-fwx-appfilter=y
CONFIG_PACKAGE_luci-app-fwx-dashboard=y
CONFIG_PACKAGE_luci-app-fwx-dashboard-setting=y
CONFIG_PACKAGE_luci-app-fwx-feature=y
CONFIG_PACKAGE_luci-app-fwx-macfilter=y
#CONFIG_PACKAGE_luci-app-fwx-network=y
CONFIG_PACKAGE_luci-app-fwx-record=y
CONFIG_PACKAGE_luci-app-fwx-resources=y
CONFIG_PACKAGE_luci-app-fwx-session-stat=y
CONFIG_PACKAGE_luci-app-fwx-system=y
CONFIG_PACKAGE_luci-app-fwx-user=y
CONFIG_PACKAGE_luci-app-fwx-user-record=y
CONFIG_PACKAGE_luci-i18n-fwx-appfilter-zh-cn=y
CONFIG_PACKAGE_luci-i18n-fwx-dashboard-setting-zh-cn=y
CONFIG_PACKAGE_luci-i18n-fwx-dashboard-zh-cn=y
CONFIG_PACKAGE_luci-i18n-fwx-feature-zh-cn=y
CONFIG_PACKAGE_luci-i18n-fwx-macfilter-zh-cn=y
#CONFIG_PACKAGE_luci-i18n-fwx-network-zh-cn=y
CONFIG_PACKAGE_luci-i18n-fwx-record-zh-cn=y
CONFIG_PACKAGE_luci-i18n-fwx-session-stat-zh-cn=y
CONFIG_PACKAGE_luci-i18n-fwx-system-zh-cn=y
CONFIG_PACKAGE_luci-i18n-fwx-user-record-zh-cn=y
CONFIG_PACKAGE_luci-i18n-fwx-user-zh-cn=y

