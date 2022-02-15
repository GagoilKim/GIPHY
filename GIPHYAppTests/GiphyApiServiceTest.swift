//
//  GiphyApiServiceTest.swift
//  GIPHYAppTests
//
//  Created by Kyle Kim on 2022/02/15.
//

import XCTest
@testable import GIPHYApp

class GiphyApiServiceTest: XCTestCase {
    private var giphyApiService : GiphyApiServiceProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        giphyApiService = GiphyApiService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func TEST_searchImages_Valid_Result() throws {
        let keyword  = "HELLO"
        
        giphyApiService.searchImages(keyword: keyword) { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data.count > 0, true)
            case .failure:
                XCTFail("Faild: TEST_searchImages_Valid_Result is failed")
            }
        }
    }
    
    func TEST_searchImages_Empty_Result() throws {
        let keyword  = "<<"
        
        giphyApiService.searchImages(keyword: keyword) { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data.count == 0, true)
            case .failure:
                XCTFail("Faild: TEST_searchImages_Empty_Result is failed")
            }
        }
    }
    
    func TEST_searchStickers_Valid_Result() throws {
        let keyword  = "America"

        giphyApiService.searchStickers(keyword: keyword) { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data.count > 0, true)
            case .failure:
                XCTFail("Faild: TEST_searchStickers_Valid_Result is failed")
            }
        }
    }
    
    func TEST_searchStickers_Empty_Result() throws {
        let keyword  = "<<"

        giphyApiService.searchStickers(keyword: keyword) { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data.count == 0, true)
            case .failure:
                XCTFail("Faild: TEST_searchStickers_Valid_Result is failed")
            }
        }
    }
    
    func TEST_getTrendingImages_Valid_Result() throws {
        giphyApiService.getTrendingImages() { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data.count > 0, true)
            case .failure:
                XCTFail("Faild: TEST_searchStickers_Valid_Result is failed")
            }
        }
    }
    
    func TEST_getTrendingSearch_Valid_Result() throws {
        giphyApiService.getTrendingSearch() { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data.count > 0, true)
            case .failure:
                XCTFail("Faild: TEST_searchStickers_Valid_Result is failed")
            }
        }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
