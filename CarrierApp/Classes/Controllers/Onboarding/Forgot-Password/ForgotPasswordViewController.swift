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

    @IBOutlet weak var stackView            : UIStackView!
    @IBOutlet weak var phoneNoTextField     : UITextField!
    @IBOutlet weak var resetButton          : UIButton!
    
    //MARK:- Variables
    var viewModel: ForgotPasswordVM?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
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
            viewModel?.sendOTPCode(phoneNumber: phoneNoTextField.text ?? "", { result, error, status, message in
                
                if status ?? false, error == nil {
                    var codeVC = CodeVerificationViewController(nibName: "CodeVerificationViewController", bundle: nil)
                    let codeVM = CodeVerificationVM(phoneFromUser: self.phoneNoTextField.text ?? "", codeFromBackend: result as? String ?? "")
                    codeVC.viewModel = codeVM
                    self.navigationController?.pushViewController(codeVC, animated: true)
                } else {
                    self.showToast(message: error?.localizedDescription ?? message ?? "")
                }
            })
           
        }
    }
    
}
extension ForgotPasswordViewController : UITextFieldDelegate {
    
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == phoneNoTextField {
            if textField.text?.count == 0 && string != "+" {
                textField.text = "+"
            }
        }
        
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


