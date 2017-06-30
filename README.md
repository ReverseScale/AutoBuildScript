# AutoBuildScript

![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/87193931.jpg)

![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) ![](https://img.shields.io/cocoapods/dt/PPNetworkHelper.svg
) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

记得之前在创业公司，开发任务重，提测前常常加班到晚上12点，就算bug修完，也要等半个小时看着Xcode不慌不忙的打包完成上传测试平台发邮件才能安心回家。鉴于这种惨痛经历，利用闲暇时间就搞一搞自动打包脚本，整理方法并适配Xcode 8.2之后版本。
三步配置,杜绝污染,一行命令自动上传。

### 我的技术博客：https://reversescale.github.io 欢迎来踩

![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/64620117.jpg)

## Requirements 要求
* iOS 7+
* Xcode 8+

## Usage 使用方法
### 第一步 安装fir-cil
fir-cli 使用 Ruby 构建, 无需编译, 只要安装相应 gem 即可.

```
$ ruby -v # > 1.9.3
$ gem install fir-cli
```

#### 常见的安装问题
(1)使用系统自带的 Ruby 安装, 需确保 ruby-dev 已被正确的安装:
```
$ xcode-select --install        # OS X 系统
$ sudo apt-get install ruby-dev # Linux 系统
```
(2)现 Permission denied 相关错误:
解决：在命令前加上 sudo
(3)出现 Gem::RemoteFetcher::FetchError 相关错误:
解决：更换 Ruby 的淘宝源(由于国内网络原因, 你懂的), 并升级下系统自带的 gem
```
$ gem sources --remove https://rubygems.org/
$ gem sources -a https://ruby.taobao.org/
$ gem sources -l
*** CURRENT SOURCES ***
https://ruby.taobao.org
# 请确保只有 ruby.taobao.org, 如果有其他的源, 请 remove 掉
gem update --system
gem install fir-cli
```
(4)Mac OS X 10.11 以后的版本, 由于10.11引入了 rootless, 无法直接安装 fir-cli, 有以下三种解决办法:
方法一： 使用 Homebrew 及 RVM 安装 Ruby, 再安装 fir-cli(推荐)
```
# Install Homebrew:
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Install RVM:
$ \curl -sSL https://get.rvm.io | bash -s stable --ruby
$ gem install fir-cli
```
方法二： 指定 fir-cli 中 bin 文件的 PATH
```
$ export PATH=/usr/local/bin:$PATH;gem install -n /usr/local/bin fir-cli
```
方法三： 重写 Ruby Gem 的 bindir
```
$ echo 'gem: --bindir /usr/local/bin' >> ~/.gemrc
$ gem install fir-cli
```

### 第二步 登录fir.im
先到 https://fir.im 创建项目，得到 API Token 并复制。

```
fir login
```
命令用于使用 API token 登录 fir.im, 并使用发布应用等相关命令.

```
fir me
```
命令用于查看当前登录用户信息.

示例：
```
$ fir login XXX_YOUR_API_TOKEN_XXX
I, [2016-03-08T12:48:56.499435 #13043]  INFO -- : Login succeed, previous user's email: xxx@fir.im
I, [2016-03-08T12:48:56.507044 #13043]  INFO -- : Login succeed, current  user's email: xxx@fir.im
I, [2016-03-08T12:48:56.507147 #13043]  INFO -- :
$ fir me
I, [2016-03-08T12:48:14.175488 #12986]  INFO -- : Login succeed, current user's email: xxx@fir.im
I, [2016-03-08T12:48:14.175687 #12986]  INFO -- : Login succeed, current user's name:  xxx
I, [2016-03-08T12:48:14.175765 #12986]  INFO -- :
```

### 第三步 下载并配置 shell 脚本
1.把文件夹导入工程目录根目录下

2.配置 shell 脚本
```
# 需要改动的地方 (根据项目具体信息改动)
PROJECT_NAME = "***" 			    	#项目名称
VERSION = "1.0.0"  						#打包版本号 会根据不同的版本创建文件夹（与项目本身的版本号无关）
TAGREAT_NAME = "***"  	#项目对应target的名称如 "Meifabao_User" "Miefabao_stylist"

CONFIGURATION = "Release" 				#打包的环境设置 Release 环境  Debug 环境
PROFILE = "AdHoc" 						#配置文件分为四种 AdHoc  Dev  AppStore Ent 分别对应四种配置文件
OUTPUT = "./Packge/%s" %(CONFIGURATION) #打包导出ipa文件路径（请确保 “%s” 之前的文件夹正确并存在）
```
根据具体项目填写

3.控制台到项目所在目录下，启动脚本(必要时加管理员权限)。
可以将 autobuild.py 拖拽到控制台，执行脚本

注：其他的功能脚本由于实用性不高（其实我懒得搞），暂时没有适配调制，有兴趣的朋友可以自行配置试用，包括：邮件发送、打包App Store等等。

当看到
![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/26413854.jpg)
时 打包好的项目已经躺在你的 Fir 测试平台中了。

### 附录 执行脚本过程中遇到的问题和解决方案

1.fir: command not found

这个是因为没有安装fir-cil，导致找不到相应的命令行，只需要安装一下就行了，详情见上文写的如何安装fir-cil。

2.README: No such file or directory

那是因为你的脚本目录下没有README的文件，只需要建一个README的文件就行了，打开终端，cd到当前位置，然后执行下面的命令：
```
touch README
```
3.ERROR – : Token can not be blank

这个原因是因为你没有登录fir导致的，你执行这个脚本之前应该先登录一下fir，详情请看上文写的登录fir.im。
4.ERROR – : Code=14 (没有试用的设备 Domain=IDEDistributionErrorDomain Code=14 "No applicable devices
原因：rvm ruby 配置错误
解决：控制台 rvm system


使用简单、效率高效、进程安全~~~如果你有更好的建议,希望不吝赐教!
### 你的star是我持续更新的动力!
===

## 联系方式:
* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* QQ : 1129998515


