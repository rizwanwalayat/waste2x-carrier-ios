//
//  LoginCodeVerificationViewController.swift
//  Waste2x
//
//  Created by MAC on 24/05/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit

class CodeVerificationViewController: BaseViewController {

    //MARK:- IBOutlets
    
    @IBOutlet weak var enterCodeSendsToYourPhoneLabel   : UILabel!
    @IBOutlet weak var sendsConfirmationCodeLabel       : UILabel!
    @IBOutlet weak var firstTextField                   : UITextField!
    @IBOutlet weak var secondTextField                  : UITextField!
    @IBOutlet weak var thirdTextField                   : UITextField!
    @IBOutlet weak var fourthTextField                  : UITextField!
    @IBOutlet weak var resendCodeButton                 : UIButton!
    @IBOutlet weak var securityCodeView                 : UIView!
    @IBOutlet weak var nextButton                       : UIButton!
    
    
    //MARK: - Variables
    let device = UIDevice()
//    var phone = ""
    let model = UIDevice.modelName
    
    var enteredPhoneNumber = ""
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributedTextInLable(phoneNo: enteredPhoneNumber)
//        nextButton.makeEnable(value: false)
        firstTextField.becomeFirstResponder()
    }

    //MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkCodeAndResetPassword(){
        let resetPasswordVC = ResetPasswordViewController(nibName: "ResetPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let code = firstTextField.text! + secondTextField.text! + thirdTextField.text! + fourthTextField.text!
        print(code)
        let os = device.systemVersion
        
    }
    
    @IBAction func resendCodeButtonPressed(_ sender: Any) {
        
    }
    
}

//MARK: - TextField Delegate Methods 

extension CodeVerificationViewController: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return adjustTextInPut(textfieldTag: textField.tag, newText: string)
    }
}
