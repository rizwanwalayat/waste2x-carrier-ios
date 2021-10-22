//
//  ProfileEditVM.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 21/10/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

typealias ProfileEditCompletionHandler = (_ data: Any?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

import Foundation

class ProfileEditVM: NSObject {
    var userName: String?
    var userEmail: String?
    var userPhone: String?
    var userImage: String?
    
    func getUserData(){
        
        guard let user = DataManager.shared.getUsersDetail() else {return}
        userName = user.name
        userEmail = user.email
        userPhone = user.phone
        userImage = user.image
    }
    
    func editUserName(newName: String, _ completionHandler: @escaping ProfileEditCompletionHandler){
        
        Utility.showLoading()
        APIClient.shared.updateUserName(userName: newName) { result, error, success, message in
            
            Utility.hideLoading()
            if success, error == nil {
                completionHandler(result, error, success, message)
            }
        }
    }
}
