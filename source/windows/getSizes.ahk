#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FolderGetSize(folderPath)
{
	FolderSize=0
	Loop, %folderPath%\*.*, , 1
		FolderSize += %A_LoopFileSize%
	return FolderSize
}

;size:=FolderGetSize("ipynbez_data\gitPortable\ipython")
;sizec:=53597871
;MsgBox, ipython folder: %size%

;size:=FolderGetSize("ipynbez_data\gitPortable")
;sizec:=232451093
;MsgBox, gitPortable folder: %size%

FileGetSize, size, ipynbez_data\epd_free.msi
sizec:=93617152
MsgBox, epd_free.msi: %size%

size:=FolderGetSize("C:\Python27")
sizec:=0
MsgBox, Python27 folder: %size%

FileGetSize, size, ipynbez_data\gitPortable.7z
sizec:=21082713
MsgBox, gitPortable.7z: %size%

FileGetSize, size, ipynbez_data\peazipPortable.zip
sizec:=7297569
MsgBox, peazipPortable.zip: %size%