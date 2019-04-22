#!/bin/bash

################# Precondition #############################

# # 安装 fir-cli
# sudo gem install fir-cli

# # 安装 fastlane
# sudo gem install fastlane

################# End Precondition #############################

################# Constant ############################
# Build 的类型，根据项目 Targets 类型进行设置，常规分为 debug、test、pro 版本
debug_build_type='debug'
test_build_type='test'
pro_build_type='pro'

# 版本升级的类型，如：v1.0.0 123
# -a 是大版本，v 后的第一位 1
# -b 是中版本，v 后的第二位 0
# -c 是小版本，v 后的第三位 0
# -d 是 build 号，最后的一位 123
a_build_version='a'
b_build_version='b'
c_build_version='c'
d_build_version='d'

# 回复邮件
feedback_email=""
################# End Constant ########################

################# Get Parameters ############################
# 默认的编译设置，默认使用 test 进行打包，采用 build 自增机制，上传信息为空
build_type=$test_build_type
build_version_type=$d_build_version
need_upload="1"
uploadMessage=""

function usage()
{
echo "Build XXX app"
echo ""
echo "Options for build:"
echo "-t, --buildtype STRING The build type. Valid values are: debug, test, pro"
echo "-v, --versiontype STRING The version type. Valid values are: a, b, c, d. Example: if version is 2.3.0 and build is 2, then a is 2, b is 2, c is 0 and d is 2."
echo "-m, --message STRING The upload message."
echo "-u, --upload INTEGER Should app need to be upladed? Valid values are: 1, 0"
}

# $OPTARG 获取 Targets 值
# $OPTIND 获取索引
while getopts "t:v:m:u:" option
do
case "$option" in
t)
build_type=$OPTARG
;;

buildtype)
build_type=$OPTARG
;;

v)
build_version_type=$OPTARG
;;

versiontype)
build_version_type=$OPTARG
;;

m)
uploadMessage=$OPTARG
;;

message)
uploadMessage=$OPTARG
;;
u)
need_upload=$OPTARG
;;
upload)
need_upload=$OPTARG
;;

\?)
usage
exit 1;;
esac
done

# 切换选项和可选项
shift "$((OPTIND-1))"

################# End Get Parameters ############################

################# Configuration ############################
# ipa 文件名
app_ipa_file='XXX.ipa'

# ipa 存储路径，根据需要设置
app_package_path='../../XXXPackage'

# 项目文件路径
app_workspace='./XXX.xcworkspace'

# info.plist 文件路径
app_info_plist='./XXX/info.plist'

# info.plist 回滚文件路径
app_info_plist_rollback='XXX/Info.plist'

# xcode 项目中的 schema 名称
app_schema='XXX'

# 应用包名标识符
app_bundle_identifier='com.XXX.ios'

# Test Flight 账号信息
app_id='XXX'
apple_id='XXX@xxx.com'

# 蒲公英测试平台 账号信息
#pgyer_user_key='XXX'
#pgyer_api_key='XXX'

# Fir 测试平台 账号信息
fir_user_token='XXX'


################# End Configuration ########################

# 打印构建类型、版本类型、上传信息
echo "The build type is [$build_type]"
echo "The version type is [$build_version_type]"
echo "The uplaod is [$need_upload]"

# 获取 Version 版本信息
function getVersion() {
shortVersion=`/usr/libexec/PlistBuddy -c 'print CFBundleShortVersionString' $1`
buildVersion=`/usr/libexec/PlistBuddy -c 'print CFBundleVersion' $1`
version=${shortVersion}'.'${buildVersion}
echo "$version"
}

# 更新 Version 版本信息
function updateVersion() {
OLD_IFS="$IFS"
IFS="."
version=($2)
IFS="$OLD_IFS"

shortVersion="${version[0]}.${version[1]}.${version[2]}"
buildVersion=${version[3]}

/usr/libexec/PlistBuddy -c "set CFBundleShortVersionString $shortVersion" $1
/usr/libexec/PlistBuddy -c "set CFBundleVersion $buildVersion" $1
}

# 拼接 Version 版本信息
function incVersion() {
OLD_IFS="$IFS"
IFS="."
version=($1)
IFS="$OLD_IFS"
build_version_type=$2

if [[ $build_version_type = $d_build_version ]]; then
version[3]=`expr 1 + ${version[3]}`
elif [[ $build_version_type = $c_build_version ]]; then
version[2]=`expr 1 + ${version[2]}`
elif [[ $build_version_type = $b_build_version ]]; then
version[1]=`expr 1 + ${version[1]}`
version[2]=0
elif [[ $build_version_type = $a_build_version ]]; then
version[0]=`expr 1 + ${version[0]}`
version[1]=0
version[2]=0
fi

echo "${version[0]}.${version[1]}.${version[2]}.${version[3]}"
}

# 打印编译信息
echo 'release XXX build'
echo 'get XXX build version'

version=`getVersion $app_info_plist`
echo "build version $version"

newVersion=`incVersion $version $build_version_type`
echo "update to new version $newVersion";
updateVersion $app_info_plist $newVersion

#  echo '-----------git status here ------------'
#  git 操作放置于此

#  echo '-----------git status end--------------'

# 删除旧文件（如果存在）
outputDir="$app_package_path/$build_type/$newVersion"
outputPath="$outputDir/$app_ipa_file"
outputArchivePath="$outputDir/$newVersion.xcarchive"
echo $outputPath

rm -rf "$outputPath"

# fastline 打包命令区
if [[ $build_type = $debug_build_type ]]; then
echo 'build XXX dev build now, please wait.................'
fastlane gym --silent --workspace ${app_workspace} --scheme ${app_schema} --clean --xcargs 'GCC_PREPROCESSOR_DEFINITIONS="$GCC_PREPROCESSOR_DEFINITIONS DEBUG=1 COCOAPODS=1"' --export_method ad-hoc --output_directory ${outputDir} --output_name ${app_ipa_file}
elif [[ $build_type = $test_build_type ]]; then
echo 'build XXX test build now, please wait.................'
fastlane gym --silent --workspace ${app_workspace} --scheme ${app_schema} --clean --xcargs 'GCC_PREPROCESSOR_DEFINITIONS="$GCC_PREPROCESSOR_DEFINITIONS TEST=1 COCOAPODS=1"' --export_method ad-hoc --output_directory ${outputDir} --output_name ${app_ipa_file}
elif [[ $build_type = $pro_build_type ]]; then
echo 'build XXX pro build now, please wait.................'
fastlane gym --silent --workspace ${app_workspace} --scheme ${app_schema} --clean --xcargs 'GCC_PREPROCESSOR_DEFINITIONS="$GCC_PREPROCESSOR_DEFINITIONS PRO=1 COCOAPODS=1"' --archive_path ${outputArchivePath} --export_method app-store --output_directory ${outputDir} --output_name ${app_ipa_file}
fi

# 编译完成输出信息
if [[ -e $outputPath ]]; then
echo 'build ipa successfully, commit code'
#svn ci -m "update XXX build to version  $newVersion"

git commit -am "update XXX build to version  $newVersion"
git push

if [[ $need_upload = "1" ]]; then
if [[ $uploadMessage = "" ]]; then
uploadMessage="XXX iOS APP 新版本测试描述信息 $newVersion"
fi

if [[ $build_type = $debug_build_type ]]; then
echo 'uploading to Fir'
fir publish $outputPath -T $fir_user_token -c $uploadMessage --verbose
elif [[ $build_type = $test_build_type ]]; then
echo 'uploading to Fir'
fir publish $outputPath -T $fir_user_token -c $uploadMessage --verbose
elif [[ $build_type = $pro_build_type ]]; then
git tag "XXX_${newVersion}"
git push origin "XXX_${newVersion}"

echo 'uploading to Test Flight'
fastlane pilot upload --username $apple_id --app_identifier $app_bundle_identifier --app_platform "ios" --ipa $outputPath --changelog $uploadMessage --beta_app_description $uploadMessage --beta_app_feedback_email $feedback_email
fi
# 编译完成 Mac 通知
osascript -e 'display notification "XXX iOS APP 上传成功" with title "打包通知"'
fi
else
echo 'build ipa failed, rollback info'
git checkout $app_info_plist_rollback
fi

