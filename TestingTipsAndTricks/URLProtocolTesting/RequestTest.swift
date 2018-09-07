//
//  RequestTest.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/8/24.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit
import CoreLocation

enum RequestError:Error {
    case invalidCoordinate
    case tooYoungProblem
    case notAquariusProblem
    case falseHeartProblem
}

struct PointOfInterest : Codable {
    var name : String
}

extension PointOfInterest: Equatable {}

func ==(lhs: PointOfInterest, rhs: PointOfInterest) -> Bool {
    let areEqual = lhs.name == rhs.name
    
    return areEqual
}

/// 此介面定義了一個基本的產生Request , parseResponse
protocol APIRequest {
    associatedtype RequestDataType
    associatedtype ResponseDataType
    func makeRequest(from data: RequestDataType) throws -> URLRequest
    func parseResponse(data: Data) throws -> ResponseDataType
}

struct PointsOfInterestRequest : APIRequest {
    func makeRequest(from coordinate: CLLocationCoordinate2D) throws -> URLRequest {
        guard CLLocationCoordinate2DIsValid(coordinate) else {
            throw RequestError.invalidCoordinate
        }
        var components = URLComponents(string: "https://example.com/locations")!
        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
            URLQueryItem(name: "long", value: "\(coordinate.longitude)")
        ]
        
        return URLRequest(url: components.url!)
    }
    
    func parseResponse(data: Data) throws -> [PointOfInterest] {
        return try JSONDecoder().decode([PointOfInterest].self, from: data)
    }
}

class APIRequestLoader<T: APIRequest> {

    let apiRequest: T
    let urlSession: URLSession
    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType,
                        completionHandler: @escaping (T.ResponseDataType?, Error?) -> Void) {
        do {
            let urlRequest = try apiRequest.makeRequest(from: requestData)
            urlSession.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else { return completionHandler(nil, error) }
                do {
                    let parsedResponse = try self.apiRequest.parseResponse(data: data)
                    completionHandler(parsedResponse, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }.resume()
        } catch { return completionHandler(nil, error) }
    }
}
