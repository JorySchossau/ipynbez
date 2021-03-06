###Edit 2016 Feb:
In case anyone still finds this page, just use [miniconda](http://conda.pydata.org/miniconda.html). I've been using it for a couple years now on various OSs and it's great.


## About

IPython Notebook can be difficult to install. This installer automates much of the process so you can focus on _using_ IPython Notebook instead of getting IPython Notebook working. Because IPython Notebook is being furiously actively developed then many people wish to stay up to date with the latest development release. This tool helps you do exactly that.

This is a quick stop-gap tool to help mass installations for IPython Notebook beginners attending on-site courses.

## Install and Use

### Windows (XP/7)
Download [ipynbez.exe](https://raw.github.com/JorySchossau/ipynbez/master/windows/ipynbez.exe) and run it using an account that has installation privileges.
The installer will create a file called `IPyNotebook` on your Desktop. Double click to start, Control-C to end the server. Optionally, move this shortcut to a folder you want to use for your Notebooks to make those files available to IPython Notebook.

### Mac
_Coming soon._

### Linux
_Coming soon._   
Download [ipynbez.sh]() and run it from the command line.
```bash
./ipynbez.sh
```

## Details

IPython Notebook Easy Installer automates two functions: [Downloading](https://github.com/JorySchossau/ipynbez#downloading) and [Installing](https://github.com/JorySchossau/ipynbez#installing) required files to get IPython Notebook up and running.

### Downloading
This tool automatically downloads the following, depending on your operating system:
* [Enthought Python Distribution (Free Version)](http://www.enthought.com/products/epd_free.php): for installing a python environment
  * [MatPlotLib](http://matplotlib.org/): updating the one in EPD for compatibility with the latest Notebook
  * [Numpy](http://www.numpy.org/): updating the default EPD for compatibility with the latest Notebook
  * [Pandas](http://pandas.pydata.org/): for data analysis in IPython Notebook
* [Git for Windows](http://msysgit.github.com/): for downloading the latest IPython
  * [PeaZip](http://code.google.com/p/peazip/): for unzipping Git for Windows
* [IPython](http://ipython.org/): for updating IPython (notebook) to the latest Development release

### Installing
This tool automatically installs the following, depending on your operating system:
* [Enthought Python Distribution (Free Version)](http://www.enthought.com/products/epd_free.php): for a python environment
  * [MatPlotLib](http://matplotlib.org/): For Notebook compatibility
  * [Numpy](http://www.numpy.org/): For Notebook compatilibity
  * [Pandas](http://pandas.pydata.org/): for data analysis in IPython Notebook
* [IPython](http://ipython.org/): for updating IPython (notebook) to the latest Development release
* A shortcut IPyNotebook: starts the Notebook server in the current directory

## Tips

### Blank browser problem
Try a different browser, or try updating your browser. Browsers to try: [Mozilla Firefox](http://www.mozilla.org/en-US/firefox/new/), [Google Chrome](https://www.google.com/intl/en/chrome/browser/), or [Safari](http://support.apple.com/kb/DL1531).

## Known Problems

* Windows(XP/7) Running ipynbez.exe from your browser's download manager causes the program to run strangely. Symptoms: Incomplete installation, or lack of Desktop shortcut IPyNotebook.

==================
#### Authorship
* Made by Jory Schossau
* [GPLv3](http://www.gnu.org/licenses/quick-guide-gplv3.html)
* Icon from Python project
