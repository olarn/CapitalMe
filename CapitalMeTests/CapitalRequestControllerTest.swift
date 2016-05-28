//
//  CapitalRequestControllerTest.swift
//  CapitalMe
//
//  Created by Olarn U. on 5/28/2559 BE.
//  Copyright © 2559 Olarn U. All rights reserved.
//

import XCTest
@testable import CapitalMe

class RestSuccessMock: RestClient {
    
    override func request(
        url: String,
        onFail:(error: NSError) -> Void,
        onSuccess:(data: NSData?) -> Void)
    {
        let bundle = NSBundle.mainBundle()
        let url = bundle.URLForResource("bangkok", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        onSuccess(data: data)
    }
}

class CapitalRequestControllerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCapitalRequestWithSuccessCase() {
        
        let expectation = expectationWithDescription("Expect CapitalInfo.")
        
        let client = RestSuccessMock()
        
        let capitalRequest = CapitalRequestController(client: client)
        capitalRequest.request(
            "any city",
            onFail: { (error) in
                XCTFail("Test success case should not fail.")
                expectation.fulfill()
            }) { (info) in
                XCTAssertTrue(info?.countryName == "Thailand")
                XCTAssertTrue(info?.countryCode == "TH")
                XCTAssertTrue(info?.population == "65104000")
                XCTAssertTrue(info?.latLong == "15, 100")
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
