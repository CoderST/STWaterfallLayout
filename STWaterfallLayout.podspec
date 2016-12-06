#
#  Be sure to run `pod spec lint STWaterfallLayout.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "STWaterfallLayout"
s.version      = "0.0.1"
s.summary      = "swift版本瀑布流."
s.ios.deployment_target = '8.0'
s.homepage     = "https://github.com/CoderST/STWaterfallLayout"
# 开源许可证
s.license      = { :type => 'MIT', :file => 'LICENSE' }
# 作者信息
s.authors      = { 'CoderST' => '694468528@qq.com' }
# 所支持的系统以及版本号
s.platform     = :ios, '8.0'
# 项目首页
s.homepage     = "https://github.com/CoderST/STWaterfallLayout"
# 资源地址链接
s.source       = { :git => 'https://github.com/CoderST/STWaterfallLayout.git', :tag => s.version.to_s }
# 是否支持arc
s.requires_arc = true
# 文件
s.source_files = 'STWaterfallLayout/*.swift'

end
