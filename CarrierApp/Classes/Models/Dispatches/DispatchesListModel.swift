//
//  DispatchesModel.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 09/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class DispatchesListModel: Mappable {
    var success = false
    var status_code = -1
    var message = ""
    var result: DispatchesListResult?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result <- map["result"]
    }
    

}
