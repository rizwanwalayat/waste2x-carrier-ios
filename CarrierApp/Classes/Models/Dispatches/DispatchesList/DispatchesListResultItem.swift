//
//  DispatchesListResult.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 09/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class DispatchesListResultItem: Mappable {
    
    var id: Int
    var date_created: String
    var pick_up: String
    var drop_off: String
    var dispatch_rep: String
    var commodity : String
    var deliveryDate : String
    var weight : String
    
    required init?(map: Map) {
        id = -1
        date_created = ""
        pick_up = ""
        drop_off = ""
        dispatch_rep = ""
        commodity = ""
        deliveryDate = ""
        weight = ""
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        date_created <- map["date_created"]
        pick_up <- map["pick_up"]
        drop_off <- map["drop_off"]
        dispatch_rep <- map["dispatch_rep"]
        commodity <- map["commodity"]
        deliveryDate <- map["delivery_date"]
        weight <- map["weight"]
    }
    
}
