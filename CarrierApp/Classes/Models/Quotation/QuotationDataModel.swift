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
    var result : QuotationListResult?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {

        success <- map["success"]
        status_code <- map["status_code"]
        message <- map["message"]
        result <- map["result"]
    }
}

class QuotationListResult : Mappable {
    var pending : [QuotationStatusResult]?
    var revise : [QuotationStatusResult]?
    var contract_sent : [QuotationStatusResult]?
    var contract_signed : [QuotationStatusResult]?
    var accepted : [QuotationStatusResult]?
    var rejected : [QuotationStatusResult]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        pending <- map["pending"]
        revise <- map["revise"]
        contract_sent <- map["contract_sent"]
        contract_signed <- map["contract_signed"]
        accepted <- map["accepted"]
        rejected <- map["rejected"]
    }
}

class QuotationStatusResult : Mappable {
    
    var id = -1
    var loadId = -1
    var price = -1
    var status = ""
    var isSigned = Bool()
    var transporterName = ""
    var quotationStatus = QuotationsStatusess.pending

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        loadId <- map["load_id"]
        price <- map["price"]
        status <- map["status"]
        transporterName <- map["transporter_name"]
        postMapping()
    }
    
    func postMapping () {
        switch status {
        case "Accepted":
            quotationStatus = .accepted
        case "Rejected":
            quotationStatus = .rejected
        case "Revise":
            quotationStatus = .revise
        case "Pending":
            quotationStatus = .pending
        case "Contract Sent":
            quotationStatus = .contract_sent
        case "Contract Signed":
            quotationStatus = .contract_signed
        default:
            quotationStatus = .none
        }
    }
}

enum QuotationsStatusess: String {
    case accepted = "Accepted"
    case rejected = "Rejected"
    case revise = "Revise"
    case pending = "Pending"
    case contract_sent = "Contract Sent"
    case contract_signed = "Contract Signed"
    case none = ""
    
    var statusCode : String {
        switch self {
        
        case .accepted:
            return "8BC46C"
        case .rejected:
            return "E74C3C"
        case .revise:
            return "FC9805"
        case .pending:
            return "FC9805"
        case .contract_sent:
            return "FBC707"
        case .contract_signed:
            return "FBC707"
        case .none:
            return ""
        }
    }
}

// MARK:- is for quotation Detail

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
    var quotationStatus = QuotationsStatusess.pending

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
        postMapping()
    }

    func postMapping () {
        switch status {
        case "Accepted":
            quotationStatus = .accepted
        case "Rejected":
            quotationStatus = .rejected
        case "Revise":
            quotationStatus = .revise
        case "Pending":
            quotationStatus = .pending
        case "Contract Sent":
            quotationStatus = .contract_sent
        case "Contract Signed":
            quotationStatus = .contract_signed
        default:
            quotationStatus = .none
        }
    }
    
}

// MARK: - isForQuotationResponse
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
