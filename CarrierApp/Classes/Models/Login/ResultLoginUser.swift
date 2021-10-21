

import Foundation
import ObjectMapper

class ResultLoginUser : Mappable {
	var id = -1
	var name = ""
	var auth_token = ""
    var image = ""
    var phone = ""
    var email = ""

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		auth_token <- map["auth_token"]
        image <- map["image"]
        phone <- map["phone"]
        email <- map["email"]
	}

}
