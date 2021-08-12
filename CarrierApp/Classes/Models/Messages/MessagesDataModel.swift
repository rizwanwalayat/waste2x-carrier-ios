//
//  MessagesDataModel.swift
//  Waste2x
//
//  Created by MAC on 18/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import Foundation
import ObjectMapper

class MessagesDataModel : Mappable
{
    var success = false
    var status_code = -1
    var message = ""
    var result : MessageResult?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        success <- map["success"]
        status_code <- map["status_code"]
        message <- map["message"]
        result <- map["result"]
    }
}
