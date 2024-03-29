#判断最后一段，如果已经是与我要追加的目录名一样，就不再追加了，如果不一样，则还需要追加 同时记录好写入注册表的路径    
Function AdjustInstallPath
  nsNiuniuSkin::StringHelper "$0" "\" "" "trimright"
  pop $0
  nsNiuniuSkin::StringHelper "$0" "\" "" "getrightbychar"
  pop $1
  
  ${If} "$1" == "${INSTALL_APPEND_PATH}"
    StrCpy $INSTDIR "$0"
  ${Else}
    StrCpy $INSTDIR "$0\${INSTALL_APPEND_PATH}"
  ${EndIf}
FunctionEnd

#判断选定的安装路径是否合法，主要检测硬盘是否存在[只能是HDD]，路径是否包含非法字符 结果保存在$R5中 
Function IsSetupPathIlleagal
  ${GetRoot} "$INSTDIR" $R3   ;获取安装根目录
  StrCpy $R0 "$R3\"
  StrCpy $R1 "invalid"
  StrCpy $0 ""
  ${GetDrives} "HDD" "HDDDetection"            ;获取将要安装的根目录磁盘类型
  ${If} $R1 == "HDD"              ;是硬盘
    StrCpy $R5 "1"
    ${DriveSpace} "$R3\" "/D=F /S=M" $R0           #获取指定盘符的剩余可用空间，/D=F剩余空间， /S=M单位兆字节  
    ${If} $R0 < 1024                               #即程序安装后需要占用的实际空间，单位：MB  
        StrCpy $R5 "-1"    #表示空间不足 
      ${endif}
  ${Else}
      #0表示不合法 
    StrCpy $R5 "0"
  ${endif}
FunctionEnd

Function HDDDetection
  ${If} "$R0" == "$9"
    StrCpy $R1 "HDD"
    StrCpy $0 "StopGetDrives"
  ${Endif}
  Push $0
FunctionEnd

#获取默认的安装路径
Function GenerateSetupAddress
  #读取注册表安装路径 
  ; 在32位系统和64位系统上都使用相应的注册表视图
  ${If} ${RunningX64}
    SetRegView 64
  ${Else}
    SetRegView 32
  ${EndIf}
  ReadRegStr $0 HKCU "Software\${PRODUCT_PATHNAME}" "InstPath"
  ${If} "$0" != ""    #路径不存在，则重新选择路径
    #路径读取到了，直接使用 
    #再判断一下这个路径是否有效 
    nsNiuniuSkin::StringHelper "$0" "\\" "\" "replace"
    Pop $0
    StrCpy $INSTDIR "$0"
  ${EndIf}
  #如果从注册表读的地址非法，则还需要写上默认地址
  Call IsSetupPathIlleagal
  ${If} $R5 == "0"
    StrCpy $INSTDIR "C:\${INSTALL_APPEND_PATH}"
  ${EndIf}
FunctionEnd

# 生成卸载入口
Function CreateUninstall
  ; 在32位系统和64位系统上都使用相应的注册表视图
  ${If} ${RunningX64}
    SetRegView 64
  ${Else}
    SetRegView 32
  ${EndIf}
  #写入注册信息
  WriteRegStr HKCU "Software\${PRODUCT_PATHNAME}" "InstPath" "$INSTDIR"
  WriteUninstaller "$INSTDIR\uninst.exe"
  # 添加卸载信息到控制面板
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_PATHNAME}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_PATHNAME}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_PATHNAME}" "DisplayIcon" "$INSTDIR\${EXE_NAME}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_PATHNAME}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_PATHNAME}" "DisplayVersion" "${PRODUCT_VERSION}"
FunctionEnd

# ========================= 安装步骤 ===============================
Function CreateAppShortcut
  ; 管理员模式需要如此设置
  ; SetShellVarContext all
  ; 普通模式需要如此设置
  SetShellVarContext current
  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${EXE_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\卸载${PRODUCT_NAME}.lnk" "$INSTDIR\uninst.exe"
  SetShellVarContext current
FunctionEnd

Function un.DeleteShotcutAndInstallInfo
  ; 在32位系统和64位系统上都使用相应的注册表视图
  ${If} ${RunningX64}
    SetRegView 64
  ${Else}
    SetRegView 32
  ${EndIf}
  DeleteRegKey HKCU "Software\${PRODUCT_PATHNAME}"
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_PATHNAME}"
  ; 删除快捷方式
  ; 管理员模式需要如此设置
  ; SetShellVarContext all
  ; 普通模式需要如此设置
  SetShellVarContext current
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\卸载${PRODUCT_NAME}.lnk"
  RMDir "$SMPROGRAMS\${PRODUCT_NAME}\"
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  #删除开机启动
  Delete "$SMSTARTUP\${PRODUCT_NAME}.lnk"
  SetShellVarContext current
FunctionEnd

; 打开链接
!define OpenURL '!insertmacro "_OpenURL"'

; 打开链接
!macro _OpenURL URL
  Push "${URL}"
  Call openLinkNewWindow
!macroend

; 新窗口打开链接
Function openLinkNewWindow
  Push $3
  Exch
  Push $2
  Exch
  Push $1
  Exch
  Push $0
  Exch
  ReadRegStr $0 HKCR "http\shell\open\command" ""
  # Get browser path
  DetailPrint $0
  StrCpy $2 '"'
  StrCpy $1 $0 1
  StrCmp $1 $2 +2 # if path is not enclosed in " look for space as final char
  StrCpy $2 ' '
  StrCpy $3 1
  loop:
    StrCpy $1 $0 1 $3
    DetailPrint $1
    StrCmp $1 $2 found
    StrCmp $1 "" found
    IntOp $3 $3 + 1
    Goto loop
  found:
    StrCpy $1 $0 $3
    StrCmp $2 " " +2
    StrCpy $1 '$1"'
  Pop $0
  Exec '$1 $0'
  Pop $0
  Pop $1
  Pop $2
  Pop $3
FunctionEnd

; 判断资源包是否已安装
#需要下载资源时才能用到
Function GetSourceState
  Push $0
  IfFileExists "$INSTDIR\extraResources\uncompress.json" sourceExists sourceNotExist
  sourceExists:
    StrCpy $0 "exist"
    Goto end
  sourceNotExist:
    StrCpy $0 "noExist"
  end:
    Exch $0
FunctionEnd
