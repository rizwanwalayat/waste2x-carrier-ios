//
//  AvailableLoadsDetailsVM.swift
//  CarrierApp
//
//  Created by MAC on 09/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias AvailabelLoadsDetailCompletionHandler = (_ data: SendQuotationDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

class AvailabelLoadsDetailViewModel: NSObject {
    
    var data : SendQuotationDataModel?
    
    override init() {
        super.init()
        
    }
    
    func sendQuotationRequest(params: [String : Any], _ completionHandler: @escaping AvailabelLoadsDetailCompletionHandler)
    {
        Utility.showLoading()
        APIClient.shared.sendQuotationFunctionCall(params, { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result, "message": message, "success": status] as [String : Any]
                if let data = Mapper<SendQuotationDataModel>().map(JSON: newResult as [String : Any]) {
                    
                    self.data = data
                    completionHandler(data, error, status, message)
                    
                } else {
                    
                    completionHandler(nil, error, status, message)
                }
                
            } else {
                completionHandler(nil, error, status, message)
            }
        })
    }
}
