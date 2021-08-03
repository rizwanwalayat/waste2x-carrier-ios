//
//  CreatePaymentViewController.swift
//  Waste2x
//
//  Created by HaiDer's Macbook Pro on 01/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit

class CreatePaymentViewController: BaseViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var idTitle: UITextField!
    @IBOutlet weak var emailTitle: UITextField!
    @IBOutlet weak var informationText: UILabel!
    @IBOutlet weak var emailStackView: UIStackView!
    var id : String?
    var email : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        

    }

}
