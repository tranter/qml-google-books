# Introduction #

Information about use Google API, testing platforms, Qt versions.

# Details #

Project **qml-google-maps** uses Google Books API. Project contains 2 subprojects - version for **meego** and version for **symbian**.

### Google API ###

Project **qml-google-books** uses Google Books API.

How it works:
Work with Google-API perfomed by send **XMLHttpRequest** (see file **books\_data\_manager.js**)

API features used in this project:
|get bookshelves|
|:--------------|
|get volumes|
|add volume, remove volume and clear all volumes from bookshelves|
|find books by title and author|
|view book|

File **[HowToRegisterYourAppIicationInGoogle](http://code.google.com/p/qml-google-books/wiki/HowToRegisterYourApplicationInGoogle)** describes how register your own application on Google.

### Tested platforms ###
Both subproject were tested on:
| **OS** | **Qt version** |
|:-------|:---------------|
|Windows 7 64bit/32bit in simulator|Qt 4.7.4 (QtSDK 1.2.1)|
|Arch Linux 64bit in simulator|Qt 4.7.4 (QtSDK 1.2.1)|

**Symbian** subproject was tested on:
| **Phone** | **Qt version** |
|:----------|:---------------|
|C7 Nokia|---|
|N8 Nokia|---|

You can download package for symbian from [Downloads](http://code.google.com/p/qml-google-books/downloads/list) tab ([qml-google-books-symbian.sis](http://qml-google-books.googlecode.com/files/qml-google-books-symbian.sis)).

**MeeGo** subproject was tested on:
| **Phone** | **Qt version** |
|:----------|:---------------|
|N9 Nokia|---|


# Various comments #
1. **Caution!** In version for symbian maybe you need replace string "import com.nokia.symbian 1.0" to string "import com.nokia.symbian 1.1" (or backwards) in qml-files depending on version QtSDK.

2. You need to install Qt and qt-components on your phone.