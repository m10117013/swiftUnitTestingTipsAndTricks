//
//  TaipeiMailViewModel.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/9/5.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit

class TaipeiMailViewModel: NSObject {

    public var manager : TaipeiAPIManager = TaipeiAPIManager()
    
    private var items : [TaipeiAPIItem]?
    
    var session : URLSession!
    
    /// reloading datas
    ///
    /// - Parameter handler: if loading done
    public func reloadData(handler : @escaping () -> Void) {
        manager.loadDatas { [unowned self] (response) in
            self.items = response?.results
            handler()
        }
    }
    
    /// numberOfRows
    public func numberOfRows() -> Int {
        return items?.count ?? 0
    }
    
    /// cell view model
    ///
    /// - Parameter index: index of items
    /// - Returns: cellViewModel
    public func cellViewModel(at index:Int) -> TaipeiMailCellViewModel {
        guard let item = self.items , item.count > index else {
            assert(false, "items was out of bounds")
             return TaipeiMailCellViewModel()
        } 
        
        if let item = items?[index] {
            return TaipeiMailCellViewModel(with: item)
        }
        assert(false, "item can't be nil")
        return TaipeiMailCellViewModel()
    }
}
