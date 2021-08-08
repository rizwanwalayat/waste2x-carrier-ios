

import Foundation
import ObjectMapper

class StatesDataModel : Mappable {
	var success = false
	var message = ""
	var states : [StatesResult]?

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["success"]
		message <- map["message"]
        states <- map["result"]
	}

}
