//
//  FAQsViewModel.swift
//  CarrierApp
//
//  Created by MAC on 05/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias FaqsCompletionHandler = (_ data: PhoneNoDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

class FAQsViewModel: NSObject{
    
    func FetchFAQsData(_ completion: @escaping FaqsCompletionHandler ) {
        Utility.showLoading()
        APIClient.shared.FaqApiFunctionCall { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<PhoneNoDataModel>().map(JSON: newResult as [String : Any]) {
                    completion(data, nil, status,message)
                } else {
                    completion(nil, nil, status,message)
                }
                
            } else {
                 completion(nil, error, status,message)
            }
        }
    }
}
