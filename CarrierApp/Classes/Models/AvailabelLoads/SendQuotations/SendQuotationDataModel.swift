

import Foundation
import ObjectMapper

class SendQuotationDataModel : Mappable {
	var success = false
	var message = ""

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["success"]
		message <- map["message"]
	}

}
