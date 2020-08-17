//
//  NetworkHelperTest.swift
//  MoviesIncTests
//
//  Created by Atef on 8/16/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation

import XCTest
@testable import MoviesInc

class NetworkHelperTest: XCTestCase {
    override func setUp() {
         
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkRequest() {
        let network:NetworkHelper = NetworkHelper.shared
        let promise = expectation(description: "Completion handler invoked")

        var _data: Data?
         var responseError: Error?
        
        network.excuteRequest(urlRequest: HomeMovieRequest(parms:[:]), success: { (data) in
            _data = data
            promise.fulfill()
            
        }) { (error) in
        responseError = error
        }
        
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertNotNil(_data)
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
