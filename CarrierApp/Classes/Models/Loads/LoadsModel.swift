//
//  LoadsModel.swift
//  CarrierApp
//
//  Created by HaiDer's Macbook Pro on 05/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper
typealias LoadsUserCompletionHandler = (_ data: LoadsModel?, _ error: Error?, _ status: Bool?, _ message:String) -> Void

class LoadsModel : Mappable
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
    
    class func loads(phoneNumber: String, password: String, _ completion: @escaping LoadsUserCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.login(number: phoneNumber, password: password) { result, error, status,message in
            Utility.hideLoading()
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<LoadsModel>().map(JSON: newResult as [String : Any]) {
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

