//
//  SignupCompleteViewController.swift
//  Haid3r
//
//  Created by a on 02/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import UIKit
import iOSDropDown
//import LocalAuthentication

class SignupCompleteViewController: BaseViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var wasteCapsityTextField : UITextField!
    @IBOutlet weak var newPasswordTextField : UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton : UIButton!
    @IBOutlet weak var selectWasteField: DropDown!
    
    //MARK:- Variables
    var viewModel: SignupCompleteVM?
    var wasteId = ""
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dropDownHandlings()
    }
    
    
    //MARK: - SetupView
    func setupView() {
        stackView.spacing = onboardingEstimatedSpcing
        createAccountButton.makeEnable(value: false)
    }
    
    func dropDownHandlings()
    {
        selectWasteField.attributedPlaceholder = NSAttributedString(string: "Select Waste",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "A1A4B2")])
        
        guard let wasteTypes = viewModel?.data?.result?.waste_types.map({ $0.title }) else {return}
        guard let Ids = viewModel?.data?.result?.waste_types.map({ $0.id }) else {return}
        
        selectWasteField.optionArray = wasteTypes
        selectWasteField.optionIds = Ids
        selectWasteField.rowHeight = 40
        selectWasteField.checkMarkEnabled = false
        let point = selectWasteField.superview!.convert(selectWasteField.frame.origin, to: self.view)
        let estimatedHeight =  CGFloat(40 * wasteTypes.count)
        let maxHeight = ScreenSize.SCREEN_HEIGHT - point.y - 100 // 100 is bottom margin
        if estimatedHeight > maxHeight{
            
            selectWasteField.listHeight = maxHeight
        }
        else
        {
            selectWasteField.listHeight = estimatedHeight
        }
        selectWasteField.didSelect{(selectedText , index ,id) in
            self.wasteId = "\(id)"
        }
    }
    
    
    //MARK: - IBActions
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        
        viewModel?.createAccount(email: emailTextField.text ?? "", password: newPasswordTextField.text ?? "", wasteIDs: wasteId, capacity: wasteCapsityTextField.text ?? "", { result, error, Success, message in
            
            if Success ?? false, error == nil, result != nil {

                
            } else {
                self.showToast(message: error?.localizedDescription ?? message ?? "")
            }
        })

    }
    
    @IBAction func fledValueChanged(_ sender: Any) {
        
        if Utility.isTextFieldHasText(textField: emailTextField) &&
            Utility.isTextFieldHasText(textField: newPasswordTextField) &&
            Utility.isTextFieldHasText(textField: confirmPasswordTextField) && newPasswordTextField.text!.count >= 6 &&
            confirmPasswordTextField.text!.count >= 6 &&
            newPasswordTextField.text! == confirmPasswordTextField.text! &&
            selectWasteField.text!.count > 0 &&
        Utility.isTextFieldHasText(textField: wasteCapsityTextField){
    
            createAccountButton.makeEnable(value: true)
        }
        else {
            createAccountButton.makeEnable(value: false)
        }
    
    }
    
    
    // MARK: - Functions
    func checkFields() -> Bool {
        return Utility.isTextFieldHasText(textField: emailTextField) &&
            Utility.isTextFieldHasText(textField: newPasswordTextField) &&
            Utility.isTextFieldHasText(textField: confirmPasswordTextField) && newPasswordTextField.text!.count >= 6 &&
            confirmPasswordTextField.text!.count >= 6 &&
            newPasswordTextField.text! == confirmPasswordTextField.text! &&
            Utility.isTextFieldHasText(textField: selectWasteField) &&
        Utility.isTextFieldHasText(textField: wasteCapsityTextField)
        
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
