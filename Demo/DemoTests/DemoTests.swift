//
//  DemoTests.swift
//  DemoTests
//
//  Created by Suhail on 20/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import XCTest

class DemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJSONFileDoesExsistInBundle() throws {
        
        guard Bundle.main.url(forResource: "Response", withExtension: "json") != nil else {
            XCTFail("Missing file: Response.json")
            return
        }
    }
}
