# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# 下面两行是指明依赖库的来源地址
source 'https://github.com/CocoaPods/Specs.git'# 使用官方默认地址（默认）
source 'https://github.com/Artsy/Specs.git'# 使用其他来源地址

# install! 只走一次，多次使用只以最后一个标准执行
# deterministic_uuids 解决与私有库的冲突
# generate_multiple_pod_projects 可以让每个依赖都作为一个单独的项目引入，大大增加了解析速度；cocoapods 1.7 以后支持
# disable_input_output_paths ？？？
# 需要特别说明的：在 post_install 时，为了一些版本的兼容，需要遍历所有 target，调整一部分库的版本；但是如果开启了 generate_multiple_pod_projects 的话，由于项目结构的变化，installer.pod_targets 就没办法获得所有 pods 引入的 target 了
install! 'cocoapods',:deterministic_uuids=>false,generate_multiple_pod_projects: true,disable_input_output_paths: true

platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

def func
  pod 'JobsGlobleDef'
  pod 'Masonry'
  pod 'GKNavigationBar' # https://github.com/QuintGao/GKNavigationBar NO_SMP
  pod 'GKPhotoBrowser' # https://github.com/QuintGao/GKPhotoBrowser iOS仿微信、今日头条等图片浏览器 
  pod 'ReactiveObjC'  # https://github.com/ReactiveCocoa/ReactiveObjC 重量级框架
  pod 'SPAlertController'# https://github.com/SPStore/SPAlertController 深度定制AlertController
  pod 'MJRefresh' # https://github.com/CoderMJLee/MJRefresh An easy way to use pull-to-refresh
  pod 'MJExtension' # https://github.com/CoderMJLee/MJExtension A fast, convenient and nonintrusive conversion framework between JSON and model. Your model class doesn't need to extend any base class. You don't need to modify any model file.
  pod 'FLAnimatedImageView+RGWrapper' #
  pod 'AFNetworking'  # https://github.com/AFNetworking/AFNetworking A delightful networking framework for iOS, macOS, watchOS, and tvOS.
  pod 'JPImageresizerView' # https://github.com/Rogue24/JPImageresizerView 一个专门裁剪图片、GIF、视频的轮子，简单易用，功能丰富（高自由度的参数设定、支持旋转和镜像翻转、蒙版、压缩等），能满足绝大部分裁剪的需求。
  pod 'JXPagingView/Pager' # https://github.com/pujiaxin33/JXPagingView NO_SMP
  pod 'JXCategoryView'  # https://github.com/pujiaxin33/JXCategoryView A powerful and easy to use category view (segmentedcontrol, segmentview, pagingview, pagerview, pagecontrol) (腾讯新闻、今日头条、QQ音乐、网易云音乐、京东、爱奇艺、腾讯视频、淘宝、天猫、简书、微博等所有主流APP分类切换滚动视图)
  pod 'SDWebImage'  # https://github.com/SDWebImage/SDWebImage Asynchronous image downloader with cache support as a UIImageView category
  pod 'YYImage'
  pod 'WHToast' # https://github.com/remember17/WHToast 一个轻量级的提示控件，没有任何依赖
  pod 'SDWebImage'  # https://github.com/SDWebImage/SDWebImage Asynchronous image downloader with cache support as a UIImageView category
  pod 'lottie-ios', '~> 2.5.3' # 这个是OC版本
  pod 'BRPickerView'  # https://github.com/91renb/BRPickerView 该组件封装的是iOS中常用的选择器组件，主要包括：日期选择器、时间选择器（DatePickerView）、地址选择器（AddressPickerView）、自定义字符串选择器（StringPickerView）。支持自定义主题样式，适配深色模式，支持将选择器组件添加到指定容器视图。
  pod 'LYEmptyView'
  pod 'TABAnimated' # https://github.com/tigerAndBull/TABAnimated
  pod 'TXFileOperation'
  
  pod 'ZFPlayer'
  pod 'ZFPlayer/ControlView'
  pod 'ZFPlayer/AVPlayer'
  pod 'ZFPlayer/ijkplayer'
  
  end

# 基础的公共配置
def cocoPodsConfig
  target 'TFRememberHistoryInputContentWithDropListTests' do
    inherit! :search_paths # abstract! 指示当前的target是抽象的，因此不会直接链接Xcode target。与其相对应的是 inherit！
    # Pods for testing
    end
  
  target 'TFRememberHistoryInputContentWithDropListUITests' do
    inherit! :search_paths
    # Pods for testing
    end
  
  # 当我们下载完成，但是还没有安装之时，可以使用hook机制通过pre_install指定要做更改，更改完之后进入安装阶段。 格式如下：
  pre_install do |installer|
      # 做一些安装之前的更改
    end
  
  # 这个是cocoapods的一些配置,官网并没有太详细的说明,一般采取默认就好了,也就是不写.
  post_install do |installer|
    installer.pods_project.targets.each do |target|

      # 当我们安装完成，但是生成的工程还没有写入磁盘之时，我们可以指定要执行的操作。 比如，我们可以在写入磁盘之前，修改一些工程的配置：

      puts "!!!! #{target.name}"
      end
    end
  end

target 'TFRememberHistoryInputContentWithDropList' do
  # Pods for TFRememberHistoryInputContentWithDropList
  func
  cocoPodsConfig
end
