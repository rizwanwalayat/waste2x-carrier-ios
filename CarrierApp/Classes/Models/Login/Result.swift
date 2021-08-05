

import Foundation
import ObjectMapper

class ResultLoginUser : Mappable {
	var id = -1
	var name = ""
	var auth_token = ""

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		auth_token <- map["auth_token"]
	}

}
