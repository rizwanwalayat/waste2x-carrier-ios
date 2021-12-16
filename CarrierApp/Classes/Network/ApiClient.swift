
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
        let params = ["phone": number, "password": password] as [String : AnyObject]
        _ = sendRequest(APIRoutes.login , parameters: params ,httpMethod: .post , headers: nil, completionBlock: completionBlock)
    }
    func FaqApiFunctionCall(_ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.faqs , parameters: nil ,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }
    
    func SendCodeApi(phone: String, _ completionBlock: @escaping APIClientCompletionHandler){
        let params = ["phone": phone] as [String: AnyObject]
        _ = sendRequest(APIRoutes.send_code, parameters: params , httpMethod: .post, headers: nil, completionBlock: completionBlock)
    }
    
    func SendSignupCodeApi(phone: String, _ completionBlock: @escaping APIClientCompletionHandler){
        let params = ["phone": phone] as [String: AnyObject]
        _ = sendRequest(APIRoutes.sendSignupCode, parameters: params , httpMethod: .post, headers: nil, completionBlock: completionBlock)
    }
    
    func resendSignupCodeApi(phone: String, _ completionBlock: @escaping APIClientCompletionHandler){
        let params = ["phone": phone] as [String: AnyObject]
        _ = sendRequest(APIRoutes.resendSignupCode, parameters: params , httpMethod: .post, headers: nil, completionBlock: completionBlock)
    }
    
    func verifyOTPApi(phone: String, code: String, _ completionBlock: @escaping APIClientCompletionHandler){
        let params = ["phone": phone, "code": code] as [String: AnyObject]
        _ = sendRequest(APIRoutes.verify_otp, parameters: params, httpMethod: .post, headers: nil, completionBlock: completionBlock)
    }
    
    func verifySignupOTPApi(phone: String, code: String, _ completionBlock: @escaping APIClientCompletionHandler){
        var params = ["phone": phone, "code": code] as [String : Any]
        
        if LocationManager.shared.currentLocation != nil {
            params["latitude"] = LocationManager.shared.currentLocation.latitude
            params["longitude"] = LocationManager.shared.currentLocation.longitude
        }
        let prameter = params as [String: AnyObject]
        
        _ = sendRequest(APIRoutes.verifySignupCode, parameters: prameter, httpMethod: .post, headers: nil, completionBlock: completionBlock)
    }
    
    func createAccount(email: String, password: String, wasteIDs: String, capacity: String, _ completionBlock: @escaping APIClientCompletionHandler)
    {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        let params = [ "email": email, "password": password, "waste_types": wasteIDs, "weight_capacity": capacity] as [String: AnyObject]
        _ = sendRequest(APIRoutes.createAccount, parameters: params , httpMethod: .post, headers: headers, completionBlock: completionBlock)
    }
    
    func LoadsApiFunctionCall(_ params: [String : Any], _ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        let parameters = params as [String : AnyObject]
        _ = sendRequest(APIRoutes.loads , parameters: parameters ,httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    func StatesApiFunctionCall(_ params: [String : Any], _ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        let parameters = params as [String : AnyObject]
        _ = sendRequest(APIRoutes.states , parameters: parameters ,httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    func CitiesApiFunctionCall(_ params: [String : Any], _ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        let parameters = params as [String : AnyObject]
        _ = sendRequest(APIRoutes.cities , parameters: parameters ,httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    func resetPasswordApi(phone: String, code: String, password: String, _ completionBlock: @escaping APIClientCompletionHandler){
        let params = ["phone": phone, "code": code, "password": password] as [String: AnyObject]
        _ = sendRequest(APIRoutes.reset_password, parameters: params , httpMethod: .post, headers: nil, completionBlock: completionBlock)
    }
    func ReceivablesApiFunctionCall(_ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.receivables , parameters: nil ,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }
    func QuotationApiFunctionCall(_ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.quotations , parameters: nil ,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }
    func quotationDetailApiFunctionCall(quote: String,_ completionBlock: @escaping APIClientCompletionHandler){
        let params = ["quote_id": quote] as [String:String]
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.quotationsDetail, parameters: params as [String: AnyObject], httpMethod: .post, headers: headers, completionBlock: completionBlock)
    }
    func quotationResponceApiFunctionCall(responce: String,id:Int,_ completionBlock: @escaping APIClientCompletionHandler){
        let params = ["response": responce,"quote_id":id] as [String:AnyObject]
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.quotationsResponce, parameters: params as [String: AnyObject], httpMethod: .post, headers: headers, completionBlock: completionBlock)
    }
    func ContractsApiFunctionCall(_ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.contracts , parameters: nil ,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }
    
    func sendQuotationFunctionCall(_ params: [String: Any], _ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        let parameters = params as [String : AnyObject]
        _ = sendRequest(APIRoutes.create_quotation , parameters: parameters ,httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    func DispatchesListApiFunctionCall(_ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.dispatches , parameters: nil ,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }
        
    func PaymentApiCall(_ completionBlock: @escaping APIClientCompletionHandler) {
        let params = [String : AnyObject]()
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.paymentUrl, parameters: params,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }
    func createPaymentApiCall(_ completionBlock: @escaping APIClientCompletionHandler) {
        let params = [String : AnyObject]()
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.createPaymentUrl, parameters: params,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }
    func DispatchesDetailApiFunctionCall(dispatch_id: String, _ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["dispatch_id": dispatch_id] as [String: AnyObject]
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.dispatchesDetail , parameters: params , httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }

    func fetchTwillioAccessToken(_ completionBlock: @escaping APIClientCompletionHandler)
    {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        
        let phone = DataManager.shared.getUsersDetail()?.phone ?? ""
        let url = "carriers/fetch_twilio_access_token/\(phone)"
        _ = sendRequest(url , parameters: nil ,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }

    func googleLocationPolyLineAPi( _ completionBlock: @escaping APIClientCompletionHandler) {
        let params = [String:AnyObject]()
        rawRequest(url: APIRoutes.polyLineUrl, method: .get, parameters: params, headers: nil, completionBlock: completionBlock)
    }
    
    func DispatchActionsApiFunctionCall(dispatch_id: String, action: String, _ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["dispatch_id": dispatch_id, "action": action ] as [String: AnyObject]
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.dispatchActions , parameters: params , httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    func saveDispatchesImage(params : [String: Any],_ completionBlock: @escaping APIClientCompletionHandler) {

        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        let parameters = params as [String : AnyObject]
        sendRequestUsingMultipart(APIRoutes.postImage, parameters: parameters, headers: headers, completionBlock: completionBlock)
    }
    
    func updateUserName(userName: String,_ completionBlock: @escaping APIClientCompletionHandler) {

        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        let parameters = ["name": userName] as [String: AnyObject]
        _ = sendRequest(APIRoutes.editProfile , parameters: parameters , httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    func saveUserImage(image : UIImage,_ completionBlock: @escaping APIClientCompletionHandler) {
        
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        let parameters = ["image": [image]] as [String: AnyObject]
        let url = APIRoutes.baseUrl + APIRoutes.editProfile
        sendRequestUsingMultipart(url, parameters: parameters, headers: headers, completionBlock: completionBlock)
    }
    
    func createAnotherDispatch(dispatch_id: String, _ completionBlock: @escaping APIClientCompletionHandler) {
        let params = ["trip_id": dispatch_id] as [String: AnyObject]
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.createAnotherLoad , parameters: params , httpMethod: .post , headers: headers, completionBlock: completionBlock)
    }
    
    func ShipmentsListApiFunctionCall(_ completionBlock: @escaping APIClientCompletionHandler) {
        let headers = ["Authorization": "token " + (DataManager.shared.getAuthToken())]
        _ = sendRequest(APIRoutes.shipments , parameters: nil ,httpMethod: .get , headers: headers, completionBlock: completionBlock)
    }
}
