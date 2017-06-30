
##Packge文件夹主要存储导出的ipa文件
###1. 安装fir-cli
- 使用该自动打包脚本如需使用fir.im自动上传需要先安装fir-cli
	- [具体参考该链接](https://github.com/Caiflower/fir-cli)
	-  Mac OS X 10.11 以后的版本, 由于10.11引入了 rootless, 无法直接安装 fir-cli, 有以下三种解决办法:
		- 1. 使用 Homebrew 及 RVM 安装 Ruby, 再安装 fir-cli(推荐)
		
		```objc
		# Install Homebrew:
		$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

		# Install RVM:
		$ curl -sSL https://get.rvm.io | bash  
		$ source ~/.bashrc    
		$ source ~/.bash_profile  
		
		# Install fir-cli:
		$ gem install fir-cli  
		
		
		#如出现Operation not permitted权限问题,是因为El Capitan之后 加入了Rootless机制,不再能够随心所欲的读写很多路径下了,需要关闭 Rootless, 步骤如下
		1. 重启MAC电脑按住Command + R,进入恢复模式
		2. 打开Terminal(终端)
		3. csrutil disable 然后重启电脑即可,如果之后需要恢复默认那么重新进入恢复模式执行csrutil enable命令
		
		```
- 测试fir-cli是否安装成功
	
	```
	$ fir v 查看版本号 
	# fir-cli 1.5.0
	$ fir login
	Please enter your fir.im API Token:输入Fir上面的API Token
	I, [2016-12-14T10:36:17.518756 #1490]  INFO -- : Login succeed, current user's email: louisliu@meifabao.cn
I, [2016-12-14T10:36:17.519057 #1490]  INFO -- : Login succeed, current user's name:  louisliu
I, [2016-12-14T10:36:17.519133 #1490]  INFO -- :
	```
	
### 2.执行脚本
- 0. 确保安装了Xcode自定的 command line Tools,如没安装执行下面命令
	- xcode-select --install 	
- 1. 用 Xcode 打开项目根木下的 autobuild.py 文件，修改里面的配置信息(内附详细注释)
- 2. 确保项目已经启用自动签名功能，并能够在真机上运行。并启动自动签名
- 3. 运行脚本
	- 打开终端，cd 到你的项目根目录下
	- 把 autobuild.py 拖入终端里，再回车 

[参考链接](http://www.jianshu.com/p/902c04429179)	
