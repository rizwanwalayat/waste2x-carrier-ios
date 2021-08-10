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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idTitle.text = Global.shared.paymentModel?.result?.accountId
        if Global.shared.paymentModel?.result?.email == "" {
            self.informationText.attributedText = setAttributedTextInLabel(text1: "Your Stripe account exists\n", text2: "but not Verified", size: 18)
            self.emailStackView.isHidden = true
        }
        else
        {
            self.informationText.attributedText = setAttributedTextInLabel(text1:"Your payment account\n",text2: "Already exists",size: 20)
            self.emailTitle.text = Global.shared.paymentModel?.result?.email
            self.emailStackView.isHidden = false
        }
//        informationText.setAttributedTextInLable("Your payment account is Connected with ", "1C2439", UIFont.poppinMediumFont(withSize: 16), "Stripe", "1C2439", UIFont.poppinSemiBoldFont(withSize: 16))
    }
    
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        

    }

}
