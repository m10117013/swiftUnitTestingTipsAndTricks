//
//  TaipeiMailAPI.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/8/31.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit

/// taipei Info request
struct TaipeiInfoRequest : APIRequest {
    
    let base_url = "http://data.taipei/opendata/datalist/apiAccess"
    
    func makeRequest(from queryKey: String) throws -> URLRequest {
        var components = URLComponents(string: "\(base_url)?scope=datasetMetadataSearch")!
        components.queryItems = [
            URLQueryItem(name: "scope", value: "datasetMetadataSearch"),
            URLQueryItem(name: "limit", value: "10")
        ]
        
        if queryKey.count != 0 {
            components.queryItems?.append(URLQueryItem(name: "q", value: "\(queryKey)"))
        }
        return URLRequest(url: components.url!)
    }
    
    func parseResponse(data: Data) throws -> TaipeiAPIResponse {
        let decoder = JSONDecoder()
        let datas = try decoder.decode(TaipeiAPIResponse.self, from: data)
        return datas
    }
}

// MARK: - Zzzz

/// response of root
struct TaipeiAPIResponse : Codable {
    var result : TaipeiAPIResult
}

/// response of result
struct TaipeiAPIResult : Codable {
    var limit : Int
    var offset : Int
    var count : Int
    var sort : String
    var results : [TaipeiAPIItem]
}

/// response of item
struct TaipeiAPIItem : Codable {
    var id : String?
    var title : String?
    var type : String?
    var category : String?
}
