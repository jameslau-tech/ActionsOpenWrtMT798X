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
#rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
#git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/custom/passwall-packages
#rm -rf feeds/luci/applications/luci-app-passwall
#git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall.git package/custom/passwall
#git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/custom/passwall2

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


# Daed (kenzok8 build for X86)
rm -rf feeds/luci/applications/luci-app-dae
rm -rf feeds/luci/applications/luci-app-honk
#git clone --depth=1 https://github.com/kenzok8/openwrt-honk.git package/custom/honk
git clone --depth=1 https://github.com/QiuSimons/luci-app-honk.git  package/custom/honk
#git clone  --depth=1 https://github.com/QiuSimons/luci-app-dae  feeds/luci/applications/luci-app-dae
# 修复：download.pl 只认小写 skip，把包内 Makefile 的大写 SKIP 统一改小写
sed -i 's/?=SKIP$/?=skip/' "$PKG_DIR/honk/honk/Makefile"

HONK_DIR="$PKG_DIR/honk/honk"
HONK_OUT="$HONK_DIR/files/honk-core.bin"
if [ -s "$HONK_OUT" ]; then
    log " ↷ honk-core.bin 已存在，跳过预放"
else
    group "预放 honk-core.bin（免 zig 工具链）"
    curl -fsSL --retry 3 -o /tmp/honk-core.tar.gz \
      "https://github.com/daeuniverse/honk/releases/download/v0.1.0-beta.2/honk-core-v0.1.0-beta.2-aarch64-unknown-linux-musl-stock-native-api.tar.gz"
    echo "bef60542db1d29fa87ad3b5300d0960a1bd173b7ba1121b423b27985a202eb2c  /tmp/honk-core.tar.gz" | sha256sum -c -
    rm -rf /tmp/honkpkg && mkdir -p /tmp/honkpkg
    tar -xzf /tmp/honk-core.tar.gz -C /tmp/honkpkg
    core="$(find /tmp/honkpkg -type f -name honk-core -print -quit)"
    [ -n "$core" ] || die "tarball 内未找到 honk-core，release 结构可能已变"
    mkdir -p "$HONK_DIR/files"
    cp "$core" "$HONK_OUT"
    log " ✅ 已预放 honk-core.bin ($(du -h "$HONK_OUT" | cut -f1))"
    endgroup
fi
# ------------------------------------------------------------------
# honk 仓库的 Makefile 把 PKG_HASH 写成大写 SKIP 占位，
# OpenWrt scripts/download.pl 只识别小写 skip 跳过校验；
# 大写 SKIP 会触发 "Cannot find appropriate hash command ..."。
# 这里把 PKG_HASH / PKG_MIRROR_HASH 的纯 SKIP 占位统一改成 skip。
# 只匹配纯占位行，不会误伤真实哈希。
# ------------------------------------------------------------------
sed -i 's/?=SKIP$/?=skip/' "$PKG_DIR/honk/honk/Makefile"

if [ -d "$PKG_DIR/honk" ]; then
  honk_patched=0
  while IFS= read -r -d '' mkfile; do
    if grep -qE '^[[:space:]]*PKG_(HASH|MIRROR_HASH)[[:space:]]*:?=[[:space:]]*SKIP[[:space:]]*$' "$mkfile"; then
      sed -i -E 's/^([[:space:]]*PKG_(HASH|MIRROR_HASH)[[:space:]]*:?=[[:space:]]*)SKIP[[:space:]]*$/\1skip/' "$mkfile"
      log "  ✏ 修正 $(basename "$(dirname "$mkfile")")/Makefile：PKG_*HASH SKIP → skip"
      honk_patched=$((honk_patched + 1))
    fi
  done < <(find "$PKG_DIR/honk" -type f -name Makefile -print0)
  log "  ✅ honk Makefile 哈希占位修正: ${honk_patched} 处"
fi

# SSR+
#git clone --depth=1 https://github.com/fw876/helloworld.git package/custom/ssrp

# 功能插件
#git clone --depth=1 https://github.com/sirpdboy/luci-app-poweroffdevice.git package/custom/poweroffdevice
#git clone --depth=1 https://github.com/isalikai/luci-app-owq-wol.git package/custom/owq-wol
#git clone --depth=1 https://github.com/gdy666/luci-app-lucky.git package/custom/lucky
#git clone --depth=1 https://github.com/sbwml/luci-app-openlist2.git package/custom/openlist2

#git clone --depth=1 https://github.com/sirpdboy/luci-app-watchdog.git package/custom/watchdog
#git clone --depth=1 https://github.com/sirpdboy/luci-app-taskplan.git package/custom/taskplan
#git clone --depth=1 https://github.com/iv7777/luci-app-authshield.git package/custom/authshield
#git clone --depth=1 https://github.com/destan19/OpenAppFilter.git package/custom/OpenAppFilter
#git clone --depth=1 https://github.com/janvanstiphout/luci-app-accesscontrol.git package/custom/accesscontrol

# 升级替换 mosdns
# drop mosdns and v2ray-geodata packages that come with the source
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

#git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/custom/mosdns
#git clone https://github.com/sbwml/v2ray-geodata package/custom/v2ray-geodata

#rm -rf feeds/packages/lang/golang
#git clone https://github.com/sbwml/packages_lang_golang -b 26.x feeds/packages/lang/golang

# VPN
git clone --depth=1 https://github.com/EasyTier/luci-app-easytier.git package/custom/easytier
#git clone --depth=1 https://github.com/Tokisaki-Galaxy/luci-app-tailscale-community.git package/custom/tailscale-community

# 主题
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
