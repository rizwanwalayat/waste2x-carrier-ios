//
//  LoginViewModel.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 05/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias LoginCompletionHandler = (_ result: LoginUser?,_ error: Error?, _ status: Bool?, _ message: String?) -> ()

class LoginViewModel: NSObject
{
    
    func login(phoneNumber: String, password: String, _ completion: @escaping LoginCompletionHandler) {
        Utility.showLoading()
        
        APIClient.shared.login(number: phoneNumber, password: password) { result, error, status, message in
            Utility.hideLoading()
            
            if status, error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<LoginUser>().map(JSON: newResult as [String : Any]) {
                    completion(data, nil, status, message)
                }
                else {
                    completion(nil, nil, false, message)
                }
            } else {
                completion(nil, error, status, message)
            }
        }
        
    }
}
