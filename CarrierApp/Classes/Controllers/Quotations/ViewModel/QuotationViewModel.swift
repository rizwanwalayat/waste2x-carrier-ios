//
//  QuotationViewModel.swift
//  CarrierApp
//
//  Created by HaiDer's Macbook Pro on 09/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import ObjectMapper

typealias QuotationCompletionHandler = (_ data: QuotationDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void
typealias QuotationDetailCompletionHandler = (_ data: QuotationDetailDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void
typealias QuotationResponceCompletionHandler = (_ data: QuotationResponceDataModel?, _ error: Error?, _ status: Bool?,_ message:String) -> Void

class QuotationViewModel: NSObject{
    
    var data : QuotationDataModel?
    var detaildata : QuotationDetailDataModel?
    var responce : QuotationResponceDataModel?
    
    override init() {
        super.init()
        
    }
    
    func FetchQuotationData(_ completionHandler: @escaping QuotationCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.QuotationApiFunctionCall { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<QuotationDataModel>().map(JSON: newResult as [String : Any]) {
                    
                    self.data = data
                    
                    completionHandler(data, error, status, message)
                    
                } else {
                    
                    completionHandler(nil, error, status, message)
                }
                
            } else {
                completionHandler(nil, error, status, message)
            }
        }
    }
    func FetchQuotationDetailData(qoute:String,_ completionHandler: @escaping QuotationDetailCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.quotationDetailApiFunctionCall(quote: qoute) { result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<QuotationDetailDataModel>().map(JSON: newResult as [String : Any]) {
                    
                    self.detaildata = data
                    
                    completionHandler(data, error, status, message)
                    
                } else {
                    
                    completionHandler(nil, error, status, message)
                }
                
            } else {
                completionHandler(nil, error, status, message)
            }
        }
    }
    func SendQuotationResponceData(responce:String,id:Int,_ completionHandler: @escaping QuotationResponceCompletionHandler) {
        Utility.showLoading()
        APIClient.shared.quotationResponceApiFunctionCall(responce: responce, id: id){ result, error, status, message in
            
            Utility.hideLoading()
            
            if error == nil {
                let newResult = ["result" : result]
                if let data = Mapper<QuotationResponceDataModel>().map(JSON: newResult as [String : Any]) {
                    
                    self.responce = data
                    
                    completionHandler(data, error, status, message)
                    
                } else {
                    
                    completionHandler(nil, error, status, message)
                }
                
            } else {
                completionHandler(nil, error, status, message)
            }
        }
    }
}
