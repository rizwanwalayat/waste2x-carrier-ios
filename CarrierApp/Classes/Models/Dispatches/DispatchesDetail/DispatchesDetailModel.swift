//
//  DispatchesDetailModel.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 12/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class DispatchesDetailModel: Mappable {
    var success = false
    var status_code = -1
    var message = ""
    var result: DispatchDetailResultModel?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        status_code <- map["status_code"]
        message <- map["message"]
        result <- map["result"]
    }
}

class DispatchDetailResultModel: Mappable {
    var pickup: DispatchesDetailPickDropModel?
    var delivery: DispatchesDetailPickDropModel?
    var details: DispatchesDetailDetailsModel?
    var shipment: DispatchesDetailShipmentModel?
    var status = ""
    var dispatchStatus: DispatchesStatus = .scheduled
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        pickup <- map["pickup"]
        delivery <- map["delivery"]
        details <- map["details"]
        shipment <- map["shipment"]
        status <- map["status"]
        postMapping()
    }
    
    func postMapping () {
        switch status {
        case "Scheduled":
            dispatchStatus = .scheduled
        case "Completed":
            dispatchStatus = .delivered
        case "In Transit":
            dispatchStatus = .in_transit
        default:
            dispatchStatus = .scheduled
        }
    }
}

class DispatchesDetailPickDropModel: Mappable {
    var location = ""
    var commodity = ""
    var arrival = ""
    var departure = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        location <- map["location"]
        commodity <- map["commodity"]
        arrival <- map["arrival"]
        departure <- map["departure"]
    }
}

class DispatchesDetailDetailsModel: Mappable {
    var dispatch_id = ""
    var dispatch_rep = ""
    var dispatch_time = ""
    var vehicle_type = ""
    var reg_number = ""
    var created_at = ""

    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        dispatch_id <- map["dispatch_id"]
        dispatch_rep <- map["dispatch_rep"]
        dispatch_time <- map["dispatch_time"]
        vehicle_type <- map["vehicle_type"]
        reg_number <- map["reg_number"]
        created_at <- map["created_at"]
    }
}

class DispatchesDetailShipmentModel: Mappable {
    var shipment_id = ""
    var order_id = ""
    var transporter_name = ""
    var transporter_phone = ""
    var commodity = ""
    var packages = ""
    var weight = ""
    var dimensions = ""
    var shipper = ""
    var consignee = ""
    var pickup = ""
    var delivery = ""
    var ref_number = ""

    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        shipment_id <- map["shipment_id"]
        order_id <- map["order_id"]
        transporter_name <- map["transporter_name"]
        transporter_phone <- map["transporter_phone"]
        commodity <- map["commodity"]
        packages <- map["packages"]
        weight <- map["weight"]
        dimensions <- map["dimensions"]
        shipper <- map["shipper"]
        consignee <- map["consignee"]
        pickup <- map["pickup"]
        delivery <- map["delivery"]
        ref_number <- map["ref_number"]

    }
}
