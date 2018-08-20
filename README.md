# AutoBuildScript
![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) ![](https://img.shields.io/badge/download-53K-brightgreen.svg
) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

![image](http://og1yl0w9z.bkt.clouddn.com/17-6-30/87193931.jpg)

[EN](https://github.com/ReverseScale/AutoBuildScript) | [中文](https://github.com/ReverseScale/AutoBuildScript/blob/master/README_zh.md)

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

