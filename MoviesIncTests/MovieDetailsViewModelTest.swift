//
//  RateMovieTest.swift
//  MoviesIncTests
//
//  Created by Atef on 8/16/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
import XCTest
import RxSwift
import RxCocoa
@testable import MoviesInc

class MovieDetailsViewModelTest: XCTestCase {
    
    var viewModel:MovieDetailsViewModel?
    override func setUp() {
        viewModel = MovieDetailsViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testfetchMovieDetails() {
        let expectation = XCTestExpectation(description: "get Movie Details")
        
        viewModel?.fetchMovieDetails(movieId: 550)
        DispatchQueue.main.asyncAfter(deadline: .now()+10) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        
        XCTAssertTrue(viewModel?.numberOfActors ?? 0 >  1)
    }
    
    func testRateMovie(){
        let expectation = XCTestExpectation(description: "rate Movie ")
        let timeout = 60.0
        viewModel?.rateMovie(movieId: 550, rate: 7)
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel?.rateStatusCode, 1)

        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
