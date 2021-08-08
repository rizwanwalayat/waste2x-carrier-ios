

import Foundation
import ObjectMapper

class StatesResult : Mappable {
	var id = -1
	var country_id = -1
	var short_name = ""
	var is_active = false
	var name = ""

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		country_id <- map["country_id"]
		short_name <- map["short_name"]
		is_active <- map["is_active"]
		name <- map["name"]
	}

}
