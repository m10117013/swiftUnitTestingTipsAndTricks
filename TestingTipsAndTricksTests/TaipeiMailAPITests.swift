//
//  TaipeiMailAPITests.swift
//  TestingTipsAndTricksTests
//
//  Created by wei on 2018/8/31.
//  Copyright © 2018年 wei. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TestingTipsAndTricks

class TaipeiMailAPITests: XCTestCase {

    var loader: APIRequestLoader<TaipeiMailRequest>!
    
    ///初始化代碼
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /// 正常連線測試
    func test_taipeiSentRequest() {
        let request = TaipeiMailRequest()
        loader = APIRequestLoader(apiRequest: request)
        let expectation = XCTestExpectation(description: "response")
        loader.loadAPIRequest(requestData: "臺北市文化快遞資訊") { result, error in
            XCTAssertEqual(result!.result.results[0].id, "e9bbb0c9-4d23-45b1-96d1-7b18565bbea6")
            XCTAssertEqual(result!.result.results[0].title, "臺北市文化快遞資訊")
            XCTAssertEqual(result!.result.results[0].type, "原始資料")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    
    /// 不改動Request與response來達到DI效果
    func test_taipeiMockExample() {
       
        let request = TaipeiMailRequest()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
        
        let filePath = Bundle.main.url(forResource: "fakeData", withExtension: "json")
       
        let jsonMockData = try! Data(contentsOf: filePath!, options: .mappedIfSafe)
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.query?.contains("q=臺北市文化快遞資訊"), true)
            return (HTTPURLResponse(), jsonMockData)
        }
        
        
        let expectation = XCTestExpectation(description: "response")
        loader.loadAPIRequest(requestData: "臺北市文化快遞資訊") { result, error in
            XCTAssertEqual(result!.result.results[0].id, "e9bbb0c9-4d23-45b1-96d1-7b18565bbea6")
            XCTAssertEqual(result!.result.results[0].title, "臺北市文化快遞資訊")
            XCTAssertEqual(result!.result.results[0].type, "原始資料")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        
    }
    
}
