

import Foundation
import ObjectMapper

class FAQsDataModel : Mappable {
	var success = false
	var status_code = -1
	var message = ""
	var result : ResultFAQs?

    
	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["success"]
		status_code <- map["status_code"]
		message <- map["message"]
		result <- map["result"]
	}

}
