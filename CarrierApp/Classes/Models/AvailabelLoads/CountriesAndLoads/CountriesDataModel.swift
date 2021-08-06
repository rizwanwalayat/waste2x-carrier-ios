

import Foundation
import ObjectMapper

class CountriesDataModel : Mappable {
	var id = -1
	var region_id = -1
	var name = ""
	var is_active = false

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		region_id <- map["region_id"]
		name <- map["name"]
		is_active <- map["is_active"]
	}

}
