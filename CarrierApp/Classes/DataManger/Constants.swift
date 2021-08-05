//
//  Constants.swift
//  Haid3r
//
//  Created by a on 04/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import UIKit

var kApplicationWindow = Utility.getAppDelegate()!.window
var googleAPIKey = "AIzaSyBp9ntlNiyAFvV8qxdXrBvBAOz_xasmvS0"




struct APIRoutes {
    static var baseUrl = "https://enmass-cache-programme.appspot.com/"
    static var imageBaseUrl = "/api/shared/user/userImage"
    
    // MARK: End Ponints
    static var login = "carriers/api/login"
    static var faqs = "carriers/api/fetch_faqs/1"
}
struct FireBaseVariables {
    static var fireBaseToken = ""
}
