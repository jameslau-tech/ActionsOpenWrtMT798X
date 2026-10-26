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
     1) uboot 推荐使用 https://github.com/Yuzhii0718/bl-mt798x-dhcpd
     2) 每次编译不同的软件，可以先下载manifest文件看看软件包是否符合自己的需求
     
