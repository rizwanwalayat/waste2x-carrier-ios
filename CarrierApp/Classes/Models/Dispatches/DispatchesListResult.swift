//
//  DispatchesListResult.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 09/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class DispatchesListResult: Mappable {
    
    var scheduled = [DispatchesListResultItem]()
    var in_transit = [DispatchesListResultItem]()
    var delivered = [DispatchesListResultItem]()

    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        scheduled <- map["scheduled"]
        in_transit <- map["in_transit"]
        delivered <- map["delivered"]
    }
    
}
