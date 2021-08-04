//
//  CodeVerification.swift
//  Waste2x
//
//  Created by HaiDer's Macbook Pro on 09/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import Foundation
import ObjectMapper
typealias LoginUserCompletionHandler = (_ data: LoginUser?, _ error: Error?, _ status: Bool?, _ message:String) -> Void

class LoginUser : Mappable
{
    var success = false
    var message = ""
    var result : ResultLoginUser?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        success <- map["success"]
        message <- map["message"]
        result <- map["result"]
    }
    
    class func login(phoneNumber: String, password: String, _ completion: @escaping LoginUserCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.login(number: phoneNumber, pasword: password) { result, error, status,message in
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<LoginUser>().map(JSON: newResult as [String : Any]) {
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

