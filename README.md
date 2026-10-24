云编译798x特定机型的精简极速固件 （p3terx 2024新版 基于ubuntu22.04）

路由器型号：
   clx s20l s20m S20P
说明：
     
     基immortalwrt的闭源带WIFI硬件加速不带docker固件
     默认地址：192.168.2.1 密码：无，直接回车
     openwrt25.12最新的APK包格式（注意非android的APK，同名而已）
- 感谢 https://github.com/yhlh9982/
- 25.12分支维护大佬chasey-dev网址：https://github.com/chasey-dev/immortalwrt-mt798x-rebase
- 脚本参考有 七曜大佬 ：https://github.com/VIKINGYFY/CloseWRT-CI
- apk包格式对安装的签名要求跟严格，一般的，安装第三方包可以用：apk add --allow-untrusted XXX.apk
  
注意事项：
     不死u-boot用 H 大的刷，地址：https://github.com/hanwckf/bl-mt798x/releases
     u-boot 刷机方法：https://cmi.hanwckf.top/p/mt798x-uboot-usage
     更新刷写固件时，跨版本更新的，记得不要保存设置，每次更新系统后再按住 rest键8 秒复位一次
     刷写完新固件后，尤其是跨版本更新的，记得先清理浏览器缓存，再访问路由器进行设置。
