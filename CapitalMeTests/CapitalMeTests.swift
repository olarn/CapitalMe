//
//  CapitalMeTests.swift
//  CapitalMeTests
//
//  Created by Olarn U. on 5/28/2559 BE.
//  Copyright © 2559 Olarn U. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import CapitalMe

class CapitalMeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testJSONToCapitalInfo() {
        let bundle = NSBundle.mainBundle()
        let url = bundle.URLForResource("bangkok", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        let json = JSON(data: data!)
        
        XCTAssertTrue(json[0]["name"] == "Thailand")
    }
}
