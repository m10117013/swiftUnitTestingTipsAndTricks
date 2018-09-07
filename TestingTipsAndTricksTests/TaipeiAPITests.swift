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

class TaipeiAPITests: XCTestCase {

    var loader: APIRequestLoader<TaipeiInfoRequest>!
    
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
        let request = TaipeiInfoRequest()
        loader = APIRequestLoader(apiRequest: request)
        let expectation = XCTestExpectation(description: "response")
        loader.loadAPIRequest(requestData: "") { result, error in
//            XCTAssertEqual(result!.result.results[0].id, "e9bbb0c9-4d23-45b1-96d1-7b18565bbea6")
//            XCTAssertEqual(result!.result.results[0].title, "臺北市文化快遞資訊")
//            XCTAssertEqual(result!.result.results[0].type, "原始資料")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    
    /// 不改動Request與response來達到DI效果
    func test_taipeiMockExample() {
       
        let request = TaipeiInfoRequest()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
        let filePath = Bundle.main.url(forResource: "fakeData", withExtension: "json")
       
        let jsonMockData = try! Data(contentsOf: filePath!, options: .mappedIfSafe)
        
        MockURLProtocol.requestHandler = { request in
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
    
    //cellViewModel單元測試
    func test_unit_cellViewModel() {
        //fake item
        let fakeItem = TaipeiAPIItem(id: "ID", title: "TITLE", type: "TYPE", category: "CITY")
        var cellViewModel = TaipeiInfoCellViewModel(with: fakeItem)
        XCTAssertEqual(cellViewModel.ID, "ID")
        XCTAssertEqual(cellViewModel.Title, "TITLE")
        XCTAssertEqual(cellViewModel.Detail, "CITY")
        
        //null item
        cellViewModel = TaipeiInfoCellViewModel()
        XCTAssertEqual(cellViewModel.ID, "unknow")
        XCTAssertEqual(cellViewModel.Title, "unknow")
        XCTAssertEqual(cellViewModel.Detail, "unknow")
    }
    
    /// ViewModel單元測試
    func test_unit_viewModel() {
        let fakeItem = TaipeiAPIItem(id: "ID1", title: "TITLE1", type: "TYPE1", category: "CITY1")
        let fakeItem2 = TaipeiAPIItem(id: "ID2", title: "TITLE2", type: "TYPE2", category: "CITY2")
        let fakeItem3 = TaipeiAPIItem(id: "ID3", title: "TITLE3", type: "TYPE3", category: "CITY3")
        
        let viewModel = TaipeiInfoViewModel()
        viewModel.items = [fakeItem,fakeItem2,fakeItem3]
        XCTAssertEqual(viewModel.numberOfRows(),3)
        XCTAssertEqual(try viewModel.cellViewModel(at: 0).ID,"ID1")
        XCTAssertEqual(try viewModel.cellViewModel(at: 1).ID,"ID2")
        XCTAssertEqual(try viewModel.cellViewModel(at: 2).ID,"ID3")
        //out of bounds
        XCTAssertThrowsError(try viewModel.cellViewModel(at: 3).ID)
    }
    
    
    func test_integration_manager() {
        let request = TaipeiInfoRequest()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
        let filePath = Bundle.main.url(forResource: "fakeData", withExtension: "json")
        let jsonMockData = try! Data(contentsOf: filePath!, options: .mappedIfSafe)
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), jsonMockData)
            }
        
        //mock session
        let manager = TaipeiAPIManager(urlSession)
        //view model
        let viewModel = TaipeiInfoViewModel()
        viewModel.manager = manager
        
        let expectation = XCTestExpectation(description: "response")
        viewModel.reloadData {
            XCTAssertEqual(viewModel.numberOfRows(), 1)
            let item = try? viewModel.cellViewModel(at: 0)
            XCTAssertEqual(item?.Title, "臺北市文化快遞資訊")
            XCTAssertEqual(item?.ID, "e9bbb0c9-4d23-45b1-96d1-7b18565bbea6")
            XCTAssertEqual(item?.Detail, "休閒旅遊文化")
            expectation.fulfill()
        }
       
        wait(for: [expectation], timeout: 1)
     
    }
    
    
    
}
