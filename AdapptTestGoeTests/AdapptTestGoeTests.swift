//
//  AdapptTestGoeTests.swift
//  AdapptTestGoeTests
//
//  Created by Ahmed on 13/12/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import XCTest
@testable import AdapptTestGoe

class AdapptTestGoeTests: XCTestCase {
    var location:LocationServices!
    override func setUp() {
        super.setUp()
        location=LocationServices.getInstances()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        location=nil
    }
    func testLocationFound(){
        location.locationManager.startUpdatingLocation()
        XCTAssertTrue(location.locationManager != nil, "getting lat lon")
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
