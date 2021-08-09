//
//  ContractsResult.swift
//  CarrierApp
//
//  Created by HaiDer's Macbook Pro on 08/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class ContractsResult : Mappable {
    
    var dispatchContracts = [DispatchContractsModel]()
    var dispatchId = Bool()

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        dispatchContracts <- map["dispatch_contracts"]
        dispatchId <- map["base_contract"]
    }

}
