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
    
    
    func saveAuthToken(_ token : String)
    {
        UserDefaults.standard.set(token, forKey: "auth_token")
    }
    
    func savePhoneNumber(_ token : String)
    {
        UserDefaults.standard.set(token, forKey: "phone_number")
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
    
    func fetchAuthToken() -> String
    {
        var token = ""

        if UserDefaults.standard.string(forKey: "auth_token") != nil {
            token = UserDefaults.standard.string(forKey: "auth_token")!
        }
        return token
    }
    
    func fetchPhoneNumber() -> String
    {
        var token = ""

        if UserDefaults.standard.string(forKey: "phone_number") != nil {
            token = UserDefaults.standard.string(forKey: "phone_number")!
        }
        return token
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
    
// MARK: - Methods Remove Values
    
    func removeAuthToken(){
        UserDefaults.standard.removeObject(forKey: "auth_token")
    }
    
    func removeDispatchesInTransit()
    {
        UserDefaults.standard.removeObject(forKey: "dispatches_IntransitData")
    }
}
