//
//  TaipeiAPIManager.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/9/6.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit

class TaipeiAPIManager: NSObject {

    var session : URLSession!
    
    init(_ session : URLSession = .shared) {
        self.session = session
    }
    
    func loadDatas(handler : @escaping (_ result:TaipeiAPIResult?)->Void ) -> Void {
        let request = TaipeiMailRequest()
        let loader: APIRequestLoader<TaipeiMailRequest> = APIRequestLoader(apiRequest: request, urlSession: session)
        loader.loadAPIRequest(requestData: "臺北市文化快遞資訊") { result, error in
            handler(result?.result)
        }
    }
}
