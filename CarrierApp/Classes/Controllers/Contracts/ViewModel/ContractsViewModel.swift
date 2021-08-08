//
//  ContractsViewModel.swift
//  CarrierApp
//
//  Created by HaiDer's Macbook Pro on 08/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias ContaractsCompletionHandler = (_ data: ContractsDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

class ContractsViewModel: NSObject{
    
    var data : ContractsDataModel?
    
    override init() {
        super.init()
        
    }
    
    func FetchContractsData(_ completionHandler: @escaping ContaractsCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.ContractsApiFunctionCall { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<ContractsDataModel>().map(JSON: newResult as [String : Any]) {
                    
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
