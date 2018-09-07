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
    
    /// loading taipei API data
    ///
    /// - Parameter handler: <#handler description#>
    func loadDatas(handler : @escaping (_ result:TaipeiAPIResult?) -> Void ) -> Void {
        let request = TaipeiInfoRequest()
        let loader: APIRequestLoader<TaipeiInfoRequest> = APIRequestLoader(apiRequest: request, urlSession: session)
        loader.loadAPIRequest(requestData: "") { result, error in
            handler(result?.result)
        }
    }
}
