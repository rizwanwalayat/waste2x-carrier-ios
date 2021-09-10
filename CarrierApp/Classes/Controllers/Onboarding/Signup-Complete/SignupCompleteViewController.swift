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
    var wasteId = ""
   
    
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
    
    func showCountries()
        {
        guard let wasteTypes = viewModel?.data?.result?.waste_types.map({ $0.title }) else {return}
        guard let Ids = viewModel?.data?.result?.waste_types.map({ $0.id }) else {return}
            let selectionMenu = RSSelectionMenu(selectionStyle: .multiple, dataSource: wasteTypes) { (cell, country, indexPath) in
                
                cell.textLabel?.text = country
                cell.backgroundView?.backgroundColor = .white
                cell.backgroundColor = .white
                // customization
                // set image
                cell.imageView?.image = nil
//                cell.tintColor = APP_COLOUR // #colorLiteral(red: 0.9843137255, green: 0.6039215686, blue: 0.2078431373, alpha: 1)
            }
            
            selectionMenu.onDismiss = { [weak self] selectedItems in
                
                if selectedItems.count > 0
                {
                    
                    for item in selectedItems {
                        
                        let id = self?.viewModel?.data?.result?.waste_types.map({ type -> SignupWaste_types in
                            type.title == item
                            return type
                        })
                       
//                        if let row = self?.viewModel?.data?.result?.waste_types.firstIndex(where: {$0.title == item}) {
//                            let id = self?.viewModel?.data?.result?.waste_types[row].id
//                            print(id)
//                        }
                      

                    }
                    let countryName = selectedItems.first!
                    print(countryName)
                    
                    self?.selectWasteField.text = countryName
                }
                
            }
            
//            // show searchbar
//            selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("id_search_country", comment: ""), barTintColor: UIColor.white) { [weak self] (searchText) -> ([String]) in
//
//                // return filtered array based on any condition
//                // here let's return array where name starts with specified search text
//
//                return countryNames.filter({ $0.lowercased().hasPrefix(searchText.lowercased()) })
//            }
            
        selectionMenu.leftBarButtonTitle = "Cancel"
        selectionMenu.setNavigationBar(title: "Waste Type")
       
            
            // show as PresentationStyle = push
            selectionMenu.show(style: .present, from: self)
        }
    
   
//    func dropDownHandlings()
//    {
//        selectWasteField.attributedPlaceholder = NSAttributedString(string: "Select Waste",
//                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "A1A4B2")])
//
//        guard let wasteTypes = viewModel?.data?.result?.waste_types.map({ $0.title }) else {return}
//        guard let Ids = viewModel?.data?.result?.waste_types.map({ $0.id }) else {return}
//
//        selectWasteField.optionArray = wasteTypes
//        selectWasteField.optionIds = Ids
//        selectWasteField.rowHeight = 40
//        selectWasteField.checkMarkEnabled = false
//        let point = selectWasteField.superview!.convert(selectWasteField.frame.origin, to: self.view)
//        let estimatedHeight =  CGFloat(40 * wasteTypes.count)
//        let maxHeight = ScreenSize.SCREEN_HEIGHT - point.y - 100 // 100 is bottom margin
//        if estimatedHeight > maxHeight{
//
//            selectWasteField.listHeight = maxHeight
//        }
//        else
//        {
//            selectWasteField.listHeight = estimatedHeight
//        }
//        selectWasteField.didSelect{(selectedText , index ,id) in
//            self.wasteId = "\(id)"
//        }
//    }
    
    
    //MARK: - IBActions
    
    @IBAction func wasteTypePressed(_ sender: Any){
        showCountries()
        
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        
        viewModel?.createAccount(email: emailTextField.text ?? "", password: newPasswordTextField.text ?? "", wasteIDs: wasteId, capacity: wasteCapsityTextField.text ?? "", { result, error, Success, message in
            
            if Success ?? false, error == nil, result != nil {

                
            } else {
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
