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
    
    var data = Observable<FAQsDataModel?>(nil)
    var controller : FaqViewController?
    
    override init() {
        super.init()
        
        FetchFAQsData()
    }
    
    private func FetchFAQsData() {
        Utility.showLoading()
        APIClient.shared.FaqApiFunctionCall { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<FAQsDataModel>().map(JSON: newResult as [String : Any]) {
                    self.data.value = data
                    
                } else {
                    Utility.showAlertController(self.controller!, message)
                }
                
            } else {
                Utility.showAlertController(self.controller!, error?.localizedDescription ?? message)
            }
        }
    }
}
