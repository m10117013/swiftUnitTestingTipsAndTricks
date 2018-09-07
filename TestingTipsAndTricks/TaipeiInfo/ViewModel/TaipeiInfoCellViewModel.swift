//
//  TaipeiMailCellViewModel.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/9/5.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit

class TaipeiInfoCellViewModel: NSObject {

    var Title : String {
        get {
            return item?.title ?? "unknow"
        }
    }
    var ID : String {
        get {
            return item?.id ?? "unknow"
        }
    }
    var Detail : String {
        get {
            return item?.category ?? "unknow"
        }
    }
    
    private var item : TaipeiAPIItem?
    
    override init() {
        
    }
    
    init(with item:TaipeiAPIItem) {
        self.item = item
    }
}


