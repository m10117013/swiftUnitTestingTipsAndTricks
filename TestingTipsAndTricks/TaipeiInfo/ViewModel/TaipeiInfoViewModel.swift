//
//  TaipeiMailViewModel.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/9/5.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit

class TaipeiInfoViewModel: NSObject {
    
    enum TaipeiInfoViewModelError:Error {
        case itemsWasOutOfBounds
    }
    
    /// API manager
    public var manager : TaipeiAPIManager = TaipeiAPIManager()
    
    /// items
    public var items : [TaipeiAPIItem]?
    
    /// session
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
    public  func cellViewModel(at index:Int) throws -> TaipeiInfoCellViewModel {
        guard let items = self.items , items.count > index else {
            throw TaipeiInfoViewModelError.itemsWasOutOfBounds
//            assert(false, "items was out of bounds")
        }
        return TaipeiInfoCellViewModel(with: items[index])
    }
}
