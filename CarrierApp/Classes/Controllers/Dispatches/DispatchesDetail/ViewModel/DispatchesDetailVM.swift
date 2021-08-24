//
//  DispatchesTrackingVM.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 12/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias DispatchesDetailCompletionHandler = (_ data: DispatchesDetailModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void
typealias DispatchActionCompletionHandler = (_ data: Any?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

class DispatchesDetailVM: NSObject {
    var data: DispatchesDetailModel?
    var id = Int()

    override init(){
        super.init()
    }
    
    func FetchDispatchesDetailData(_ completionHandler: @escaping DispatchesDetailCompletionHandler){
        Utility.showLoading()
        APIClient.shared.DispatchesDetailApiFunctionCall(dispatch_id: "\(id)") { result, error, status, message in
            Utility.hideLoading()
            let newResult = ["result": result]

            if status, error == nil, let data = Mapper<DispatchesDetailModel>().map(JSON: newResult as [String : Any]) {
                self.data = data
                completionHandler(data, nil, status, message)
            } else {
                completionHandler(nil, error, status, message)
            }
        }
    }
    
    func sendDispatchAction(action: DispatchesActionsType, _ completionHandler: @escaping DispatchActionCompletionHandler){
        Utility.showLoading()
        APIClient.shared.DispatchActionsApiFunctionCall(dispatch_id: "\(id)", action: action.rawValue) { result, error, status, message in
            Utility.hideLoading()
            if status, error == nil {
                completionHandler(result, error, status, message)
            }
        }
    }
    
    func uploadImageToServer(_ params : [String: Any], _ completionHandler: @escaping DispatchActionCompletionHandler){
        
        var parameters = params
        parameters["dispatch_id"] = id
        Utility.showLoading()
        APIClient.shared.saveDispatchesImage(params: parameters) { result, error, success, message in
            
            Utility.hideLoading()
            if success, error == nil {
                completionHandler(result, error, success, message)
            }
        }
    }
    
    
}

