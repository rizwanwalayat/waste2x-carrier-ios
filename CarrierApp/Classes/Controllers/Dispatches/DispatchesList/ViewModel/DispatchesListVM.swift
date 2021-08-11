//
//  DispatchesListVM.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 09/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias DispatchesListCompletionHandler = (_ data: DispatchesListModel?, _ error: Error?, _ status: Bool?, _ message: String) -> Void
class DispatchesListVM: NSObject {
    var data: DispatchesListModel?
    
    override init(){
        super.init()
    }

    func fetchDispatchesData(_ completionhandler: @escaping DispatchesListCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.DispatchesListApiFunctionCall { result, error, status, message in
            Utility.hideLoading()
            
            let newResult = ["result": result]
            
            if status, error == nil, let data = Mapper<DispatchesListModel>().map(JSON: newResult as [String: Any]) {
                self.data = data
                completionhandler(data, error, status, message)
            } else {
                completionhandler(nil, error, status, message)
            }
            
        }
    }
}
