//
//  LoginViewController.swift
//  Haid3r
//
//  Created by a on 02/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import UIKit
import ADCountryPicker

//import LocalAuthentication

class ForgotPasswordViewController: BaseViewController {
    
    //MARK:- IBOutlets

    @IBOutlet weak var stackView            : UIStackView!
    @IBOutlet weak var phoneNoTextField     : UITextField!
    @IBOutlet weak var resetButton          : UIButton!
    @IBOutlet weak var countryIconImgView   : UIImageView!
    @IBOutlet weak var countryDialCodeLbl   : UILabel!
    @IBOutlet weak var countryCodeView: UIView!
    
    //MARK:- Variables
    var viewModel: ForgotPasswordVM?
    var picker = ADCountryPicker()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCountryPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = ForgotPasswordVM()
    }
    
    //MARK: - SetupView
    func setupView() {
        stackView.spacing = onboardingEstimatedSpcing
        resetButton.makeEnable(value: false)
    }
    
    
    //MARK: - IBActions
    

    
    @IBAction func resetButtonPressed(_ sender: Any) {
        if Utility.isTextFieldHasText(textField: phoneNoTextField)
        {
            let completePhoneNo = "\(countryDialCodeLbl.text ?? "")\(phoneNoTextField.text ?? "")"
            
            viewModel?.sendOTPCode(phoneNumber: completePhoneNo, { result, error, status, message in
                
                if status ?? false, error == nil {
                    var codeVC = CodeVerificationViewController(nibName: "CodeVerificationViewController", bundle: nil)
                    let codeVM = CodeVerificationVM(phoneFromUser: completePhoneNo, codeFromBackend: result as? String ?? "")
                    codeVC.viewModel = codeVM
                    self.navigationController?.pushViewController(codeVC, animated: true)
                } else {
                    self.showToast(message: error?.localizedDescription ?? message ?? "")
                }
            })
           
        }
    }
    
    @IBAction func selectCountryBtnPressed(_ sender: Any) {
      
        self.present(picker, animated: true, completion: nil)
    }
    
}
extension ForgotPasswordViewController : UITextFieldDelegate {
    
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

//        if textField == phoneNoTextField {
//            if textField.text?.count == 0 && string != "+" {
//                textField.text = "+"
//            }
//        }
        
        if phoneNoTextField.text!.count > 0  {
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

extension ForgotPasswordViewController: ADCountryPickerDelegate {
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        picker.dismiss(animated: true, completion: nil)
        if let flagImage = picker.getFlag(countryCode: code){
            countryIconImgView.image = flagImage
        }
        else if code == "US" {
            countryIconImgView.image = UIImage(named: "US Flag Local")
        }
        countryDialCodeLbl.text = dialCode
    }
    
    func setupCountryPicker(){
        picker.delegate = self
        picker.showCallingCodes = true
        picker.defaultCountryCode = "US"
    }
}

