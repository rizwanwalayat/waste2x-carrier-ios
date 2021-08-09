//
//  QuotationDataModel.swift
//  CarrierApp
//
//  Created by HaiDer's Macbook Pro on 09/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class QuotationDataModel : Mappable {
    var success = false
    var status_code = -1
    var message = ""
    var result = [DispatchResult]()

    
    required init?(map: Map) {

    }

    func mapping(map: Map) {

        success <- map["success"]
        status_code <- map["status_code"]
        message <- map["message"]
        result <- map["result"]
    }

}
class DispatchResult : Mappable {
    
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
        transporterName <- map["transporter_name"]
    }

}
class QuotationDetailDataModel : Mappable {
    var success = false
    var status_code = -1
    var message = ""
    var result : QuotationDetailResult?

    
    required init?(map: Map) {

    }

    func mapping(map: Map) {

        success <- map["success"]
        status_code <- map["status_code"]
        message <- map["message"]
        result <- map["result"]
    }

}
class QuotationDetailResult : Mappable {
    
    var id = ""
    var price = -1
    var status = ""
    var transporterName = ""
    var commodity = ""
    var origin = ""
    var destination = ""
    var quantity = -1.0
    var unit = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        price <- map["price"]
        status <- map["status"]
        transporterName <- map["transporter"]
        commodity <- map["commodity"]
        origin <- map["origin"]
        destination <- map["destination"]
        quantity <- map["quantity"]
        unit <- map["unit"]
    }

}
class QuotationResponceDataModel : Mappable {
    var success = false
    var message = ""

    
    required init?(map: Map) {

    }

    func mapping(map: Map) {

        success <- map["success"]
        message <- map["message"]
    }

}
