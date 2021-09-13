//
//  LoginViewController.swift
//  Haid3r
//
//  Created by a on 02/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import UIKit
import Columbus

class LoginViewController: BaseViewController {
    
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var stackView            : UIStackView!
    @IBOutlet weak var phoneNoTextField     : UITextField!
    @IBOutlet weak var passwordTextField    : UITextField!
    @IBOutlet weak var loginButton          : UIButton!
    @IBOutlet weak var countryIconImgView   : UIImageView!
    @IBOutlet weak var countryDialCodeLbl   : UILabel!
    @IBOutlet weak var countryCodeView: UIView!
    
    
    //MARK:- Variables
    
    var loginViewModel: LoginViewModel?

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
//        phoneNoTextField.text = "7734777019"
//        passwordTextField.text = "123456"
        loginButton.makeEnable(value: false)
        stackView.spacing = onboardingEstimatedSpcing
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loginViewModel = LoginViewModel()
    }
    
    
    //MARK: - IBActions
    @IBAction func loginBtnPressed(_ sender: Any)
    {
        let completePhoneNo = "\(countryDialCodeLbl.text ?? "")\(phoneNoTextField.text ?? "")"
        loginViewModel?.login(phoneNumber: completePhoneNo, password: passwordTextField.text ?? "", { result, error, status, message in
            
            if error != nil {
                self.showToast(message: error?.localizedDescription ?? message ?? "")
                return
            }
            
            if (status ?? false)
            {
                DataManager.shared.saveAuthToken(result?.result?.auth_token ?? "")
                DataManager.shared.savePhoneNumber(completePhoneNo)
                
                let vc = AvailableLoadsViewController(nibName: "AvailableLoadsViewController", bundle: nil)
                Utility.setupRoot([vc], navgationController: self.navigationController)
            }
            else
            {
                self.showToast(message: message ?? "")
            }
        })
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
    
        onboardingType = .forgotPass
        let forgotPasswordVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @IBAction func selectCountryBtnPressed(_ sender: Any) {
      
        let countryPicker = CountryPickerViewController(config: CountryPickerConfig(),
                                                        initialCountryCode: "US") { (country) in
            
            self.dismiss(animated: true) {
                self.countryIconImgView.image = country.flagIcon
                self.countryDialCodeLbl.text = "+\(country.dialingCode)"
            }
        }
        present(countryPicker, animated: true)
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        
        onboardingType = .SignUp
        let forgotPasswordVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    @IBAction func textFieldValueChanged(_ sender: Any){
        if phoneNoTextField.text!.count > 0 && passwordTextField.text!.count > 0{
    
            loginButton.makeEnable(value: true)
        }
        else {
            loginButton.makeEnable(value: false)
        }
        
    }
    
}
extension LoginViewController : UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Utility.selectTextField(textField.superview!, isSelected: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEmpty {
            Utility.selectTextField(textField.superview!, isSelected: false)
        }
    }
}
