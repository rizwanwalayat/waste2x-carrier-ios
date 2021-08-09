//
//  DispatchContractsModel.swift
//  CarrierApp
//
//  Created by HaiDer's Macbook Pro on 08/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class DispatchContractsModel : Mappable {
    
    var id = -1
    var loadId = -1
    var price = -1
    var status = ""
    var isSigned = Bool()
    var transporterName = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        loadId <- map["load_id"]
        price <- map["price"]
        status <- map["status"]
        isSigned <- map["is_signed"]
        transporterName <- map["transporter_name"]
    }

}
