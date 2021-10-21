//
//  SignupCompleteViewController.swift
//  Haid3r
//
//  Created by a on 02/10/2020.
//  Copyright © 2020 Haider Awan. All rights reserved.
//

import UIKit
import RSSelectionMenu
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
    @IBOutlet weak var selectWasteField: UITextField!
    
    //MARK:- Variables
    var viewModel: SignupCompleteVM?
    var wasteIds = ""
    var selectedWasteTypes = [String]()

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        dropDownHandlings()
//        setupDropDown()
    }
    
    
    //MARK: - SetupView
    func setupView() {
        stackView.spacing = onboardingEstimatedSpcing
        createAccountButton.makeEnable(value: false)
    }
    
    func showWasteTypes()
        {
        guard let wasteTypes = viewModel?.data?.result?.waste_types.map({ $0.title }) else {return}
        
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple, dataSource: wasteTypes) { (cell, waste, indexPath) in
                
                cell.textLabel?.text = waste
                cell.backgroundView?.backgroundColor = .white
                cell.backgroundColor = .white
                cell.imageView?.image = nil
                
            }
        
            selectionMenu.setSelectedItems(items: selectedWasteTypes) { item, index, isSelected, selectedItems in
                self.selectedWasteTypes = selectedItems
            }

        
            selectionMenu.onDismiss = { selectedItems in
                
                if selectedItems.count > 0 {
                    Utility.selectTextField(self.selectWasteField.superview!, isSelected: true)
                    
                    let wasteType = selectedItems.joined(separator: ", ")
                    
                    self.wasteIds = self.viewModel?.data?.result?.waste_types.compactMap({ item in
                        return selectedItems.contains(item.title) ? String(item.id) : nil
                    }).joined(separator: ", ") ?? ""
                    
                    
//                    var wasteType = ""
//
//                    for item in selectedItems {
//
////                        let id = self?.viewModel?.data?.result?.waste_types.map({ type -> SignupWaste_types in
////                            type.title == item
////                            return type
////                        })
//
//                        //  for ids handlings
//                        if let obj = self.viewModel?.data?.result?.waste_types.first(where: {$0.title == item}) {
//
//                            if self.wasteIds.count > 0 {
//
//                                self.wasteIds = "\(self.wasteIds), \(obj.id)"
//                            }
//                            else
//                            {
//                                self.wasteIds = "\(obj.id)"
//                            }
//                        }
//
//                    /// for  title handling
//                        if wasteType.count > 0 {
//
//                            wasteType = "\(wasteType), \(item)"
//                        }
//                        else
//                        {
//                            wasteType = "\(item)"
//                        }
//
//                    }
                    
                    self.selectWasteField.text = wasteType
                }
                else {
                    Utility.selectTextField(self.selectWasteField.superview!, isSelected: false)
                }
                
            }
            
        selectionMenu.leftBarButtonTitle = "Cancel"
        selectionMenu.setNavigationBar(title: "Waste Type")
       
            
            // show as PresentationStyle = push
            selectionMenu.show(style: .present, from: self)
        }
    
    
    //MARK: - IBActions
    
    @IBAction func wasteTypePressed(_ sender: Any){
        showWasteTypes()
        
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        
        viewModel?.createAccount(email: emailTextField.text ?? "", password: newPasswordTextField.text ?? "", wasteIDs: wasteIds, capacity: wasteCapsityTextField.text ?? "", { result, error, Success, message in
            
            if Success ?? false, error == nil, result != nil {

                if let resultString = result?.result?.toJSONString() {
                    DataManager.shared.saveUsersDetail(resultString)
                }
                
                let vc = DispatchesListViewController(nibName: "DispatchesListViewController", bundle: nil)
                Utility.setupRoot([vc], navgationController: self.navigationController)
                
            } else {
                
                DataManager.shared.removeAuthToken()
                self.showToast(message: error?.localizedDescription ?? message ?? "")
            }
        })

    }
    
    @IBAction func fliedValueChanged(_ sender: Any) {
        
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Utility.selectTextField(textField.superview!, isSelected: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEmpty {
            Utility.selectTextField(textField.superview!, isSelected: false)
        }
    }
}
