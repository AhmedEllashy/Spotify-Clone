//
//  SpotifyTests.swift
//  SpotifyTests
//
//  Created by Ahmad Ellashy on 05/05/2024.
//

import XCTest
@testable import Spotify

final class SpotifyTests: XCTestCase {
    
    var sut : APIManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = APIManager.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    func testGetCategories() async throws  {
        func checker() -> Bool {
            var check : Bool = true
            sut.getCategories { result in
                switch result {
                case .failure(let error) :
                    check = false
                case .success(_):
                    check = true
                }
            }
            return check
        }
        XCTAssert(checker())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
