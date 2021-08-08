//
//  ResetPasswordVM.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 06/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation

typealias ResetPasswordCompletionHandler = (_ result: Any?, _ error: Error?, _ status: Bool?, _ message: String?) -> ()


class ResetPasswordVM: NSObject {
    var phoneFromUser: String
    var codeFromUser: String
    var newPasswordFromUser: String = ""
    
    init(phoneFromUser: String, codeFromUser: String) {
        self.phoneFromUser = phoneFromUser
        self.codeFromUser = codeFromUser
    }
    
    func resetPassword(phone: String, code: String, password: String, _ completion: @escaping ResetPasswordCompletionHandler) {
        Utility.showLoading()
        
        APIClient.shared.resetPasswordApi(phone: phone, code: code, password: password) { result, error, status, message in
            Utility.hideLoading()
            
            if status , error == nil {
                completion(result, nil, status, message)
            } else {
                completion(nil, error, status, message)
            }
        }
    }
}
