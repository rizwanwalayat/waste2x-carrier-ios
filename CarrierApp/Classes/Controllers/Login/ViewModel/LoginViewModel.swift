//
//  LoginViewModel.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 05/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginViewModel: NSObject {
    
    var data = Observable<LoginUser?>(nil)
    var controller : UIViewController?
    
    func login(phoneNumber: String, password: String) {
        Utility.showLoading()
        APIClient.shared.login(number: phoneNumber, pasword: password) { result, error, status,message in
            Utility.hideLoading()
            
            if error != nil {
                Utility.showAlertController(self.controller!, error?.localizedDescription ?? message)
                return
            }
            
            if status {
                let newResult = ["result" : result]
                if let data = Mapper<LoginUser>().map(JSON: newResult as [String : Any]) {
                    self.data.value = data
                    
                    Utility.setupHomeAsRootViewController()
                }
            } else {
                
                Utility.showAlertController(self.controller!, message)
            }
        }
    }
    
}
