

import Foundation
import ObjectMapper

class CitiesDataModel : Mappable {
	var success = false
	var message = ""
	var citties : [CitiesResult]?

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["success"]
		message <- map["message"]
        citties <- map["result"]
	}

}
