

import Foundation
import ObjectMapper

class Others : Mappable {
	var id = -1
	var question = ""
	var answer = ""
	var language_id = -1
	var created_at = ""

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		question <- map["question"]
		answer <- map["answer"]
		language_id <- map["language_id"]
		created_at <- map["created_at"]
	}

}
