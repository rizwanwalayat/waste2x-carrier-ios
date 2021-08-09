//
//  AvailableLoadsFilterVM.swift
//  CarrierApp
//
//  Created by MAC on 06/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper


typealias AvailabelLoadsFilterCompletionHandler = (_ data: AvailabelLoadsDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

typealias StatesCompletionHandler = (_ data: StatesDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

typealias CitiesCompletionHandler = (_ data: CitiesDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

class AvailabelLoadsViewModel: NSObject {
    
    var data : AvailabelLoadsDataModel?
    var statesPickupData : StatesDataModel?
    var citiesPickupData : CitiesDataModel?
    var statesDropOffData : StatesDataModel?
    var citiesDropOffData : CitiesDataModel?
    var loadsDetail : LoadsDataModel?
    
    override init() {
        super.init()
        
    }
    
    func FetchLoads(params: [String : Any], _ completionHandler: @escaping AvailabelLoadsFilterCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.LoadsApiFunctionCall(params, { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<AvailabelLoadsDataModel>().map(JSON: newResult as [String : Any]) {
                    
                    self.data = data
                    completionHandler(data, error, status, message)
                    
                } else {
                    
                    completionHandler(nil, error, status, message)
                }
                
            } else {
                completionHandler(nil, error, status, message)
            }
        })
    }
    
    func FetchStates(params: [String : Any], _ isPickup: Bool,  _ completionHandler: @escaping StatesCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.StatesApiFunctionCall(params, { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<StatesDataModel>().map(JSON: newResult as [String : Any]) {
                    
                    isPickup ? (self.statesPickupData = data) : (self.statesDropOffData = data)
                    completionHandler(data, error, status, message)
                    
                } else {
                    
                    completionHandler(nil, error, status, message)
                }
                
            } else {
                completionHandler(nil, error, status, message)
            }
        })
    }
    
    func FetchCities(params: [String : Any], _ isPickup: Bool, _ completionHandler: @escaping CitiesCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.CitiesApiFunctionCall(params, { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<CitiesDataModel>().map(JSON: newResult as [String : Any]) {
                    
                    isPickup ? (self.citiesPickupData = data) : (self.citiesDropOffData = data)
                    completionHandler(data, error, status, message)
                    
                } else {
                    
                    completionHandler(nil, error, status, message)
                }
                
            } else {
                completionHandler(nil, error, status, message)
            }
        })
    }
    
    func setDetialData(_ atIndex : Int)
    {
        let loadsData = self.data?.result?.loads[atIndex]
        self.loadsDetail = loadsData
    }
}
