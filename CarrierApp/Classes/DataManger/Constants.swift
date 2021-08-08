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
    static var loads = "carriers/api/loads"
    static var send_code = "carriers/api/send_code"
    static var verify_otp = "carriers/api/verify_code"
    static var reset_password = "carriers/api/update_password"
    static var loads = "carriers/api/loads"
    static var states = "carriers/api/states"
    static var cities = "carriers/api/cities"
}
struct FireBaseVariables {
    static var fireBaseToken = ""
}
