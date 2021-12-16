//
//  ShipmentsModel.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 09/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class ShipmentsListModel: Mappable {
    var success = false
    var status_code = -1
    var message = ""
    var result: ShipmentsListResult?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result <- map["result"]
    }
}

class ShipmentsListResult: Mappable {
    var array: [[ShipmentsListResultItem]] = []
    var scheduled = [ShipmentsListResultItem]()
    var delivered = [ShipmentsListResultItem]()
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        scheduled <- map["scheduled"]
        delivered <- map["delivered"]
        postMapping()
    }
    
    func postMapping(){
        array.insert(scheduled, at: 0)
        array.insert(delivered, at: 1)
    }
}

class ShipmentsListResultItem: Mappable {
    
    var id: Int
    var destination: String
    var deliveryLocation : String
    var deliveryDate : String
    
    required init?(map: Map) {
        id = 0
        destination = ""
        deliveryLocation = ""
        deliveryDate = ""
     
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        destination <- map["destination"]
        deliveryLocation <- map["delivery_location"]
        deliveryDate <- map["delivery_date"]
    }
    
}
