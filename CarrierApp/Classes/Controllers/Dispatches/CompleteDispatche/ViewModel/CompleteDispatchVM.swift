//
//  CompleteDispatchVm.swift
//  CarrierApp
//
//  Created by MAC on 18/10/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

typealias DispatchActionCompletionHandler = (_ data: Any?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

import Foundation

class CompleteDispatchViewModel: NSObject {
    
    
    func compeleteDispatch(_ params : [String: Any], _ completionHandler: @escaping DispatchActionCompletionHandler){
        
        Utility.showLoading()
        APIClient.shared.saveDispatchesImage(params: params) { result, error, success, message in
            
            Utility.hideLoading()
            if success, error == nil {
                completionHandler(result, error, success, message)
            }
        }
    }
}
