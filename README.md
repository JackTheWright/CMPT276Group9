# TrackIT

TrackIT is a client/server iOS application desigend and built by Group 9 for CMPT 276 (Summer) at SFU.

Project website: [trackitdiet.com](https://www.trackitdiet.com)

## Project Dependencies
  - [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
  - [BlueSocket](https://github.com/IBM-Swift/BlueSocket)
  - [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)

## Table of Contents
  - [Project Structure Overview](#project-structure-overview)
  - [TrackIT Command Line Tools](#trackit-command-line-tools)

### Team Members
  - Jack Wright (Project Manager, Frontend Dev)
  - Keyi Huang (Database Manager, Backend Dev)
  - Jeremy Schwartz (Network Administrator, Backend Dev)
  - Siddharth Gupta (Researcher, Frontend Dev)
  - Xin Yuan Dong (QA, Frontend Dev)

## Project Structure Overview

The *TrackIT* project is divided into 3 smaller, isolated projects:
  - [NetConnect](#netconnect)
  - [TrackIT Client](#trackit-client)
  - [TrackIT Server](#trackit-server)
  
All of these projects are accessable from the `TrackIT.xcworkspace` Xcode workspace file. Work on any aspect of the project (except when working on NetConnect/TrackITServer from Linux) should be done from within this workspace file.

When going to build a project, ensure that correct project is selected in the build drop down menu as seen below. This will also ensure that error checking and syntax highlighting are working correctly for the project you are trying to work in.

![build menu](https://github.com/JackTheWright/CMPT276Group9/blob/master/common/img/Screen%20Shot%202018-06-03%20at%2014.29.43.png)

Remember that before building either TrackITClient or Server, the NetConnect library must be built. This can be done in Xcode by selecting the 'NetConnect' from the drop down menu and pressing `⌘ b` or pressing the play icon at the top left. This only needs to be done once after any changes are made to the NetConnect library. Though to be safe, this should be done after every pull from the repository.

When working in `TrackIT.xcworkspace` the project menu will look something like this:

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

### Building Sources

All source files for the NetConnect library are located in `TrackITServer/Sources/NetConnect/`. NetConnect may be built either by using Xcode, using the specific build scheme or using Swift Package Manager (SPM) using:

```
swift build
```

The result of this build sequence is a an importable swift framework.

### Unit Tests

To easily test aspects of the library, NetConnect contains unit tests which are located in `TrackITServer/Tests/NetConnectTests/`. These tests may be run in Xcode by going to `NetConnectTests.swift` and running the desired test by clicking the run icon at the specific line number, or, using SPM, by running:

```
swift test
```

When writing unit tests use the following `XCTest` library function to assert that test results are as expected.

``` swift
XCAssert(_ expression: Bool)
```

Also note that each test function must be named `test<something>` and, for the tests to run on Linux, must be added to the static `allTests` array located at bottom of `NetConnectTests.swift`

For example, if you wanted to ensure that encoding a decoding a message produced the same string then you could write a test like so.

``` swift
/// Test message encoding and decoding.
func testMessage() {
    // Wrap entire function in do-try-catch section to catch any exceptions thrown.
    do {
        let string = "Hello World"
        let message: Message = Message(body: string)
        
        // Ensure message was constructed correctly
        XCTAssert(message.body == message)
        
        let encodedMessage: Data = try message.encoded()
        guard let decodedMessage: Message = Message(decoding: encodedMessage) else {
            // If unable to decode, throw an exception.
            throw MessagingError.UnableToDecode
        }
        
        // Main check, ensure message boy is the same after encoding and decoding.
        XCTAssert(message.body == decodedMessage.body)
        
    } catch {
        // Test should fail if exception was thrown.
        XCTAssert(false)  // Always fails.
    }
}
```

## TrackIT Client

TrackITClient is the working name for the end user iOS application which is the primary focus of the entire TrackIT project. Since this is an iOS project, TrackITClient is not buildable on Linux.

**IMPORTANT: DO NOT DELETE OR EDIT THE NetConect DIRECTORY LOCATED IN THE TrackITClient PROJECT**

*More information to come once work has started on the app*

## TrackIT Server

As the server is designed to run on Linux, the project structure for this subproject is quite different. It does contain an Xcode project but the primary build system is Swift Package Manager (SPM). Building through Xcode is just like building the other subprojects; however, to build through SPM please use the following instructions.

### Where To Put Source Code

All source code for the server application (Not NetConnect) should go under `TrackITServer/Sources/Server/`. It is safe to add other directories under this directory to keep the project structure clean and tidy. For example, source code for a SQLite database management system could go under `TrackITServer/Sources/Server/SQL/`.

There is no need to add new source files to a makefile or anything like that as SPM takes care of compiling the executable.

The file `main.swift` located in `TrackITServer/Sources/Server/` is the entry point for the server application.

### Compiling

To compile both Server and NetConnect, run the following command from the `TrackITServer/` directory.
```
swift build
```

Or alternativly, if you would like to run the created server executable.
```
swift run
```

Once compiled the executable will be called `Server` and is located in `TrackITServer/.build/x86_64-apple-macosx10.10/` on macOS or under `TrackITServer/.build/x86_64-unknown-linux/` on Linux. Since this directory is quite long, one may simply use the `swift run` command to run the executable from the project root directory (`TrackITServer/`).

## TrackIT Command Line Tools

Along with the main project, a suite of unix command line tools have been created to help with building and maintaining the server aspect of the project.

To install the `trackit` tool, run the following command from the project root (normally `CMPT276Group9/`:

```
scripts/install_tools.sh
```

This will run the `install_tools.sh` bash script located in the `scripts/` directory. All the installation does is simply append a few lines to `~/.bashrc` which add the `scripts/` directory to the `$PATH` variable and defines a new variable: `$TRACKIT_ROOT` which contains the path to the project root directory, wherever it is located on your system.

Once this script is run, you may then use the following commands from any directory.

Note that each command may be appended with `-v` to run the command in verbose mode (produce more output to the screen)

To build the server executable:
```
trackit build
```

To build and run the server executable:
```
trackit run
```

To run unit tests:
```
trackit test
```

To clean the build files:
```
trackit clean
```

*More commands will be added latter to handle things like viewing server logs, starting and stoping the server service, etc.*
