![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) ![](https://img.shields.io/badge/download-53K-brightgreen.svg
) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/87193931.jpg)

[EN](https://github.com/ReverseScale/AutoBuildScript) | [中文](https://github.com/ReverseScale/AutoBuildScript/blob/master/README_zh.md)

## 🤪 故事背景
记得大约两年前，当时在创业公司，开发任务重，提测前常常加班到晚上 12 点，就算 bug 修完，也要看着 Xcode 不慌不忙的花半个多小时打包完成，再上传测试平台，发了邮件才能安心回家。鉴于这种惨痛经历，利用闲暇时间就搞一搞自动打包脚本，后期有配上 Jenkins，从此过上了没羞没臊的生活。（已适配 Xcode 8.2 之后版本）

三步配置，杜绝污染，一行命令自动上传。

![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/64620117.jpg)

## 🚀 框架的优势
* 1.市面上文件最少，使用最便捷的自动化打包脚本
* 2.冗余方法少，结构清晰，注释齐全
* 3.同时支持多平台上传，如：Dir、Fir、蒲公英、App Store等
* 4.具备较高自定义性
* 5.[自编脚本的时代] -> [Fastlane 的时代]

## 🤖 要求
* Xcode 8+

█◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢█

## 🚂 自编脚本的时代

> [🚂 自编脚本的时代] 了解一下即可，有些准备工作提供参考，如环境已经配置好，请直接阅读 [🚄 Fastlane 的时代]

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

显示信息如下：
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

3.控制台到项目所在目录下，启动脚本(必要时加管理员权限)

可以将 autobuild.py 拖拽到控制台，执行脚本

注：其他的功能脚本由于实用性不高（其实我懒得搞），暂时没有适配，有兴趣的朋友可以自行配置试用，包括：邮件发送、打包 App Store 等等。

当看到

![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/26413854.jpg)

时，打包好的项目已经躺在你的 Fir 测试平台中了。

█◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢█

## 🚄 Fastlane 的时代
### 2018.08.20 更新：Jenkins + Fastlane + GitLab + fir (或者蒲公英)

1.安装 Fastlane

Fastlane 是一套使用Ruby写的自动化工具集，用于iOS和Android的自动化打包、发布等工作，可以节省大量的时间

```
sudo gem install fastlane --verbose
```

2.移动脚本至项目目录下

根据注释完善脚本配置信息

脚本说明：

* 支持版本号自增长
* 支持传入自定的宏，用于在代码里使用此预编译的宏来区分开发环境和发布环境
* 支持自动上传到 fir 和 testflight
* 上传成功后弹窗提示

3.上传

3.1 上传到 fir 的用法：
```
./build.sh -m "xxxx_app_test" -t test
```

3.2 上传到 testflight 的用法：

```
./build.sh -m "xxxx_app_pro" -t pro
```

4.Jenkins

Jenkins 是一个开源项目，提供了一种易于使用的持续集成系统，使开发者从繁杂的集成中解脱出来，专注于更为重要的业务逻辑实现上。同时 Jenkins 能实施监控集成中存在的错误，提供详细的日志文件和提醒功能，还能用图表的形式形象地展示项目构建的趋势和稳定性。

4.1 下载 Jenkins：

点击 http://mirrors.jenkins.io/war-stable/latest/jenkins.war 下载最新的Jenkins.war

4.2 运行服务器：

需要先安装 java sdk （http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html）

```
java -jar jenkins.war
```

4.3 运行 Jenkins

```
jenkins
```

4.4 配置 Jenkins：

浏览器打开 http://localhost:8080/ 输入安全密码，安全密码命令行输出的一个文件里面。

然后自动安装推荐的插件，并新建管理员账号密码。

4.5 安装插件

登录http://localhost:8080/ ，选择系统管理 - 管理插件。
在可选插件中选择GitLab Plugin，Gitlab Hook Plugin，和 Cocoapod plugin 进行安装。

4.6 构建任务

* 1. 点击新建，输入名称，构建一个自由风格的软件项目。
* 2. 配置 Git 仓库地址，并添加 git 账号。
* 3. 配置构建脚本 

![](http://og1yl0w9z.bkt.clouddn.com/18-8-20/69661690.jpg)



### 附录 执行脚本过程中遇到的问题和解决方案

#### 1.fir: command not found

这个是因为没有安装fir-cil，导致找不到相应的命令行，只需要安装一下就行了，详情见上文写的如何安装fir-cil。

#### 2.README: No such file or directory

那是因为你的脚本目录下没有README的文件，只需要建一个README的文件就行了，打开终端，cd到当前位置，然后执行下面的命令：

```
touch README
```

#### 3.ERROR – : Token can not be blank

这个原因是因为你没有登录fir导致的，你执行这个脚本之前应该先登录一下fir，详情请看上文写的登录fir.im。

#### 4.ERROR – : Code=14 (没有试用的设备 Domain=IDEDistributionErrorDomain Code=14 "No applicable devices

原因：rvm ruby 配置错误

解决：控制台 rvm system


### 2018.08.20 更新：Jenkins 相关设置方法

#### 5.查看端口占用

端口占用

使用 lsof 会列举所有占用的端口列表：

```
lsof
```

使用less可以用于分页展示，如：

```
lsof | less
```

也可以使用 -i 查看某个端口是否被占用，如：

```
lsof -i:3000
```

杀死进程

```
kill PID（进程的PID，如2044）
```

#### 6.Jenkins 改时区

http://your-jenkins/systemInfo，查看user.timezone变量的值

![](http://og1yl0w9z.bkt.clouddn.com/18-8-20/14173777.jpg)

在jenkins的【系统管理】-【脚本命令行】里运行

```
System.setProperty('org.apache.commons.jelly.tags.fmt.timeZone', 'Asia/Shanghai')
```

#### 7.Jenkins 构建超时

jenkins的”build timeout plugin”插件可以帮我们完成该任务。我使用的是jenkins-2.7.1, 默认就已经安装了该插件，如果默认没有安装可在插件管理中搜索进行安装。

任务超时配置如下图：

![](http://og1yl0w9z.bkt.clouddn.com/18-8-20/819954.jpg)

#### 8.Jenkins 定时构建和Poll SCM的区别

* Build periodically：周期进行项目构建（源码是否发生变化没有关系）
* Poll SCM：定时检查源码变更，如果有更新就checkout最新code下来，然后执行构建动作

```
每15分钟构建一次：H/15 * * * *  或 */5 * * * *

每天8点构建一次：0 8 * * *

每天8点~17点，两小时构建一次：0 8-17/2 * * *

周一到周五，8点~17点，两小时构建一次：0 8-17/2 * * 1-5

每月1号、15号各构建一次，除12月：H H 1,15 1-11 *

*/5 * * * * （每5分钟检查一次源码变化）

0 2 * * * （每天2:00 必须build一次源码）
```

### 2018.08.20 更新：agvtool 命令行 管理版本号

常用命令行：

设置 版本号 为 `1.1.0`
```
xcrun agvtool new-marketing-version 1.1.0
```

设置 build 号 `自动加1`
```
xcrun agvtool next-version -all
```

agvtool是一个命令行工具，允许你自动递增到下一个最高的数量或具体的数字这些数字。

1.



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
