# NSIS-BUILD-TEMPLATE

#### 介绍
使用NSIS打包的Windows应用的项目，通过此项目可以简单实现Windows安装应用项目的构建
#### 目录介绍
  - AppCode
    - app 项目打包所需的文件
      - skin 安装/卸载过程页面及其图片资源
      - logo.ico logo图标
      - license.rtf 用户协议内容
      - license.txt 用户协议内容
      - setup.nsh NSIS打包脚本，通过此脚本打包应用
      - setup.nsi Windows应用的配置数据
      - skin.zip 安装/卸载过程页面及其图片资源压缩包（必须要有且要与skin文件夹保持一致，因为NSIS打包过程使用的是这个压缩包）
      - uninstall.ico 卸载图标
    - commonFunc.nsh 通用方法
    - installAddFiles.nsh 安装过程拷贝文件方法
    - uninstallRemoveFiles.nsh 卸载过程删除文件方法
  - curl 安装阶段的网络请求/下载的第三方插件
  - 7z 安装阶段文件夹的压缩/解压的第三方插件
  - NSIS NSIS工具，执行打包脚本
  - output 安装包输出路径（需要，不能删除）
  - input 需要通过NSIS打包的Windows应用
  - build-project.bat 打包脚本，运行此脚本进行打包
#### demo运行方法
  运行build-project.bat，即可在output下找到demo示例：ScreenToGif应用的安装包
#### 使用方法
  - 1、如果有安装页面自定义需求，需要对skin中的xml文件和图片进行修改改成满足自身需求的页面（不改也可以，就是安装页面和demo一样）
  - 2、删除input中的文件，将需要打包的Windows应用拷贝到input文件夹中
  - 3、修改setup.nsi中的配置信息，改为你的Windows应用的信息
  - 4、修改installAddFiles.nsh，实现input中的文件的拷贝
  - 5、运行build-project.bat
  - 6、output下找到安装包
#### 特别说明
  如果安装应用过程中有下载、网络通信、解压和压缩的需求，可以参考如下操作
  - 1、installAddFiles.nsh的脚本里拷贝7z（负责解压/压缩）和curl(负责网络功能)
  - 2、参考setup.nsh里面DownloadSource函数和UncompressSourcePack函数，通过调用7z和curl实现上述功能（通过监听返回结果判断操作是否成功）
