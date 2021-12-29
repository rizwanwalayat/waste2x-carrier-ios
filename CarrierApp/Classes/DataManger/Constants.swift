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

var app_name = "CarrierApp"
var onboardingType = OnboardingType.SignUp
var defaultSideMenuIndex = 2
struct APIRoutes {
//    static var baseUrl = "https://app.enmassenergy.com/" //Live
    static var baseUrl = "https://enmass-cache-programme.appspot.com/" //Stagging
//    static var baseUrl = "https://cache-admin-panel-production.appspot.com/" //Production
    
    static var imageBaseUrl = "/api/shared/user/userImage"
    
    // MARK: End Ponints
    static var login = "carriers/api/login"
    static var faqs = "carriers/api/fetch_faqs/1"
    static var send_code = "carriers/api/send_code"
    static var verify_otp = "carriers/api/verify_code"
    static var reset_password = "carriers/api/update_password"
    static var loads = "carriers/api/loads"
    static var states = "carriers/api/states"
    static var cities = "carriers/api/cities"
    static var receivables = "carriers/api/receivables"
    static var contracts = "carriers/api/contracts"
    static var quotations = "carriers/api/quotations"
    static var quotationsDetail = "carriers/api/quotations/detail"
    static var quotationsResponce = "carriers/api/quotations/response"
    static var create_quotation = "carriers/api/quotations/create"
    static var dispatches = "carriers/api/dispatches"
    static var paymentUrl = "carriers/api/payments"
    static var createPaymentUrl = "payment_method/api_create_stripe"
    static var dispatchesDetail = "carriers/api/dispatch/detail"
    static var polyLineUrl = ""
    static var dispatchActions = "carriers/api/dispatch_actions"
    static var createAnotherLoad = "carriers/api/create_new_load"
    static var postImage = baseUrl + "carriers/api/pod_upload"
    static var sendSignupCode = "carriers/api/signup/send_code"
    static var resendSignupCode = "carriers/api/signup/resend_code"
    static var verifySignupCode = "carriers/api/signup/verify_code"
    static var createAccount = "carriers/api/signup/select_waste_type"
    static var editProfile = "carriers/api/edit_profile"
    static var shipments = "carriers/api/shipments"


    
}

struct FireBaseVariables {
    static var fireBaseToken = ""
}

enum OnboardingType : String
{
    case SignUp = "Send Code"
    case forgotPass = "Reset My Password"
    
    var FinalViewText : String {
        
        switch self {
        case .SignUp:
            return "Create Account"
            
        case .forgotPass:
            return "Reset"
        
        }
    }
}
