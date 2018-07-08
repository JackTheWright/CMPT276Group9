import XCTest

import NetConnectTests
import ServerTests

var tests = [XCTestCaseEntry]()
tests += NetConnectTests.allTests()
XCTMain(tests)

