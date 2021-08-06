

import Foundation
import ObjectMapper

class CitiesResult : Mappable {
	var id = -1
	var state_id = -1
	var is_active = false
	var name = ""

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		state_id <- map["state_id"]
		is_active <- map["is_active"]
		name <- map["name"]
	}

}
