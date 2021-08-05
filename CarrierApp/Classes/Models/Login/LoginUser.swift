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
    
    

}

