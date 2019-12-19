# HW1
------
## 安装macOS
1. 必须先使用unlock脚本。注意*以管理员身份运行*
2. 使用镜像建立虚拟机时。注意*ftp中给出的是10.14版本*
3. 内存不要给的过多，我的机器是8G内存，给虚拟机提供2G内存即可。
4. 需要使用磁盘工具先抹掉磁盘。
5. 安装过程需要漫长的等待，不要着急，作出强制关机等行为。
##VMware Tools
1. 需要macOS中的CD/DVD改成使用物理驱动器
2. 在VMware上方导航栏选择虚拟机栏，并安装VMware Tools
## 安装Xcode
1. 不知道是什么原因，在macOS上下载的xip文件是错误的，所以选择在WIN下载后再移入macOS
2. 需要使用到的是共享文件夹，需要在VMware中启用共享文件夹
3. 接着将xip文件拖到桌面上双击等待安装即可。
## Git的学习
首先需要使用
>git config --global user.name "你的名字"
>git config --global user.email "你的昵称"
配置好相关信息

接着：
1. 使用fork将老师的仓库复制一份到自己的仓库中
2. 在自己的仓库中复制链接
3. 在装好git的机器上，使用git clone + 复制好的链接，将文件复制到本地
4. 在本地进行修改
5. 使用git add . 将修改加入监视
6. 使用git commit -m "my commit"进行备注信息及提交
7. 使用git push将本地提交推送到远程仓库
