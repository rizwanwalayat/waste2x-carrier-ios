//
//  MessagesViewModel.swift
//  CarrierApp
//
//  Created by MAC on 12/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias MessagesCompletionHandler = (_ data: MessagesDataModel?, _ error: Error?, _ status: Bool?, _ message:String) -> Void

class MessagesViewModel: NSObject{
    
    override init() {
        super.init()
    }
    
    
    func fetchTwillioAccessToken(_ completion: @escaping MessagesCompletionHandler) {
        
        Utility.showLoading()
        APIClient.shared.fetchTwillioAccessToken( { result, error, success, message in

            if result != nil && success {

                let newResult  = ["result" : result!]
                if let data = Mapper<MessagesDataModel>().map(JSON: newResult as [String : Any] ) {
                    completion(data, nil, success,message)
                } else {
                    completion(nil, nil, success,message)
                }

            } else {
                 completion(nil, error, success,message)
            }
        })
        
    }
    
    func refreshAccessToken(_ completion: @escaping MessagesCompletionHandler) {
        
        Utility.showLoading()
        APIClient.shared.fetchTwillioAccessToken( { result, error, success, message in

            if result != nil && success {

                let newResult  = ["result" : result!]
                if let data = Mapper<MessagesDataModel>().map(JSON: newResult as [String : Any] ) {
                    completion(data, nil, success,message)
                } else {
                    completion(nil, nil, success,message)
                }

            } else {
                 completion(nil, error, success,message)
            }
        })
    }
    
}
