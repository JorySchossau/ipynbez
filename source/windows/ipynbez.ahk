;; test script for IPyN easy install

Unz(sZip, sUnz)
{
;; source http://www.autohotkey.com/board/topic/60706-native-zip-and-unzip-xpvista7-ahk-l/
    ;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
    fso := ComObjCreate("Scripting.FileSystemObject")
    If Not fso.FolderExists(sUnz)  ;http://www.autohotkey.com/forum/viewtopic.php?p=402574
       fso.CreateFolder(sUnz)
    psh  := ComObjCreate("Shell.Application")
    zippedItems := psh.Namespace( sZip ).items().count
    psh.Namespace( sUnz ).CopyHere( psh.Namespace( sZip ).items, 4|16 )
}

#NoTrayIcon
SetBatchLines, -1  ; Make the operation run at maximum speed.
datadir=%A_ScriptDir%\ipynbez_data

MsgBox, 4, IPython Notebook Easy Installer, Proceed with Installation?`n`nPlease ensure you have no installation at C:\Python27.`nPlease ensure you have installation privileges.
IfMsgBox No
    Exit

IfNotExist, %datadir%
{
    FileCreateDir, %datadir%
}

progressMain=Performing Installation
progressTitle=IPython Notebook Easy Installer
totalSteps=11

Progress,0,(Gathering Install Information...),,%progressTitle%
UrlDownloadToFile, https://raw.github.com/JorySchossau/ipynbez/master/latest.update, %datadir%\latest.update

IfNotExist, %datadir%\latest.update
{
    Progress, Off
    MsgBox,,Error,Could not connect to GitHub.`nPlease check your internet connection and try again.
    ExitApp
}
FileRead, contents, %datadir%\latest.update
if ErrorLevel
{
    Progress, Off
    MsgBox,,Error,Could not connect to GitHub.`nPlease check your internet connection and try again.
    ExitApp
}
firstline:=SubStr(contents, 1, 13)
if (firstline != "ServerVersion")
{
    Progress, Off
    MsgBox,,Error,Unable to connect to GitHub.`nPlease check your internet connection and try again.
    ExitApp
}
Progress, Off
find_serverVersion:="im)ServerVersion=(\S*)"
find_epdVersion:="im)EpdVersion=(\S+)"
find_peazipVersion:="im)WinPeazipVersion=(\S*)"
find_gitFileName:="im)WinGitFileName=(\S*)"
find_epdSize:="im)WinEpdSize=(\S*)"
find_ipythonSize:="im)WinIPythonSize=(\S*)"
find_gitPortableSize:="im)WinGitPortableSize=(\S*)"
RegExMatch(contents, find_serverVersion, Match)
serverVersion:=Match1
RegExMatch(contents, find_epdVersion, Match)
epdVersion:=Match1
RegExMatch(contents, find_peazipVersion, Match)
peazipVersion:=Match1
RegExMatch(contents, find_gitFileName, Match)
gitFileName:=Match1
RegExMatch(contents, find_epdSize, Match)
epdSize:=Match1
RegExMatch(contents, find_ipythonSize, Match)
ipythonSize:=Match1
RegExMatch(contents, find_gitPortableSize, Match)
gitPortableSize:=Match1

thisVersion=1.0
peazipFileName=peazip_portable-%peazipVersion%.WINDOWS

if (serverVersion > thisVersion)
{
    MsgBox,260,New Version Available,Would you like to update?
    IfMsgBox Yes
    {
        Run https://github.com/JorySchossau/ipynbez
        ExitApp
    }
}

DownloadProgressEPD(pthis, nProgress = 0, nProgressMax = 0, nStatusCode = 0, pStatusText = 0)
{
    If A_EventInfo = 6
    Progress, % p := 100 * nProgress//nProgressMax, (Downloading Enthought Python...),, IPython Notebook Easy Installer
    Return 0
}

DownloadProgressPeaZip(pthis, nProgress = 0, nProgressMax = 0, nStatusCode = 0, pStatusText = 0)
{
    If A_EventInfo = 6
    Progress, % p := 100 * nProgress//nProgressMax, (Downloading PeaZip...),, IPython Notebook Easy Installer
    Return 0
}

DownloadProgressGit(pthis, nProgress = 0, nProgressMax = 0, nStatusCode = 0, pStatusText = 0)
{
    If A_EventInfo = 6
    Progress, % p := 100 * nProgress//nProgressMax, (Downloading Git for Windows...),, IPython Notebook Easy Installer
    Return 0
}

DownloadFromURL(sUrl, sFile, callback, caption)
{
    Progress, % "M W" . A_ScreenWidth//3, %caption%,, IPython Notebook Easy Installer
    VarSetCapacity(vt, A_PtrSize*11), nParam = 31132253353
    Loop, Parse, nParam
        NumPut(RegisterCallback(callback, "Fast", A_LoopField, A_Index-1), vt, A_PtrSize*(A_Index-1))
    DllCall("urlmon\URLDownloadToFile", "Uint", 0, "str", sUrl, "str", sFile, "Uint", 0, "UintP", &vt)
}

IfNotExist, C:\Python27
{
    Progress, 0, (Downloading Enthought Python...), %progressMain% (1/%totalSteps%), %progressTitle%
    IfNotExist, %datadir%\epd_free.msi
    {
        sUrl  := "http://epd-free.enthought.com/epd_free-" . epdVersion . "-win-x86.msi"
        sFile := datadir . "\epd_free.msi"
        Progress, Off
        DownloadFromURL(sUrl, sFile, "DownloadProgressEPD", "(Downloading Enthought Python...)")
        Progress, Off
    }
    Progress, Off

    ;; begin EPD installation
    Progress, 0, (Installing Enthought Python...), %progressMain% (2/%totalSteps%), %progressTitle%
    epd_free_pid:=0
    Run, msiexec /i epd_free.msi /quiet, %datadir%,, epd_free_pid

    ;; wait for Python EPD directory to be created
    foundDir = 0
    while %foundDir% == 0
    {
        if InStr(FileExist("C:\Python27"), "D")
        {
            foundDir = 1
        }
        Sleep, 500
    }

    ;; progress bar based on EPD directory size
    FolderSize = 0
    ProcessRunning = 1
    While (ProcessRunning)
    {
        FolderSize = 0
        Loop, C:\Python27\*.*, , 1
            FolderSize += %A_LoopFileSize%
        epdprogress := FolderSize*100/epdsize
        Progress, %epdprogress%, (Installing Enthought Python...), %progressMain% (2/%totalSteps%), %progressTitle%
        Process, Exist, %epd_free_pid%
        if ErrorLevel = 0
        {
            ProcessRunning = 0
            break
        }
        Sleep, 2000
    }
}

IfExist, C:\Python27
{
    IfNotExist, C:\Python27\Scripts\ipython.bat
    {
        MsgBox,, Error, A Python distribution was found at C:\Python27`nbut it doesn't contain the newer IPython. Please remove that`ndistribution first then try again. Also make sure you are running this installer with installation privileges.
        ExitApp
    }
    IfNotExist, C:\Python27\python.exe
    {
        MsgBox,, Error, A partial Python installation was found at C:\Python27`nPlease remove this installation and try again.
        ExitApp
    }
}
else
{
    MsgBox,, Error, Python could not be installed. Do you already have an installation? Do you have installation privileges?
    ExitApp
}

;; Upgrade Matplotlib
Progress, 10, (Upgrading MatPlotLib...), %progressMain% (3/%totalSteps%), %progressTitle%
RunWait, cmd /c C:\Python27\Scripts\enpkg.exe matplotlib ;,,Hide

;; Install Pandas
Progress, 20, (Installing Pandas Lib...), %progressMain% (4/%totalSteps%), %progressTitle%
RunWait, cmd /c C:\Python27\Scripts\enpkg.exe pandas ;,,Hide

;; download PeaZip
Progress, 30, (Downloading PeaZip...), %progressMain% (5/%totalSteps%), %progressTitle%
IfNotExist, %datadir%\gitPortable
{
    ;sUrl  := "http://sourceforge.net/projects/peazip/files/" . peazipVersion . "/" . peazipFileName . "zip/download?use_mirror=autoselect"
    sFile := datadir . "\peazipPortable.zip"
    sUrl := "http://peazip.googlecode.com/files/peazip_portable-" . peazipVersion . ".WINDOWS.zip"
    IfNotExist, %datadir%\peazipPortable.zip
    {
        ;UrlDownloadToFile, http://sourceforge.net/projects/peazip/files/%peazipVersion%/%peazipFileName%.zip/download?use_mirror=autoselect, %datadir%\peazipPortable.zip
        Progress, Off
        DownloadFromURL(sUrl, sFile, "DownloadProgressPeaZip", "(Downloading PeaZip...)")
        Progress, Off
    }
    IfNotExist, %datadir%\peazipPortable.zip
    {
        MsgBox,, Error, Couldn't download PeaZip from the following URL:`n%sUrl%
        ExitApp
    }
    Progress, 40, (Downloading Git for Windows...), %progressMain% (6/%totalSteps%), %progressTitle%
    sUrl:="http://msysgit.googlecode.com/files/" . gitFileName . ".7z"
    sFile:=datadir . "\gitPortable.7z"
    IfNotExist, %datadir%\gitPortable.7z
    {
        ;UrlDownloadToFile, http://msysgit.googlecode.com/files/%gitFileName%.7z, %datadir%\gitPortable.7z
        Progress, Off
        DownloadFromURL(sUrl, sFile, "DownloadProgressGit", "(Downloading Git for Windows...)")
        Progress, Off
    }
    IfNotExist, %datadir%\gitPortable.7z
    {
        MsgBox,, Error, Couldn't download git for windows from the following URL:`n%sUrl%
        ExitApp
    }

    Progress, 50, (Extracting PeaZip...), %progressMain% (7/%totalSteps%), %progressTitle%
    ;; extract peazipPortable.zip
    sZip := datadir . "\peazipPortable.zip"  ;Zip file to be created
    sUnz := datadir     ;Directory to unzip files

    IfNotExist, %datadir%\%peazipFileName%
    {
        Unz(sZip,sUnz) ;perform file extraction
    }
    IfNotExist, %datadir%\%peazipFileName%
    {
        MsgBox,, Error, "Extraction of PeaZip failed."
        ExitApp
    }

    Progress, 60, (Extracting Git for Windows...), %progressMain% (8/%totalSteps%), %progressTitle%
    ;; extract gitPortable.7z
    IfNotExist, %datadir%\gitPortable
    {
        sevenzip_pid:=0
        Run, %peazipFileName%\res\7z\7z.exe x gitPortable.7z -ogitPortable, %datadir%, Hide, sevenzip_pid

        ;; wait for sevenzip directory to be created
        foundDir = 0
        while %foundDir% == 0
        {
            if InStr(FileExist(datadir . "\gitPortable"), "D")
            {
                foundDir = 1
            }
            Sleep, 500
        }

        ;; progress bar based on gitPortable directory size
        FolderSize = 0
        ProcessRunning = 1
        While (ProcessRunning)
        {
            FolderSize = 0
            Loop, %datadir%\gitPortable\*.*, , 1
                FolderSize += %A_LoopFileSize%
            gitprogress := FolderSize*100/gitPortableSize
            Progress, %gitprogress%, (Extracting Git for Windows...), %progressMain% (8/%totalSteps%), %progressTitle%
            Process, Exist, %sevenzip_pid%
            if ErrorLevel = 0
            {
                ProcessRunning = 0
                break
            }
            Sleep, 2000
        }
    }
}
IfNotExist, %datadir%\gitPortable\git-bash.bat
{
    MsgBox,, Error, Extracting Git for Windows failed.
    ExitApp
}
Progress, 70, (Downloading IPython Notebook...), %progressMain% (9/%totalSteps%), %progressTitle%
;; download latest ipython
IfNotExist, %datadir%\gitPortable\ipython
{
    git_pid:=0
    ;RunWait, cmd /c; echo git clone git://github.com/ipython/ipython.git | git-bash.bat, %datadir%\gitPortable, Hide
    Run, cmd /c; echo git clone git://github.com/ipython/ipython.git | git-bash.bat, %datadir%\gitPortable, Hide, git_pid

    ;; wait for ipython directory to be created
    foundDir = 0
    while %foundDir% == 0
    {
        if InStr(FileExist(datadir . "\gitPortable\ipython"), "D")
        {
            foundDir = 1
        }
        Sleep, 500
    }

    ;; progress bar based on ipython directory size
    FolderSize = 0
    ProcessRunning = 1
    While (ProcessRunning)
    {
        FolderSize = 0
        Loop, %datadir%\gitPortable\ipython\*.*, , 1
            FolderSize += %A_LoopFileSize%
        ipythonprogress := FolderSize*100/ipythonSize
        Progress, %ipythonprogress%, (Downloading IPython Notebook...), %progressMain% (9/%totalSteps%), %progressTitle%
        Process, Exist, %git_pid%
        if ErrorLevel = 0
        {
            ProcessRunning = 0
            break
        }
        Sleep, 2000
    }
}

;; build and install latest ipython
Progress, 80, (Building IPython Notebook...), %progressMain% (10/%totalSteps%), %progressTitle%
RunWait, C:\Python27\python.exe setup.py build, %datadir%\gitPortable\ipython, Hide
Progress, 90, (Installing IPython Notebook...), %progressMain% (11/%totalSteps%), %progressTitle%
RunWait, C:\Python27\python.exe setup.py install, %datadir%\gitPortable\ipython, Hide
Progress, 100, (Creating Shortcut...), %progressMain% (12/%totalSteps%), %progressTitle%
shortcutFileName=IPyNotebook.lnk
IfNotExist, %shortcutFileName%
{
    FileCreateShortcut, C:\Python27\Scripts\ipython.exe, %shortcutFileName%, `%CD`%, notebook --pylab inline, Launches IPython Notebook using the current working directory for notebook files, C:\Python27\python.exe
    Sleep, 200
}
Progress, Off

MsgBox,, %progressTitle%, IPython Notebook Installed!`nUse the shortcut IPyNotebook that has been created.`nYou may delete the downloaded files folder: ipynbez_data.
Exit