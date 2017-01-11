platform :ios, '7.0'
workspace 'Workspace.xcworkspace' #workspace 与Podfile的相对路径

#source 私有仓库的git地址
source 'http://172.16.100.58:7070/r/WASdkIntf.git'
source 'http://172.16.100.58:7070/r/WASdkImpl.git'
source 'http://172.16.100.58:7070/r/WAAfImpl.git'
source 'http://172.16.100.58:7070/r/WAApImpl.git'
source 'http://172.16.100.58:7070/r/WACbImpl.git'
source 'http://172.16.100.58:7070/r/WAFbImpl.git'
source 'http://172.16.100.58:7070/r/WAVkImpl.git'
source 'http://172.16.100.58:7070/r/WAWebPayImpl.git'
target "WADemo" do #target 即是工程名称(.xcodeporj)

#pod '私有仓库名字', '~> 版本号'
pod 'WASdkIntf', '~> 3.6.1'
pod 'WASdkImpl', '~> 3.6.1'
pod 'WAAfImpl', '~> 3.6.1'
pod 'WAApImpl', '~> 3.6.1'
pod 'WACbImpl', '~> 3.6.1'
pod 'WAFbImpl', '~> 3.6.1'
pod 'WAVkImpl', '~> 3.6.0'
pod 'WAWebPayImpl', '~> 3.6.1'

end