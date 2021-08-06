//
//  FAQsViewModel.swift
//  CarrierApp
//
//  Created by MAC on 05/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias FaqsCompletionHandler = (_ data: FAQsDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

class FAQsViewModel: NSObject{
    
    var data : FAQsDataModel?
    
    override init() {
        super.init()
        
    }
    
    func FetchFAQsData(_ completionHandler: @escaping FaqsCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.FaqApiFunctionCall { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<FAQsDataModel>().map(JSON: newResult as [String : Any]) {
                    
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
