//
//  CodeVerificationVM.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 06/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation

typealias CodeVerificationCompletionHandler = (_ result: Any?, _ error: Error?, _ status: Bool?, _ message: String?) -> ()

class CodeVerificationVM: NSObject {
    
    var phoneFromUser: String
    var codeFromBackend: String
    var codeFromUser: String = ""
    
    init(phoneFromUser: String, codeFromBackend: String) {
        self.phoneFromUser = phoneFromUser
        self.codeFromBackend = codeFromBackend
    }

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
    
    func sendOTPCode(phoneNumber: String, _ completionHandler: @escaping ResetPasswordCompletionHandler ) {
        
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
    
}
