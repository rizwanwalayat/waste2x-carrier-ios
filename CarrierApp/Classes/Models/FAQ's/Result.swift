

import Foundation
import ObjectMapper

class ResultFAQs : Mappable {
	var faqs = [Faqs]()
	var others = [Others]()

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		faqs <- map["faqs"]
		others <- map["others"]
	}

}
