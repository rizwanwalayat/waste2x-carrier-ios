//
//  ReceiveableViewModel.swift
//  CarrierApp
//
//  Created by HaiDer's Macbook Pro on 08/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias ReceiveableCompletionHandler = (_ data: ReceivablesDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

class ReceiveableViewModel: NSObject{
    
    var data : ReceivablesDataModel?
    
    override init() {
        super.init()
        
    }
    
    func FetchReceiveableData(_ completionHandler: @escaping ReceiveableCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.ReceivablesApiFunctionCall { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<ReceivablesDataModel>().map(JSON: newResult as [String : Any]) {
                    
                    self.data = data
                    
                    completionHandler(data, error, status, message)
                    
                } else {
                    
                    completionHandler(nil, error, status, message)
                }
                
            } else {
                completionHandler(nil, error, status, message)
            }
        }
    }
}
