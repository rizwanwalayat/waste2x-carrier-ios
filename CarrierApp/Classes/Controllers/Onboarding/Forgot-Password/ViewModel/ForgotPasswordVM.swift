//
//  ForgotPasswordVM.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 06/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation

typealias ForgotPasswordCompletionHandler = (_ result: Any?, _ error: Error?, _ status: Bool?, _ message: String?) -> ()

class ForgotPasswordVM: NSObject {
    
    func sendOTPCode(phoneNumber: String, _ completionHandler: @escaping ForgotPasswordCompletionHandler ) {
        
        Utility.showLoading()
        
        APIClient.shared.SendCodeApi(phone: phoneNumber) { result, error, status, message in
            Utility.hideLoading()
            
            if status, error == nil {
                
                guard let codeDict = result as? [String:Any],  let code = codeDict["code"] as? NSNumber
                else {
                    completionHandler(nil, error, status, message)
                    return
                }
                completionHandler(code.stringValue, error, status, message)
            } else {
                completionHandler(nil, error, status, message)
            }
        }
    }
    
    func sendSignupOTPCode(phoneNumber: String, _ completionHandler: @escaping ForgotPasswordCompletionHandler ) {
        
        Utility.showLoading()
        
        APIClient.shared.SendSignupCodeApi(phone: phoneNumber) { result, error, status, message in
            Utility.hideLoading()
            
            if status, error == nil {
                
                guard let codeDict = result as? [String:Any],  let code = codeDict["code"] as? NSNumber
                else {
                    completionHandler(nil, error, status, message)
                    return
                }
                completionHandler(code.stringValue, error, status, message)
            } else {
                completionHandler(nil, error, status, message)
            }
        }
    }
}
