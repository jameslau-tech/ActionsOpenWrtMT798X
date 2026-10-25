#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 1. NAS feeds
#echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
#echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' >> feeds.conf.default

# 2. iStore feeds
#echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default

mkdir -p package/custom

# 科学插件
# Passwall
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/custom/passwall-packages
rm -rf feeds/luci/applications/luci-app-passwall
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall.git package/custom/passwall
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/custom/passwall2

# 加入gecoosac/
rm -rf package/openwrt-gecoosac
git clone https://github.com/openwrt-fork/openwrt-gecoosac package/openwrt-gecoosac


# OpenClash update to new version
rm -rf feeds/luci/applications/luci-app-openclash
#git clone --depth=1 -b dev https://github.com/vernesong/OpenClash.git package/custom/openclash
git clone --depth=1 -b dev https://github.com/vernesong/OpenClash.git feeds/luci/applications/luci-app-openclash

# Nikki / Momo
#git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/custom/nikki
#git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-momo.git package/custom/momo


# Daed
#git clone --depth=1 https://github.com/QiuSimons/luci-app-honk.git package/custom/daed-honk
#git clone --depth=1 -b kix https://github.com/QiuSimons/luci-app-daed.git package/custom/daed
# 添加 vmlinux-btf 模块
#git clone --depth=1 https://github.com/QiuSimons/vmlinux-btf.git package/custom/vmlinux-btf
#git clone --depth=1 https://github.com/kenzok8/openwrt-daede.git package/custom/daede
# SSR+
#git clone --depth=1 https://github.com/fw876/helloworld.git package/custom/ssrp

# 功能插件
#git clone --depth=1 https://github.com/sirpdboy/luci-app-poweroffdevice.git package/custom/poweroffdevice
#git clone --depth=1 https://github.com/isalikai/luci-app-owq-wol.git package/custom/owq-wol
#git clone --depth=1 https://github.com/gdy666/luci-app-lucky.git package/custom/lucky
git clone --depth=1 https://github.com/sbwml/luci-app-openlist2.git package/custom/openlist2

#git clone --depth=1 https://github.com/sirpdboy/luci-app-watchdog.git package/custom/watchdog
#git clone --depth=1 https://github.com/sirpdboy/luci-app-taskplan.git package/custom/taskplan
#git clone --depth=1 https://github.com/iv7777/luci-app-authshield.git package/custom/authshield
#git clone --depth=1 https://github.com/destan19/OpenAppFilter.git package/custom/OpenAppFilter
#git clone --depth=1 https://github.com/janvanstiphout/luci-app-accesscontrol.git package/custom/accesscontrol

# 升级替换 mosdns
# drop mosdns and v2ray-geodata packages that come with the source
#find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
#find ./ | grep Makefile | grep mosdns | xargs rm -f

#git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/custom/mosdns
#git clone https://github.com/sbwml/v2ray-geodata package/custom/v2ray-geodata

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 26.x feeds/packages/lang/golang

# VPN
git clone --depth=1 https://github.com/EasyTier/luci-app-easytier.git package/custom/easytier
#git clone --depth=1 https://github.com/Tokisaki-Galaxy/luci-app-tailscale-community.git package/custom/tailscale-community

# 主题
#git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon
#git clone --depth=1 https://github.com/eamonxg/luci-theme-aurora.git package/custom/luci-theme-aurora
#git clone --depth=1 https://github.com/eamonxg/luci-app-aurora-config.git package/custom/luci-app-aurora-config

# 删除 feeds 中 ImmortalWrt 自带的 Argon 主题
rm -rf feeds/luci/themes/luci-theme-argon

# 将 jerrykuku 的 Argon 主题克隆到 feeds 的对应目录
git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon

# change the default theme:
sed -i 's/+luci-theme-bootstrap/+luci-theme-argon/g; s/default Bootstrap theme/Argon theme/g' feeds/luci/collections/luci-light/Makefile
#sed -i 's/+luci-theme-bootstrap/+luci-theme-aurora/g; s/default Bootstrap theme/Aurora theme/g' feeds/luci/collections/luci-light/Makefile

./scripts/feeds update -a
#./scripts/feeds install -a
./scripts/feeds install -a
