//
//  CreatePaymentViewController.swift
//  Waste2x
//
//  Created by HaiDer's Macbook Pro on 01/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit

class CreatePaymentViewController: BaseViewController {
    
    @IBOutlet weak var idTitle: UITextField!
    @IBOutlet weak var emailTitle: UITextField!
    @IBOutlet weak var informationText: UILabel!
    @IBOutlet weak var emailStackView: UIStackView!
    
    
    var id : String?
    var email : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        informationText.setAttributedTextInLable("Your payment account is Connected with ", "1C2439", UIFont.poppinMediumFont(withSize: 16), "Stripe", "1C2439", UIFont.poppinSemiBoldFont(withSize: 16))
    }
    
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        

    }

}
