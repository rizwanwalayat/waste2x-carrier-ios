//
//  LoginViewController.swift
//  Haid3r
//
//  Created by a on 02/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import UIKit
//import LocalAuthentication

class LoginViewController: BaseViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var enterYourPhoneLabel  : UILabel!
    @IBOutlet weak var weWillSendYouLabel   : UILabel!
    @IBOutlet weak var phoneNoTextField     : UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton           : UIButton!
    
    //MARK:- Variables
   
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: - SetupView
    func setupView() {
        loginButton.makeEnable(value: false)
    }
    
    
    //MARK: - IBActions
    

    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AppDelegate.demo {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as UIViewController

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        } else {
            
            if Utility.isTextFieldHasText(textField: phoneNoTextField)
            {
                CodeVerification.verificationCode(phoneNumber: phoneNoTextField.text ?? "") { result, error, status,message in
                    
                    if error == nil {
                        let codeVerificationVC = LoginCodeVerificationViewController(nibName: "LoginCodeVerificationViewController", bundle: nil)
                        Global.shared.phoneNumber = self.phoneNoTextField.text ?? ""
                        self.navigationController?.pushViewController(codeVerificationVC, animated: true)
                    }
                    else {
                        
                        Utility.showAlertController(self, error!.localizedDescription)
                        
                    }
                }
            }
        }
    }
    @IBAction func forgotPasswordPressed(_ sender: Any) {
    
        let forgotPasswordVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
}
extension LoginViewController : UITextFieldDelegate {
    
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == phoneNoTextField {
            if textField.text?.count == 0 && string != "+" {
                textField.text = "+"
            }
        }
        
        if phoneNoTextField.text!.count > 7 && passwordTextField.text!.count > 8 {
            loginButton.makeEnable(value: true)
        }
        else {
            loginButton.makeEnable(value: false)
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
