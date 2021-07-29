//
//  AvailableLoadsViewController.swift
//  CarrierApp
//
//  Created by MAC on 28/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class AvailableLoadsViewController: BaseViewController {

    @IBOutlet weak var pickupLabel: UILabel!
    @IBOutlet weak var pickupCountryTextField: UITextField!
    @IBOutlet weak var pickupStateTextField: UITextField!
    @IBOutlet weak var pickupCityTextField: UITextField!
    @IBOutlet weak var dropOffLabel: UILabel!
    @IBOutlet weak var dropOffStateTextField: UITextField!
    @IBOutlet weak var dropOffCityTextField: UITextField!
    @IBOutlet weak var dropOffCountryTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var clearFilterButton: UIButton!
    
    // MARK: - Variables
    
    var countryData = ["Pakistan", "India", "Australia", "NewZealand", "UK", "USA", "KSA"]
    var cityData = ["Lahore", "Islamabad", "Karachi", "Peshawar", "Rawalpindi", "Multan"]
    var stateData = ["Punjab", "Sindh", "KPK", "Balochistan", "ICT"]
    
    // MARK: - Controllers LifeCycle
    
    // MARK: - Outlets
    override func viewDidLoad() {
        super.viewDidLoad()


    }


    // MARK: - Actions
    
    @IBAction func applyPressed(_ sender: Any) {
        let vc = AvailableLoadsListViewController(nibName: "AvailableLoadsListViewController", bundle: nil)
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc , animated: true)
    }
    
    @IBAction func clearPressed(_ sender: Any) {
    }
    
    @IBAction func textFieldClickListners(_ sender : UIButton)
    {
        
        switch sender.tag {
        case 0:
            // for pickup country
            showDropDown(pickupCountryTextField, countryData) { selectedText, index in
                
                self.pickupCountryTextField.text = selectedText
                Utility.selectTextField(self.pickupCountryTextField.superview!, isSelected: true)
            }
        
        case 1:
            
            // for pickup state
            showDropDown(pickupStateTextField, stateData) { selectedText, index in
                
                self.pickupStateTextField.text = selectedText
                Utility.selectTextField(self.pickupStateTextField.superview!, isSelected: true)
            }
            
        case 2:
            
            // for pickup city
            showDropDown(pickupCityTextField, cityData) { selectedText, index in
                
                self.pickupCityTextField.text = selectedText
                Utility.selectTextField(self.pickupCityTextField.superview!, isSelected: true)
            }
            
        case 3:
            
            // for dropOff country
            showDropDown(dropOffCountryTextField, countryData) { selectedText, index in
                
                self.dropOffCountryTextField.text = selectedText
                Utility.selectTextField(self.dropOffCountryTextField.superview!, isSelected: true)
            }
            
        case 4:
            
            // for dropOff state
            showDropDown(dropOffStateTextField, stateData) { selectedText, index in
                
                self.dropOffStateTextField.text = selectedText
                Utility.selectTextField(self.dropOffStateTextField.superview!, isSelected: true)
            }
            
        case 5:
            
            // for dropOff city
            showDropDown(dropOffCityTextField, cityData) { selectedText, index in
                
                self.dropOffCityTextField.text = selectedText
                Utility.selectTextField(self.dropOffCityTextField.superview!, isSelected: true)
            }
            
        default: break
            
        }
    }
    
    
    func showDropDown (_ textField : UITextField , _ dropDownData : [String], completionHandler : @escaping( String, Int) -> Void)
    {
        
    }
    
}


