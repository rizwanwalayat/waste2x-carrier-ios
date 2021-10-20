

import Foundation
import ObjectMapper

class SignUpDataModel : Mappable {
	var success = false
	var message = ""
	var result : SignupResult?

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["success"]
		message <- map["message"]
		result <- map["result"]
	}
}


class SignupResult : Mappable {
    var id = -1
    var auth_token = ""
    var image = ""
    var phone = ""
    var email = ""
    var name = ""
    var waste_types = [SignupWaste_types]()

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        auth_token <- map["auth_token"]
        waste_types <- map["waste_types"]
        image <- map["image"]
        phone <- map["phone"]
        email <- map["email"]
        name <- map["name"]
    }

}


class SignupWaste_types : Mappable {
    var id = -1
    var title = ""
    var icon_url = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        icon_url <- map["icon_url"]
    }

}
