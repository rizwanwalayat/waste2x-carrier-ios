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
    
    @IBOutlet weak var phoneNumberTextField: UILabel!
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
    let model = UIDevice.modelName
    var viewModel: CodeVerificationVM?
   
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumberTextField.text = viewModel?.phoneFromUser
//        self.showToast(message: viewModel?.codeFromBackend ?? "No Code")
        firstTextField.becomeFirstResponder()
    }

    //MARK: - Actions

    func checkCodeAndResetPassword()
    {
        switch onboardingType {
        case .SignUp:
            

            viewModel?.verifySignupOTP(phoneNumber: self.viewModel?.phoneFromUser ?? "", code: self.viewModel?.codeFromUser ?? "", { result, error, status, message in
                if status ?? false, error == nil, result != nil {

                    let signupCompleteVC = SignupCompleteViewController(nibName: "SignupCompleteViewController", bundle: nil)
                    let signupResVM = SignupCompleteVM(responseData: result!)
                    signupCompleteVC.viewModel = signupResVM
                    
                    DataManager.shared.saveAuthToken(result?.result?.auth_token ?? "")
                    DataManager.shared.savePhoneNumber(self.viewModel?.phoneFromUser ?? "")
                    
                    self.navigationController?.pushViewController(signupCompleteVC, animated: true)
                    
                } else {
                    self.showToast(message: error?.localizedDescription ?? message ?? "")
                }
            })
            
            
        case .forgotPass:
            
            viewModel?.verifyOTP(phoneNumber: self.viewModel?.phoneFromUser ?? "", code: self.viewModel?.codeFromUser ?? "", { result, error, status, message in
                if status ?? false, error == nil {
                    let resetPasswordVC = ResetPasswordViewController(nibName: "ResetPasswordViewController", bundle: nil)
                    let resetPasswordVM = ResetPasswordVM(phoneFromUser: self.viewModel?.phoneFromUser ?? "", codeFromUser: self.viewModel?.codeFromUser ?? "")
                    resetPasswordVC.viewModel = resetPasswordVM
                    self.navigationController?.pushViewController(resetPasswordVC, animated: true)
                } else {
                    self.showToast(message: error?.localizedDescription ?? message ?? "")
                }
            })
        }
    }
    
    
    @IBAction func resendCodeButtonPressed(_ sender: Any) {
        
        switch onboardingType {
        case .SignUp:
            
            print("Signup was pressed ... !")
            
            viewModel?.sendSignupOTPCode(phoneNumber: self.viewModel?.phoneFromUser ?? "", { result, error, status, message in
                
                self.showToast(message: error?.localizedDescription ?? message ?? "")
            })
            
        case .forgotPass:
            
            viewModel?.sendOTPCode(phoneNumber: self.viewModel?.phoneFromUser ?? "", { result, error, status, message in
                self.showToast(message: error?.localizedDescription ?? message ?? "")
            })
        }
    }
    
}

//MARK: - TextField Delegate Methods 

extension CodeVerificationViewController: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return adjustTextInPut(textfieldTag: textField.tag, newText: string)
    }
}
