//
//  ReceivablesResult.swift
//  CarrierApp
//
//  Created by HaiDer's Macbook Pro on 08/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class ReceivablesResult : Mappable {
    
    var id = -1
    var dispatchId = ""
    var currency = ""
    var receivedAmount = ""
    var outstandingAmount = ""
    var total = ""
    var status = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        dispatchId <- map["dispatch_id"]
        currency <- map["currency"]
        receivedAmount <- map["received_amount"]
        outstandingAmount <- map["outstanding_amount"]
        total <- map["total"]
        status <- map["status"]
    }

}
