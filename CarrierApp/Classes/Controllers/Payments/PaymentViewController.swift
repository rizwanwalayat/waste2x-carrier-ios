//
//  PaymentViewController.swift
//  Waste2x
//
//  Created by HaiDer's Macbook Pro on 31/05/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit

class PaymentViewController: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var connectButtonLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectButtonLbl.setAttributedTextInLable("Connect with ", "ffffff", UIFont.poppinMediumFont(withSize: 15), "Stripe", "ffffff", UIFont.poppinBlack(withSize: 20))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        mainView.layer.masksToBounds = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainView.addGradient(colors: [UIColor(hexString: "FFFFFF").cgColor, UIColor(hexString: "F9F9FB").cgColor])
    }

    @IBAction func connectStripeAccount(_ sender: Any) {
        //Utility.homeViewController()
//        CreatePaymentModel.CreatePaymentApiFunction{ result, error, status,message in
//            if let url = URL(string: "\(result!.result)") {
//                UIApplication.shared.open(url)
//            }
//        }
        
        let detailVC = CreatePaymentViewController(nibName: "CreatePaymentViewController", bundle: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
