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
    var array: [[DispatchesListResultItem]] = []
    var scheduled = [DispatchesListResultItem]()
    var in_transit = [DispatchesListResultItem]()
    var delivered = [DispatchesListResultItem]()
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        scheduled <- map["scheduled"]
        in_transit <- map["in_transit"]
        delivered <- map["delivered"]
        postMapping()
    }
    
    func postMapping(){
        array.insert(scheduled, at: 0)
        array.insert(in_transit, at: 1)
        array.insert(delivered, at: 2)
    }
}
