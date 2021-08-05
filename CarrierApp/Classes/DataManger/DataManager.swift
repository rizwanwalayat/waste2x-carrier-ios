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
}
