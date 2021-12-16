//
//  ShipmentsListVM.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 09/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias ShipmentsListCompletionHandler = (_ data: ShipmentsListModel?, _ error: Error?, _ status: Bool?, _ message: String) -> Void
class ShipmentsListVM: NSObject {
    var data: ShipmentsListModel?
    
    override init(){
        super.init()
    }

    func fetchDispatchesData(_ completionhandler: @escaping ShipmentsListCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.ShipmentsListApiFunctionCall { result, error, status, message in
            Utility.hideLoading()
            
            let newResult = ["result": result]
            
            if status, error == nil, let data = Mapper<ShipmentsListModel>().map(JSON: newResult as [String: Any]) {
                self.data = data
                completionhandler(data, error, status, message)
            } else {
                completionhandler(nil, error, status, message)
            }
            
        }
    }
}
