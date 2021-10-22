//
//  DataManager.swift
//  Haid3r
//
//  Created by a on 27/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import Foundation
import ObjectMapper

class DataManager {
    
    static let shared = DataManager()
    
}

// MARK: - Methods for set values
extension DataManager
{
    
    func saveUsersDetail(_ objectString : String) {
        
        UserDefaults.standard.set(objectString, forKey: "user_complete_detal")
    }
    
    func saveAuthToken(_ token : String) {
        
        UserDefaults.standard.set(token, forKey: "auth_token")
    }
    
    func saveDispatchesInTransitData(dispatchID: Int, _ viewModel : DispatchesDetailModel?)
    {
        let dataToString = viewModel!.toJSONString() ?? ""
        let dataDict : [String : Any] = ["id": dispatchID,
                                         "data": dataToString]
        UserDefaults.standard.set(dataDict, forKey: "dispatches_IntransitData")
    }
    
    func saveUserImage(_ userImage : UIImage)
    {
        guard let imageData = userImage.pngData() else {return }
        UserDefaults.standard.set(imageData, forKey: "user_image")
    }
    
    func saveUserName(_ name : String) {
        
        UserDefaults.standard.set(name, forKey: "user_name")
    }
    
}

// MARK: - Methods for get values
extension DataManager
{
    
    func getuserImage() -> (UIImage?, String?)
    {
        if let imageData = UserDefaults.standard.object(forKey: "user_image") as? Data {
            let image = UIImage(data: imageData)
            return (image, nil)
        }
        else if let userDetial = self.getUsersDetail() {
            return (nil, userDetial.image)
        }
        
        return (nil, nil)
    }
    
    func getUserName() -> String
    {
        if let name = UserDefaults.standard.object(forKey: "user_name") as? String {
            return name
        }
        else if let userDetial = self.getUsersDetail() {
            return userDetial.name
        }
       
        return ""
    }
    
    func getUsersDetail() -> ResultLoginUser? {
        
        var user: ResultLoginUser?

        if UserDefaults.standard.object(forKey: "user_complete_detal") != nil {
            user = Mapper<ResultLoginUser>().map(JSONString:UserDefaults.standard.string(forKey: "user_complete_detal")!)
        }
        return user
    }
    
    func getAuthToken() -> String {
        
        if let token = UserDefaults.standard.object(forKey: "auth_token") as? String {
            return token
        }
        else if let userDetial = self.getUsersDetail() {
            return userDetial.auth_token
        }
       
        return ""
    }
    
    func fetchDispatchesInTransitData() -> (Int?, DispatchesDetailModel?)
    {
        var disptches_id : Int? = nil
        var dispatches_data : DispatchesDetailModel? = nil
        
        if let data = UserDefaults.standard.dictionary(forKey: "dispatches_IntransitData") {
            
            if let id = data["id"] as? Int, let dataString = data["data"] as? String {
                disptches_id = id
                
                dispatches_data = Mapper<DispatchesDetailModel>().map(JSONString:dataString)!
                
            }
        }
        
        return (disptches_id, dispatches_data)
    }
    
}

// MARK: - Methods Remove Values
extension DataManager
{
    
    func removeDispatchesInTransit()
    {
        UserDefaults.standard.removeObject(forKey: "dispatches_IntransitData")
    }
    
    func removeUserDetial() {
        
        UserDefaults.standard.removeObject(forKey: "user_complete_detal")
        UserDefaults.standard.removeObject(forKey: "auth_token")
        UserDefaults.standard.removeObject(forKey: "user_image")
        UserDefaults.standard.removeObject(forKey: "user_name")
    }
}
