

import Foundation
import ObjectMapper

class AvailableLoadsResult : Mappable {
	var countries = [CountriesDataModel]()
	var loads = [LoadsDataModel]()

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		countries <- map["countries"]
		loads <- map["loads"]
	}

}
