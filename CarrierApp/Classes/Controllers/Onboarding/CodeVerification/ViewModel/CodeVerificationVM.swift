//
//  CodeVerificationVM.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 05/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation

typealias CodeVerificationCompletionHandler = (_ result: Any?, _ error: Error?, _ status: Bool?, _ message: String?) -> ()

class CodeVerificationVM: NSObject {
    
    func verifyOTP(phoneNumber: String, code: String, _ completionHandler: @escaping CodeVerificationCompletionHandler ) {
        
        Utility.showLoading()
        
        APIClient.shared.verifyOTPApi(phone: phoneNumber, code: code) { result, error, status, message in
            Utility.hideLoading()
            
            if status, error == nil {
                completionHandler(result, error, status, message)
            } else {
                completionHandler(nil, error, status, message)
            }
        }
        
    }
    
    func sendCodeAgain(phoneNumber: String, _ completionHandler: @escaping CodeVerificationCompletionHandler ) {
        
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
