

import Foundation
import ObjectMapper

class LoadsDataModel : Mappable {
	var id = -1
	var vehicle_type = ""
	var quantity = -1
	var pick_up = ""
	var drop_off = ""
	var distance = ""

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		vehicle_type <- map["vehicle_type"]
		quantity <- map["quantity"]
		pick_up <- map["pick_up"]
		drop_off <- map["drop_off"]
		distance <- map["distance"]
	}

}
