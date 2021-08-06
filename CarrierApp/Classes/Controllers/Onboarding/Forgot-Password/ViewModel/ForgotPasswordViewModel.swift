//
//  ForgotPasswordViewModel.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 05/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation

typealias ForgotPasswordCompletionHandler = (_ result: Any?, _ error: Error?, _ status: Bool?, _ message: String?) -> ()
class ForgotPasswordViewModel: NSObject {
    
    func forgotPassword(phoneNumber: String, _ completionHandler: @escaping ForgotPasswordCompletionHandler ) {
        
        Utility.showLoading()
        
        APIClient.shared.SendCodeApi(phone: phoneNumber) { result, error, status, message in
            Utility.hideLoading()
            
            if status, error == nil {
               
                completionHandler(result, error, status, message)
            } else {
                completionHandler(nil, error, status, message)
            }
        }
        
    }
}
