# YaST Widget Demo

This repository is a demo for most of the widgets provided by the YaST user
interface.

The main purpose is to provide an easily accessible sample of the widgets for
editing Qt widget style sheets.



## Building and Installing

- Make sure the `yast-rake` Ruby gem for your ruby version is installed
  (`ruby2.7-rubygem-yast-rake` at the time of this writing):

      sudo zypper install "ruby*-rubygem-yast-rake"

- Install:

      sudo rake install



## How to Run

- Graphical (Qt) version:

      yast2 widget_demo

- Text-based (NCurses) version:

      yast widget_demo


No root privileges are required in either case.


## Reference

- [Qt widget style sheet reference](https://doc.qt.io/qt-5/stylesheet-reference.html)

- [YaST QSS for SLE](https://github.com/yast/yast-theme/blob/master/theme/SLE/wizard/installation.qss)

- [YaST QSS for openSUSE Leap 15.3](https://github.com/openSUSE/branding/blob/leap-15.3/yast/installation.qss)

  (switch to another branch in that repository for the theme of a different
  openSUSE distribution)

- [YaST UI reference documentation](https://doc.opensuse.org/projects/YaST/openSUSE11.3/tdg/Book-UIReference.html)

- [YaST documentation](https://yastgithubio.readthedocs.io/en/latest/) at readthedocs.io
