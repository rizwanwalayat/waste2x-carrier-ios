//
//  ReceivablesDataModel.swift
//  CarrierApp
//
//  Created by HaiDer's Macbook Pro on 08/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class ReceivablesDataModel : Mappable {
    var success = false
    var status_code = -1
    var message = ""
    var result = [ReceivablesResult]()

    
    required init?(map: Map) {

    }

    func mapping(map: Map) {

        success <- map["success"]
        status_code <- map["status_code"]
        message <- map["message"]
        result <- map["result"]
    }

}
