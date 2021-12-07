//
//  PaymentViewController.swift
//  Waste2x
//
//  Created by HaiDer's Macbook Pro on 31/05/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit

class PaymentViewController: BaseViewController {

    
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var connectButtonLbl: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.setAttributedTextInLable("Your payment account is\n", "1C2439", UIFont.poppinMediumFont(withSize: 16), "not made", "1C2439", UIFont.poppinSemiBoldFont(withSize: 16))
        
        connectButtonLbl.setAttributedTextInLable("Connect with ", "ffffff", UIFont.poppinMediumFont(withSize: 15), "Stripe", "ffffff", UIFont.poppinBlack(withSize: 20))
    }
    
    @IBAction func connectStripeAccount(_ sender: Any) {
       
        CreatePaymentModel.CreatePaymentApiFunction { result, error, status,message in
//            if let url = URL(string: "\(result!.result)") {
//                UIApplication.shared.open(url)
//            }
            let vcHome = AvailableLoadsViewController(nibName: "AvailableLoadsViewController", bundle: nil)
            let vc = WebViewViewController(nibName: "WebViewViewController", bundle: nil)
            vc.urlString = result!.result // "https://www.google.com/"
            self.navigationController?.setViewControllers([vcHome, vc], animated: true)
            
        }
    }
    
    
}
