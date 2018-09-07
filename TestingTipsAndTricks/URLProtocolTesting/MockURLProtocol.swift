//
//  MockURLProtocol.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/8/24.
//  Copyright © 2018年 wei. All rights reserved.
//

import XCTest

/// mocking URL protocol
class MockURLProtocol: URLProtocol {

    static var requestHandler : ((URLRequest) throws -> (HTTPURLResponse , Data))?
    
    override class func canInit(with request:URLRequest) -> Bool {
        return true
    }
    
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        //do nothing
    }
}
