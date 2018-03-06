# AutoBuildScript

![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/87193931.jpg)

![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) ![](https://img.shields.io/badge/download-53K-brightgreen.svg
) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

I remember before the start-up company, the task of heavy development, before the test often overtime to 12 o'clock in the evening, even if the bug is completed, have to wait for half an hour watching Xcode unhurried package completed the test platform to send mail to ease home . In view of this painful experience, the use of leisure time engaged in the implementation of automatic packaging script, organize methods and adapt to Xcode after 8.2 version.
Three-step configuration, eliminate pollution, his party orders automatically upload.

![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/64620117.jpg)

## 🚀 Advantage 
* 1. The least file on the market, using the most convenient automated packaging script
* 2. Redundancy less, clear structure, complete notes
* 3. At the same time support multi-platform upload, such as: Dir, Fir, dandelion, App Store and so on
* 4. Has a high custom

## 🤖 Requirements 
* iOS 7+
* Xcode 8+

## 🛠 Usage 
### The first step is to install fir-cil
fir-cli is built using Ruby and does not require compilation as long as the corresponding gem is installed.

```
$ ruby -v # > 1.9.3
$ gem install fir-cli
```

#### Common installation problems
(1) use the system comes with Ruby installation, make sure ruby-dev has been installed correctly:
```
$ xcode-select --install        # OS X system
$ sudo apt-get install ruby-dev # Linux system
```
(2) Permission denied related errors:
Solution: add sudo before the command
(3) There was a problem related to Gem :: RemoteFetcher :: FetchError:
Solution: replace Ruby Taobao source (due to domestic network reasons, you know), and upgrade the system comes with the gem
```
$ gem sources --remove https://rubygems.org/
$ gem sources -a https://ruby.taobao.org/
$ gem sources -l
*** CURRENT SOURCES ***
https://ruby.taobao.org
# Please make sure that only ruby.taobao.org, if there are other sources, remove remove
gem update --system
gem install fir-cli
```
(4) Since Mac OS X version 10.11 and later, 10.11 introduced rootless and can not directly install fir-cli. There are three solutions:
Method 1: Install Ruby with Homebrew and RVM, then install fir-cli (recommended)
```
# Install Homebrew:
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Install RVM:
$ \curl -sSL https://get.rvm.io | bash -s stable --ruby
$ gem install fir-cli
```
Method 2: Specify the PATH of the bin file in fir-cli
```
$ export PATH=/usr/local/bin:$PATH;gem install -n /usr/local/bin fir-cli
```
Method 3: Override Ruby Gem's bindir
```
$ echo 'gem: --bindir /usr/local/bin' >> ~/.gemrc
$ gem install fir-cli
```

### Step 2 Login fir.im
First https://fir.im create a project, get API Token and copy.

```
fir login
```
Commands are used to log in to fir.im using the API token and use commands such as publishing applications.

```
fir me
```
Command to view the currently logged in user information.

Example:
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

### The third step is to download and configure shell scripts
1. The folder into the project directory root directory

2 configuration shell script
```
# Need to change the place (according to the project specific information changes)
PROJECT_NAME = "***" # project name
VERSION = "1.0.0" # Package version number will be created according to different versions of the folder (regardless of the version number of the project itself)
TAGREAT_NAME = "***" # The name of the corresponding target such as "Meifabao_User" "Miefabao_stylist"
CONFIGURATION = "Release" 				# Packaged environment settings Release environment Debug environment
PROFILE = "AdHoc" # The configuration file is divided into four kinds of AdHoc Dev AppStore Ent corresponding to four kinds of configuration files
OUTPUT = "./Packge/%s"% (CONFIGURATION) # package export ipa file path (make sure the "% s" before the folder is correct and there)
```
Fill in according to the specific project

3. Console to the project directory, start the script (if necessary, add administrator privileges).
You can drag autobuild.py to the console and execute the script

Note: Due to the practicality of other function script is not high (in fact, I am too lazy to engage), there is no adapter modulation, interested friends can configure their own trials, including: e-mail, packaged App Store and so on.

When you see it
![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/26413854.jpg)
The packaged items are already on your Fir testbed.

### Appendix Problems and solutions encountered during script execution

1.fir: command not found

This is because there is no installation fir-cil, resulting in the corresponding command line can not find, just need to install it on the line, see the above wrote how to install fir-cil.

2.README: No such file or directory

That is because there is no README file in your script directory. You just need to create a README file, open the terminal, cd to the current location, and execute the following command:
```
touch README
```
3.ERROR – : Token can not be blank

This is because you are not logged in to fir, and you should log in to fir before executing this script. For more information, please see the login fir.im.

4.ERROR -: Code = 14 (no trial device Domain = IDEDistributionErrorDomain Code = 14 "No applicable devices
Reason: rvm ruby configuration error
Solution: console rvm system


## ⚖ License

```
MIT License

Copyright (c) 2017 ReverseScale

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 😬 Contributions

* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io

---
# 中文说明

记得之前在创业公司，开发任务重，提测前常常加班到晚上12点，就算bug修完，也要等半个小时看着Xcode不慌不忙的打包完成上传测试平台发邮件才能安心回家。鉴于这种惨痛经历，利用闲暇时间就搞一搞自动打包脚本，整理方法并适配Xcode 8.2之后版本。
三步配置,杜绝污染,一行命令自动上传。

![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/64620117.jpg)

## 🚀 框架的优势
* 1.市面上文件最少，使用最便捷的自动化打包脚本
* 2.冗余方法少，结构清晰，注释齐全
* 3.同时支持多平台上传，如：Dir、Fir、蒲公英、App Store等
* 4.具备较高自定义性

## 🤖 要求
* iOS 7+
* Xcode 8+

## 🛠 使用方法
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


## ⚖ 协议

```
MIT License

Copyright (c) 2017 ReverseScale

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 😬  联系

* 微信 : WhatsXie
* 邮件 : ReverseScale@iCloud.com
* 博客 : https://reversescale.github.io
