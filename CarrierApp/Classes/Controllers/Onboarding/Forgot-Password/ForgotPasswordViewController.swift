//
//  LoginViewController.swift
//  Haid3r
//
//  Created by a on 02/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import UIKit
//import LocalAuthentication

class ForgotPasswordViewController: BaseViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var enterYourPhoneLabel  : UILabel!
    @IBOutlet weak var weWillSendYouLabel   : UILabel!
    @IBOutlet weak var phoneNoTextField     : UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var resetButton           : UIButton!
    
    //MARK:- Variables
   
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: - SetupView
    func setupView() {
        resetButton.makeEnable(value: false)
    }
    
    
    //MARK: - IBActions
    

    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if Utility.isTextFieldHasText(textField: phoneNoTextField)
        {
            let codeVC = CodeVerificationViewController(nibName: "CodeVerificationViewController", bundle: nil)
            self.navigationController?.pushViewController(codeVC, animated: true)
            
            CodeVerification.verificationCode(phoneNumber: phoneNoTextField.text ?? "") { result, error, status,message in
                
                if error == nil {
                    
                }
                else {
                    
                    Utility.showAlertController(self, error!.localizedDescription)
                    
                }
            }
        }
    }
    @IBAction func backToLoginPressed(_ sender: Any) {
    
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
extension ForgotPasswordViewController : UITextFieldDelegate {
    
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == phoneNoTextField {
            if textField.text?.count == 0 && string != "+" {
                textField.text = "+"
            }
        }
        
        if phoneNoTextField.text!.count > 11  {
            resetButton.makeEnable(value: true)
        }
        else {
            resetButton.makeEnable(value: false)
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Utility.selectTextField(textField.superview!, isSelected: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEmpty {
            Utility.selectTextField(textField.superview!, isSelected: false)
        }
    }
}




//enum BiometricType {
//    case none
//    case touchID
//    case faceID
//}
//
//var biometricType: BiometricType {
//    get {
//        let context = LAContext()
//        var error: NSError?
//
//        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
//            print(error?.localizedDescription ?? "")
//            return .none
//        }
//
//        if #available(iOS 11.0, *) {
//            switch context.biometryType {
//            case .none:
//                return .none
//            case .touchID:
//                return .touchID
//            case .faceID:
//                return .faceID
//            }
//        } else {
//            return  .touchID
//        }
//    }
//}
