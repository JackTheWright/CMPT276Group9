# TrackIT

## Table of Contents
- [Structure Overview](#structure-overview)
- [NetConnect](#netconnet)
- [TrackIT Client](#trackit-client)
- [TrackIT Server](#trackit-server)

## Structure Overview

The *TrackIT* project is divided into 3 smaller, isolated projects:
  - [TrackIT Client](#trackit-client)
  - [TrackIT Server](#trackit-server)
  - [NetConnect](#netconnect)
  
All of these projects are accessable from the `TrackIT.xcworkspace` Xcode workspace file. Work on any aspect of the project (except when working on NetConnect/TrackITServer from Linux) should be done from within this workspace file.

When going to build a project ensuer that correct project is selected in the build drop down menu as seen below.

![build menu](https://github.com/JackTheWright/CMPT276Group9/blob/master/common/img/Screen%20Shot%202018-06-03%20at%2014.29.43.png)

Remember that before building either TrackITClient or Server, the NetConnect library must be built. This can be done in Xcode by selecting the 'NetConnect' from the drop down menu and pressing `⌘ b` or pressing the play icon at the top left. This only needs to be done once after any changes are made to the NetConnect library. Though to be safe, this should be done after every pull from the repository.

When working in `TrackIT.xcworkspace` the project menue will look something like this:

![proj menu](https://github.com/JackTheWright/CMPT276Group9/blob/master/common/img/Screen%20Shot%202018-06-03%20at%2014.30.40.png)

The two XCode projects, `TrackITClient` and `Server` represent the two executable application that make up the TrackIT application. TrackITClient contains the end user iOS application, whereas Server contains the backend application along with the NetConnect libray. Within the TrackITClient project, there is a blue NetConnect reference folder, **this folder and its contents should not be edited in any way** as it is what provides the vital link to the NetConnect library for the client project.

## NetConnect

NetConnect is a custom networking API built specifically for this project. It wraps around IBM's [Blue Socket](https://github.com/IBM-Swift/BlueSocket) framework to provide an easy and secure way to send data to other devices over the internet.

### Usage

To use NetConnect, simply add the following import statement at the top of any source file within either two of the other subprojects (Server or TrackITClient).
``` swift
import NetConnect
```

*Once the framework has been completed, usage instructions will be added here*

## TrackIT Client

TrackITClient is the working name for the end user iOS application which is the primary focus of the entire TrackIT project.

For obvious reasons, this subproject is the only aspect of TrackIT that is not buildable on Linux.

## TrackIT Server

As the server is designed to run on Linux, the project structure for this subproject is quite different. It does contain an Xcode project but the primary build system is Swift Package Manager (SPM). Building through Xcode is just like building the other subprojects; however, to build through SPM please use the following instructions.

### Where To Put Source Code

All source code for the server application (Not NetConnect) should go under `TrackITServer/Sources/Server/`. It is safe to add other directories under this directory to keep the project structure clean and tidy. For example, source code for a SQLite database management system could go under `TrackITServer/Sources/Server/SQL/`.

There is no need to add new source files to a makefile or anything like that as SPM takes care of compiling the executable.

The file `main.swift` located in `TrackITServer/Sources/Server/` is the entry point for the server application.

### Compiling

To compile both Server and NetConnect, run the following command from the `TrackITServer/` directory.
``` bash
swift build
```

Or alternativly, if you would like to run the created server executable.
``` bash
swift run
```

Once compiled the executable will be called `Server` and is located in `TrackITServer/.build/x86_64-apple-macosx10.10/` on macOS or under `TrackITServer/.build/x86_64-unknown-linux/` on Linux. Since this directory is quite long, one may simply use the `swift run` command to run the executable from the project root directory (`TrackITServer/`).
