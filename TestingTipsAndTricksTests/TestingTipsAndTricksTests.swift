//
//  TestingTipsAndTricksTests.swift
//  TestingTipsAndTricksTests
//
//  Created by wei on 2018/8/24.
//  Copyright © 2018年 wei. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TestingTipsAndTricks

class TestingTipsAndTricksTests: XCTestCase {
    
    var loader: APIRequestLoader<PointsOfInterestRequest>!
    
    ///初始化代碼
    override func setUp() {
        super.setUp()
        
        let request = PointsOfInterestRequest()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let inputCoordinate = CLLocationCoordinate2D(latitude: 37.3293, longitude: -121.8893)
        let mockJSONData = "[{\"name\":\"MyPointOfInterest\"}]".data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.query?.contains("lat=37.3293"), true)
            return (HTTPURLResponse(), mockJSONData)
        }
        
        
        let expectation = XCTestExpectation(description: "response")
        loader.loadAPIRequest(requestData: inputCoordinate) { pointsOfInterest, error in
            XCTAssertEqual(pointsOfInterest!, [PointOfInterest(name: "MyPointOfInterest")])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1000)
 
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


