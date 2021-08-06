

import Foundation
import ObjectMapper

class AvailabelLoadsDataModel : Mappable {
	var success = false
	var message = ""
	var result : AvailableLoadsResult?

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["success"]
		message <- map["message"]
		result <- map["result"]
	}

}
