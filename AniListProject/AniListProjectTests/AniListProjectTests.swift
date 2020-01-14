//
//  AniListProjectTests.swift
//  AniListProjectTests
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import XCTest
@testable import AniListProject

class AniListProjectTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testReadFileQuery() {
        let query = ReadFiles.ReadQueryFromFile(withFileName: "file01", type: "txt")
        print(query ?? "empty")
        XCTAssert((query != nil), "No exist the file")
    }

}
