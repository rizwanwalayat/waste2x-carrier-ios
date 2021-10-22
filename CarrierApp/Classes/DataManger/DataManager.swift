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
    
}

// MARK: - Methods for get values
extension DataManager
{
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
    }
}
