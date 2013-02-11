#z::
;UrlDownloadToFile, http://epd-free.enthought.com/epd_free-7.3-2-win-x86.msi, epd_free-7.3-2-win-x86.msi
epdsize = 368325429
epdprogress_title = Installing EPD...
epdprogress_main = Enthought Python Distribution
epdprogress_sub = Please wait during installation.
epdprogress = 0
;Progress, 0, %epdprogress_sub%, %epdprogress_main%, %epdprogress_title%
SetBatchLines, -1  ; Make the operation run at maximum speed.

Run, msiexec /i epd_free-7.3-2-win-x86.msi /quiet

foundDir = 0
while %foundDir% == 0
{
	if InStr(FileExist("C:\Python27"), "D")
	{
		foundDir = 1
	}
	Sleep, 500
}

FolderSize = 0

While (FolderSize < epdsize)
{
	FolderSize = 0
	Loop, C:\Python27\*.*, , 1
		FolderSize += %A_LoopFileSize%
	epdprogress := FolderSize*100/epdsize
	Progress, %epdprogress%, %epdprogress_sub%, %epdprogress_main%, %epdprogress_title% %epdprogress%
	Sleep, 2000
	;MsgBox, (%FolderSize% < %epdsize%) %FolderSize% < %epdsize%
}

Progress, Off

; use enpkg to install pandas: RunWait, C:\Python27\Scripts\enpkg.exe pandas
; Download Git-for-windows
; unzip git-for-win
; run custom command to download ipython
; build and install new ipython

MsgBox, Finished