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
    static var login = "carriers/api/login"
    static var loads = "carriers/api/loads"
}
struct FireBaseVariables {
    static var fireBaseToken = ""
}
