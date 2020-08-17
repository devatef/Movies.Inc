//
//  MovieRepoTests.swift
//  MoviesIncTests
//
//  Created by Atef on 8/16/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import XCTest
import PromiseKit
@testable import MoviesInc

class MovieRepoTests: XCTestCase {
    var repo:MovieRepo?
    override func setUp() {
        repo = MovieRepo()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        repo = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadHomeMovies() {
        let model = repo?.loadMovies()
        XCTAssertNotNil(model)
    }
    
    func testLoadHomeMoviesData() {
        
        
        let expectation = XCTestExpectation(description: "get Movies")
        var model:MoviesModel?
        _ = repo?.loadMovies().done{ (movies)  in
            model = movies
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
        // wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(model?.results.count ?? 0 > 1)
        
    }
    
    func testLoadMovieDetails() {
        let expectation = XCTestExpectation(description: "get movie details")
        var model:MovieDetailsModel?
       _ = repo?.loadMovieDeatils(movieId: 550).done{ (details)  in
            model = details
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
        // wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(model?.title, "Fight Club")
        XCTAssertTrue(model?.credits.cast.count ?? 0 > 1)
        
    }
    
    func testLoadRecommendedMovies() {
        let expectation = XCTestExpectation(description: "get Recommended Movies")
        var model:MoviesModel?
        _ = repo?.loadRecommendedMovies(movieId: 550).done{ (movies)  in
            model = movies
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
        // wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(model?.results.count ?? 0 > 1)
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
