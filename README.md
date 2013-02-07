## About

IPython Notebook can be difficult to install. This installer automates much of the process so you can focus on _using_ IPython Notebook instead of getting IPython Notebook working.

This was originally intended as a tool to help mass installations for IPython Notebook beginners attending on-site courses.

## Install and Use

Download the version appropriate for your computer. Follow the instructions.

### Windows (XP/7)
Download [ipynbez.exe]() and run it using an account that has installation privileges.
The installer will create a file called `IPyNBServer.bat`. Double click to start, Control-C to end the server. Optionally, move this shortcut to a folder you want to use for your Notebooks to make those files available to IPython Notebook.

### Mac
_Coming soon._

### Linux
Download [ipynbez.sh]() and run it from the command line.
```bash
./ipynbez.sh
```
Follow the instructions.

## Details

IPython Notebook Easy Installer automates two functions: [Downloading](https://github.com/JorySchossau/ipynbez#downloading) and [Installing](https://github.com/JorySchossau/ipynbez#installing) required files to get IPython Notebook up and running.

### Downloading
This tool automatically downloads the following, depending on your operating system:
* [Enthought Python Distribution (Free Version)](http://www.enthought.com/products/epd_free.php): for installing a python environment
  * [MatPlotLib](http://matplotlib.org/): updating the one in EPD for compatibility with the latest Notebook
* [Git for Windows](http://msysgit.github.com/): for downloading the latest IPython
  * [PeaZip](http://code.google.com/p/peazip/): for unzipping Git for Windows

### Installing
This tool automatically installs the following, depending on your operating system:
* [Enthought Python Distribution (Free Version)](http://www.enthought.com/products/epd_free.php): for a python environment
  * [MatPlotLib](http://matplotlib.org/): For Notebook compatibility
* A shortcut IPyNBServer.bat: starts the Notebook server in the current directory

==================
#### Authorship
* Made by Jory Schossau
* [GPLv3](http://www.gnu.org/licenses/quick-guide-gplv3.html)
