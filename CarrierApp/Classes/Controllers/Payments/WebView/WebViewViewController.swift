//
//  WebViewViewController.swift
//  CarrierApp
//
//  Created by MAC on 27/10/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: BaseViewController {

    
    //MARK: Declarations
    
    
    var webView   : WKWebView!
    var urlString =  ""
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var mainView : UIView!
    
    
    //MARK: Controllers LifeCycle
    
    override func loadView()
    {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.mainView = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.appColor
        self.navigationController?.topViewController?.title = "Create Payment Account"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Utility.showLoading()
        if Utility.isConnectedToNetwork() == false {
            DispatchQueue.main.async {
                Utility.hideLoading()
            }
            let alertController = UIAlertController.init(title: NSLocalizedString("ID_ERROR", comment: ""), message: NSLocalizedString("NO_INTERNET_TITLE", comment: " "), preferredStyle: .alert)
            let okAction    = UIAlertAction(title:  NSLocalizedString("ID_OK", comment: ""), style: .default) { (action) in
                print("Ok Pressed")
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(okAction)
            present(alertController, animated: false, completion: nil)
            return
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Utility.hideLoading()
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension WebViewViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("pageLoadingFinish")
        Utility.hideLoading()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        print("didFailProvisionalNavigation")
        let vc = AvailableLoadsViewController(nibName: "AvailableLoadsViewController", bundle: nil)
        Utility.setupRoot([vc], navgationController: self.navigationController)
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail")
        let vc = AvailableLoadsViewController(nibName: "AvailableLoadsViewController", bundle: nil)
        Utility.setupRoot([vc], navgationController: self.navigationController)
    }
    
}
