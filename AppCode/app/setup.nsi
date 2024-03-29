# ====================== 自定义宏 产品信息==============================
!define PRODUCT_NAME               "ScreenToGif"
#产品描述
!define PRODUCT_DESCRIPTION               "ScreenToGif Description"
#安装卸载项用到的KEY
!define PRODUCT_PATHNAME       "ScreenToGif"
#安装路径追加的名称
!define INSTALL_APPEND_PATH         "ScreenToGif"
#执行文件名称（对应需要打包文件里面的执行文件）
!define EXE_NAME                   "ScreenToGif.exe"
#版本号
!define PRODUCT_VERSION            "1.0.0.0"
#主页地址
!define HOME_URL                "https://www.screentogif.com"
#用户条款
!define TERMS_URL                "https://www.screentogif.com"
#产品发布商
!define PRODUCT_PUBLISHER          "Nicke Manarin"
#产品法律
!define PRODUCT_LEGAL              "Copyright © 2024 Nicke Manarin"
#打包出来的文件名称
!define INSTALL_OUTPUT_NAME        "ScreenToGif-${PRODUCT_VERSION}.exe"
#应用程序的数据目录
!define LOCAL_APPDATA_DIR        "$APPDATA\ScreenToGif"
#打包文件目录
!define APP_FILE_DIR            "..\..\input"
#打包文件数量
#如果不需要下载资源则APP_FILE_COUNT应该与installAddFiles的文件数量相同，安装进度条能自动到达100%
#如果需要下载资源则APP_FILE_COUNT要大于installAddFiles的文件数量，使文件拷贝动作结束后进度条未达到100%，在下载和解压动作完成后手动将进度条设置为100%
!define APP_FILE_COUNT            11
#需下载资源包名称,
#需要下载资源时才能用到
!define SOURCE_PACK_NAME               "source.zip"
#安装过程日志信息上传地址
#需要下载资源时才能用到
!define LOG_URL                       "https://logUrl"

# ====================== 自定义宏 安装信息==============================
!define INSTALL_RES_PATH           "skin.zip"
!define INSTALL_LICENSE_FILENAME    "license.rtf"
!define INSTALL_ICO         "logo.ico"
!define UNINSTALL_ICO         "uninst.ico"

!include "setup.nsh"

# ==================== NSIS属性 ================================

# UAC权限请求.
# RequestExecutionLevel none|user|highest|admin
RequestExecutionLevel user

; 安装包名字.
Name "${PRODUCT_NAME}"

# 安装程序文件名.

OutFile "..\..\output\${INSTALL_OUTPUT_NAME}"

InstallDir "1"

# 安装和卸载程序图标
Icon              "${INSTALL_ICO}"
UninstallIcon     "${UNINSTALL_ICO}"
