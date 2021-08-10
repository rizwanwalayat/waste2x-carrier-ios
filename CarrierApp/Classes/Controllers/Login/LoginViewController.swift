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
    @IBOutlet weak var passwordTextField    : UITextField!
    @IBOutlet weak var loginButton          : UIButton!
    
    //MARK:- Variables
    
    var loginViewModel: LoginViewModel?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        phoneNoTextField.text = "+17734777019"
        passwordTextField.text = "123456"
        //loginButton.makeEnable(value: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loginViewModel = LoginViewModel()
    }
    
    
    //MARK: - IBActions
    @IBAction func loginBtnPressed(_ sender: Any)
    {
        loginViewModel?.login(phoneNumber: phoneNoTextField.text ?? "", password: passwordTextField.text ?? "", { result, error, status, message in
            
            if error != nil {
                self.showToast(message: error?.localizedDescription ?? message ?? "")
                return
            }
            
            if (status ?? false)
            {
                DataManager.shared.saveAuthToken(result?.result?.auth_token ?? "")
                DataManager.shared.savePhoneNumber(self.phoneNoTextField.text ?? "")
                
                Utility.setupHomeAsRootViewController()
            }
            else
            {
                self.showToast(message: message ?? "")
            }
        })
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
        
        if phoneNoTextField.text!.count > 0 {
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
