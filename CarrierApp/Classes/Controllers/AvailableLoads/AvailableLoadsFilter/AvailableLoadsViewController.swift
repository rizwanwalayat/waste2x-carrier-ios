//
//  AvailableLoadsViewController.swift
//  CarrierApp
//
//  Created by MAC on 28/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit
import iOSDropDown
import SDWebImage

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
    
    var viewModel : AvailabelLoadsViewModel?
    var paramsData = [String : Any]()
    var placeholderTextCode = "A1A4B2"
    
    // MARK: - Controllers LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldPlaceHolderAdjustment()
        viewModel = AvailabelLoadsViewModel()
        self.fetchLoads(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }


    // MARK: - Actions
    
    @IBAction func applyPressed(_ sender: Any) {
        
        self.isAvailableForApplyFilter()
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        
        clearAllFields()
    }
    

    func textFieldPlaceHolderAdjustment()
    {
        pickupCountryTextField.attributedPlaceholder = NSAttributedString(string: "Country",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: placeholderTextCode)])
        pickupStateTextField.attributedPlaceholder = NSAttributedString(string: "State",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: placeholderTextCode)])
        pickupCityTextField.attributedPlaceholder = NSAttributedString(string: "City",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: placeholderTextCode)])
        dropOffStateTextField.attributedPlaceholder = NSAttributedString(string: "Country",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: placeholderTextCode)])
        dropOffCityTextField.attributedPlaceholder = NSAttributedString(string: "State",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: placeholderTextCode)])
        dropOffCountryTextField.attributedPlaceholder = NSAttributedString(string: "City",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: placeholderTextCode)])
    }
    
    func setupDropdownCountryFields()
    {
        guard let countryNames = viewModel?.data?.result?.countries.map({ $0.name }) else {return}
        guard let countryIds = viewModel?.data?.result?.countries.map({ $0.id }) else {return}
        
        setupDropDownsData(pickupCountryTextField, countryNames, dataIds: countryIds) { selectedString, id in
            self.pickupCountryTextField.text = selectedString
            self.paramsData["pick_country"] = selectedString
            self.fetchStates(id, self.pickupStateTextField, true)
            self.pickupStateTextField.text = ""
            self.pickupCityTextField.text = ""
        }
        
        
        setupDropDownsData(dropOffCountryTextField, countryNames, dataIds: countryIds) { selectedString, id in
            self.dropOffCountryTextField.text = selectedString
            self.paramsData["drop_country"] = selectedString
            self.fetchStates(id, self.dropOffStateTextField, false)
            self.dropOffStateTextField.text = ""
            self.dropOffCityTextField.text = ""
        }
    }
    
    func setupDropDownStatesFieldsForPickup(_ is_set_nil : Bool)
    {
        guard var statesNames = viewModel?.statesPickupData?.states?.map({ $0.name }) else {return}
        guard var statesIds = viewModel?.statesPickupData?.states?.map({ $0.id }) else {return}
        
        if is_set_nil {
            statesNames = []
            statesIds = []
        }
        
        setupDropDownsData(pickupStateTextField, statesNames, dataIds: statesIds) { selectedString, id in
            self.pickupStateTextField.text = selectedString
            self.paramsData["pick_state"] = selectedString
            self.fetchCities(id, self.pickupCityTextField, true)
            self.pickupCityTextField.text = ""
        }
    }
    
    func setupDropDownStatesFieldsForDropoff(_ is_set_nil : Bool)
    {
        guard var statesNames = viewModel?.statesDropOffData?.states?.map({ $0.name }) else {return}
        guard var statesIds = viewModel?.statesDropOffData?.states?.map({ $0.id }) else {return}
        
        if is_set_nil {
            statesNames = []
            statesIds = []
        }
        
        setupDropDownsData(dropOffStateTextField, statesNames, dataIds: statesIds) { selectedString, id in
            self.dropOffStateTextField.text = selectedString
            self.paramsData["drop_state"] = selectedString
            self.fetchCities(id, self.dropOffCityTextField, false)
            self.dropOffCityTextField.text = ""
        }
    }
    
    func setupDropdownCitiesFieldsPickup(_ is_set_nil : Bool)
    {
        
        guard var citiesNames = viewModel?.citiesPickupData?.citties?.map({ $0.name }) else {return}
        guard var citiesIds = viewModel?.citiesPickupData?.citties?.map({ $0.id }) else {return}
        
        if is_set_nil {
            citiesNames = []
            citiesIds = []
        }
        
        setupDropDownsData(pickupCityTextField, citiesNames, dataIds: citiesIds) { selectedString, id in
            self.pickupCityTextField.text = selectedString
            self.paramsData["pick_city"] = selectedString
        }
    }
    
    func setupDropdownCitiesFieldsDropoff(_ is_set_nil : Bool)
    {
        
        guard var citiesNames = viewModel?.citiesDropOffData?.citties?.map({ $0.name }) else {return}
        guard var citiesIds = viewModel?.citiesDropOffData?.citties?.map({ $0.id }) else {return}
        
        if is_set_nil {
            citiesNames = []
            citiesIds = []
        }
        setupDropDownsData(dropOffCityTextField, citiesNames, dataIds: citiesIds) { selectedString, id in
            self.dropOffCityTextField.text = selectedString
            self.paramsData["drop_city"] = selectedString
        }
    }
    
    
    func setupDropDownsData(_ fieldView : DropDown, _ dataSource: [String], dataIds: [Int], _ compeletionHandler : @escaping(String, Int) -> Void)
    {
        fieldView.optionArray = dataSource
        fieldView.optionIds = dataIds
        fieldView.rowHeight = 40
        fieldView.checkMarkEnabled = false
        let point = fieldView.superview!.convert(fieldView.frame.origin, to: self.view)
        let estimatedHeight =  CGFloat(40 * dataSource.count)
        let maxHeight = ScreenSize.SCREEN_HEIGHT - point.y - 100 // 100 is bottom margin
        if estimatedHeight > maxHeight{
            
            fieldView.listHeight = maxHeight
        }
        else
        {
            fieldView.listHeight = estimatedHeight
        }
        fieldView.didSelect{(selectedText , index ,id) in
            compeletionHandler(selectedText, id)
        }
    }
    
    func clearAllFields()
    {
        self.pickupCountryTextField.text = ""
        self.pickupCountryTextField.selectedIndex = nil
        self.pickupStateTextField.text = ""
        self.pickupStateTextField.selectedIndex = nil
        self.pickupCityTextField.text = ""
        self.pickupCityTextField.selectedIndex = nil
        self.dropOffCountryTextField.text = ""
        self.dropOffCountryTextField.selectedIndex = nil
        self.dropOffStateTextField.text = ""
        self.dropOffStateTextField.selectedIndex = nil
        self.dropOffCityTextField.text = ""
        self.dropOffCityTextField.selectedIndex = nil
        self.paramsData.removeAll()
        
        self.setupDropdownCitiesFieldsDropoff(true)
        self.setupDropdownCitiesFieldsPickup(true)
        self.setupDropDownStatesFieldsForDropoff(true)
        self.setupDropDownStatesFieldsForPickup(true)
    }
    
    func isAvailableForApplyFilter()
    {
        if pickupCountryTextField.text!.count > 0 || dropOffCountryTextField.text!.count > 0
        {
            self.fetchLoads(true)
        }
        else
        {
            self.showToast(message: "Please select at-least one filter")
        }
    }
}


// MARK:- API Related Methods

extension AvailableLoadsViewController {
    
    func fetchLoads(_ is_filer_applied: Bool)
    {
        viewModel?.FetchLoads(params: paramsData, { data, error, success, message in
            
            if is_filer_applied{
                let vc = AvailableLoadsListViewController(nibName: "AvailableLoadsListViewController", bundle: nil)
                vc.viewModel = self.viewModel
                self.navigationController?.pushViewController(vc , animated: true)
                return
            }
            
            if success ?? false, error == nil {
                
                self.setupDropdownCountryFields()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
            
        })
    }
    
    func fetchStates(_ id : Int, _ anchorView : DropDown, _ isPickup: Bool)
    {
        
        isPickup ? self.setupDropdownCitiesFieldsPickup(true) : self.setupDropdownCitiesFieldsDropoff(true)
        
        let params = ["country_id": id]
        viewModel?.FetchStates(params: params, isPickup, { data, error, success, message in
            
            if success ?? false, error == nil {
                
                isPickup ? self.setupDropDownStatesFieldsForPickup(false) : self.setupDropDownStatesFieldsForDropoff(false)
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
        })
    }
    
    func fetchCities(_ id : Int, _ anchorView : DropDown, _ isPickup: Bool)
    {
        isPickup ? self.setupDropdownCitiesFieldsPickup(true) : self.setupDropdownCitiesFieldsDropoff(true)
        let params = ["state_id": id]
        viewModel?.FetchCities(params: params, isPickup, { data, error, success, message in
            
            if success ?? false, error == nil {
                
                isPickup ? self.setupDropdownCitiesFieldsPickup(false) : self.setupDropdownCitiesFieldsDropoff(false)
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
        })
    }
}

