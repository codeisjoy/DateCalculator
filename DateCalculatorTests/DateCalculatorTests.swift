//
//  DateCalculatorTests.swift
//  DateCalculatorTests
//
//  Created by Emad A. on 22/03/2016.
//  Copyright © 2016 BCG Digital Ventures. All rights reserved.
//

import XCTest

class DateCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCase1() {
        do {
            let d = try diff(from: "2/6/1983", until: "22/6/1983")
            XCTAssertTrue(d == 19)
        }
        catch {
            XCTFail("Invalid dates")
        }
    }
    
    func testCase2() {
        do {
            let d = try diff(from: "4/7/1984", until: "25/12/1984")
            XCTAssertTrue(d == 173)
        }
        catch {
            XCTFail("Invalid dates")
        }
    }
    
    func testCase3() {
        do {
            let d = try diff(from: "3/1/1989", until: "3/8/1983")
            XCTAssertTrue(d == 1979)
        }
        catch {
            XCTFail("Invalid dates")
        }
    }
    
    func testLeapYear() {
        // We know that 2015 is not a leap year so Feb has 28 days.
        XCTAssertThrowsError(try diff(from: "29/02/2015", until: "1/1/2018"))
    }
}
