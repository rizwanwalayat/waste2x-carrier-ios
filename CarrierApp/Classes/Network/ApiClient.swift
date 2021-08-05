
import UIKit
import Alamofire
import ObjectMapper


class Connectivity {
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

let APIClientDefaultTimeOut = 40.0

class APIClient: APIClientHandler {
//    let headers = ["Authorization": "token " + (DataManager.shared.getUser()?.result?.auth_token ?? "")]
    
    fileprivate var clientDateFormatter: DateFormatter
    var isConnectedToNetwork: Bool?
    
    static var shared: APIClient = {
        let baseURL = URL(fileURLWithPath: APIRoutes.baseUrl)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIClientDefaultTimeOut
        
        let instance = APIClient(baseURL: baseURL, configuration: configuration)
        
        return instance
    }()
    
    // MARK: - init methods
    
    override init(baseURL: URL, configuration: URLSessionConfiguration, delegate: SessionDelegate = SessionDelegate(), serverTrustPolicyManager: ServerTrustPolicyManager? = nil) {
        clientDateFormatter = DateFormatter()
        
        super.init(baseURL: baseURL, configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
        
        //        clientDateFormatter.timeZone = NSTimeZone(name: "UTC")
        clientDateFormatter.dateFormat = "yyyy-MM-dd" // Change it to desired date format to be used in All Apis
    }
    
    
    // MARK: Helper methods
    
    func apiClientDateFormatter() -> DateFormatter {
        return clientDateFormatter.copy() as! DateFormatter
    }
    
    fileprivate func normalizeString(_ value: AnyObject?) -> String {
        return value == nil ? "" : value as! String
    }
    
    fileprivate func normalizeDate(_ date: Date?) -> String {
        return date == nil ? "" : clientDateFormatter.string(from: date!)
    }
    
    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func getUrlFromParam(apiUrl: String, params: [String: AnyObject]) -> String {
        var url = apiUrl + "?"
        
        for (key, value) in params {
            url = url + key + "=" + "\(value)&"
        }
        url.removeLast()
        return url
    }
    
    // MARK: - Onboarding
    
    func login(number: String, password: String, _ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["phone": number, "password": password] as [String:String]
        _ = sendRequest(APIRoutes.login , parameters: params as [String : AnyObject],httpMethod: .post , headers: nil, completionBlock: completionBlock)
    }
    func FaqApiFunctionCall(_ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.fetchAuthToken())]
        _ = sendRequest(APIRoutes.faqs , parameters: nil ,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }
}

