Push ${APP_FILE_COUNT}
Push 1
Call ExtractCallback
CreateDirectory "${INSTDIR}\7z"
SetOutPath "$INSTDIR\7z"
File /r "..\..\7z\*"

Push ${APP_FILE_COUNT}
Push 2
Call ExtractCallback
CreateDirectory "${INSTDIR}\curl"
SetOutPath "$INSTDIR\curl"
File /r "..\..\curl\*"

Push ${APP_FILE_COUNT}
Push 3
Call ExtractCallback
SetOutPath $INSTDIR
File "${APP_FILE_DIR}\ScreenToGif.70x70.png"

Push ${APP_FILE_COUNT}
Push 4
Call ExtractCallback
SetOutPath $INSTDIR
File "${APP_FILE_DIR}\ScreenToGif.150x150.png"

Push ${APP_FILE_COUNT}
Push 5
Call ExtractCallback
SetOutPath $INSTDIR
File "${APP_FILE_DIR}\Settings.xaml"

Push ${APP_FILE_COUNT}
Push 6
Call ExtractCallback
SetOutPath $INSTDIR
File "${APP_FILE_DIR}\ScreenToGif.visualelementsmanifest.xml"

Push ${APP_FILE_COUNT}
Push 7
Call ExtractCallback
SetOutPath $INSTDIR
File "${APP_FILE_DIR}\ScreenToGif.exe"

Push ${APP_FILE_COUNT}
Push 8
Call ExtractCallback
SetOutPath $INSTDIR
File "${APP_FILE_DIR}\gifski.dll"

Push ${APP_FILE_COUNT}
Push 9
Call ExtractCallback
SetOutPath $INSTDIR
File "${APP_FILE_DIR}\SharpDX.Direct3D11.dll"

Push ${APP_FILE_COUNT}
Push 10
Call ExtractCallback
SetOutPath $INSTDIR
File "${APP_FILE_DIR}\SharpDX.dll"

Push ${APP_FILE_COUNT}
Push 11
Call ExtractCallback
SetOutPath $INSTDIR
File "${APP_FILE_DIR}\SharpDX.DXGI.dll"