//
//  SignupCompleteViewController.swift
//  Haid3r
//
//  Created by a on 02/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import UIKit
//import LocalAuthentication

class SignupCompleteViewController: BaseViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var newPasswordTextField : UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var resetPasswordButton : UIButton!
    
    //MARK:- Variables
    var viewModel: SignupCompleteVM?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    //MARK: - SetupView
    func setupView() {
        stackView.spacing = onboardingEstimatedSpcing
        resetPasswordButton.makeEnable(value: false)
    }
    
    
    //MARK: - IBActions
    @IBAction func passwordResetBtnPressed(_ sender: Any) {
                
        viewModel?.resetPassword(phone: viewModel?.phoneFromUser ?? "", code: viewModel?.codeFromUser ?? "", password: newPasswordTextField.text!, { result, error, status, message in
            self.showToast(message: message ?? error?.localizedDescription ?? "")
            if status ?? false, error == nil{
                let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        })
    }
    
    @IBAction func fledValueChanged(_ sender: Any) {
        
        print(newPasswordTextField.text!, confirmPasswordTextField.text!)
        resetPasswordButton.makeEnable(value: checkPasswords(newPassword: newPasswordTextField, confirmPassword: confirmPasswordTextField))
    }
    
    
    // MARK: - Functions
    func checkPasswords(newPassword: UITextField, confirmPassword: UITextField) -> Bool {
        return Utility.isTextFieldHasText(textField: newPassword) && Utility.isTextFieldHasText(textField: confirmPassword) && newPassword.text!.count >= 6 && newPassword.text! == confirmPassword.text!
    }
   
}

extension SignupCompleteViewController : UITextFieldDelegate {
    
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//
//    print(newPasswordTextField.text!, confirmPasswordTextField.text!)
//        resetPasswordButton.makeEnable(value: checkPasswords(newPassword: newPasswordTextField, confirmPassword: confirmPasswordTextField))
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Utility.selectTextField(textField.superview!, isSelected: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEmpty {
            Utility.selectTextField(textField.superview!, isSelected: false)
        }
    }
}
