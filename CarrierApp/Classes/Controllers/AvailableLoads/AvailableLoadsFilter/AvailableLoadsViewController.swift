//
//  AvailableLoadsViewController.swift
//  CarrierApp
//
//  Created by MAC on 28/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit
import iOSDropDown

class AvailableLoadsViewController: BaseViewController{

    // MARK: - Outlets
    
    @IBOutlet weak var pickupLabel: UILabel!
    @IBOutlet weak var pickupCountryTextField: DropDown!
    @IBOutlet weak var pickupStateTextField: DropDown!
    @IBOutlet weak var pickupCityTextField: DropDown!
    @IBOutlet weak var dropOffLabel: UILabel!
    @IBOutlet weak var dropOffStateTextField: DropDown!
    @IBOutlet weak var dropOffCityTextField: DropDown!
    @IBOutlet weak var dropOffCountryTextField: DropDown!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var clearFilterButton: UIButton!
    
    
    // MARK: - Variables
    
    var countryData = ["Pakistan", "India", "Australia", "NewZealand", "UK", "USA", "KSA"]
    var cityData = ["Lahore", "Islamabad", "Karachi", "Peshawar", "Rawalpindi", "Multan"]
    var stateData = ["Punjab", "Sindh", "KPK", "Balochistan", "ICT"]
    
    
    // MARK: - Controllers LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDropdownFields()
    }


    // MARK: - Actions
    
    @IBAction func applyPressed(_ sender: Any) {
        let vc = AvailableLoadsListViewController(nibName: "AvailableLoadsListViewController", bundle: nil)
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc , animated: true)
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        
        clearAllFields()
    }
    
    
    func setupDropdownFields()
    {
        setupDropDownsData(pickupCountryTextField, countryData) { selectedString, atIndex in
            self.pickupCountryTextField.text = selectedString
        }
        
        setupDropDownsData(pickupStateTextField, stateData) { selectedString, atIndex in
            self.pickupStateTextField.text = selectedString
        }
        
        setupDropDownsData(pickupCityTextField, cityData) { selectedString, atIndex in
            self.pickupCityTextField.text = selectedString
        }
        
        setupDropDownsData(dropOffCountryTextField, countryData) { selectedString, atIndex in
            self.dropOffCountryTextField.text = selectedString
        }
        
        setupDropDownsData(dropOffStateTextField, stateData) { selectedString, atIndex in
            self.dropOffStateTextField.text = selectedString
        }
        
        setupDropDownsData(dropOffCityTextField, cityData) { selectedString, atIndex in
            self.dropOffCityTextField.text = selectedString
        }
    }
    
    
    func setupDropDownsData(_ fieldView : DropDown, _ dataSource: [String], _ compeletionHandler : @escaping(String, Int) -> Void)
    {
        fieldView.optionArray = dataSource
        fieldView.rowHeight = 40
        fieldView.listHeight = CGFloat(40 * countryData.count)
        fieldView.didSelect{(selectedText , index ,id) in
            compeletionHandler(selectedText, index)
        }
    }
    
    func clearAllFields()
    {
        self.pickupCountryTextField.text = ""
        self.pickupStateTextField.text = ""
        self.pickupCityTextField.text = ""
        self.dropOffCountryTextField.text = ""
        self.dropOffStateTextField.text = ""
        self.dropOffCityTextField.text = ""
    }
    
}


