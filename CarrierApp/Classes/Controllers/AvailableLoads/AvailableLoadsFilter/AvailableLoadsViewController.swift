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
    
    
    // MARK: - Controllers LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel = AvailabelLoadsViewModel()
        self.fetchLoads()
    }


    // MARK: - Actions
    
    @IBAction func applyPressed(_ sender: Any) {
        let vc = AvailableLoadsListViewController(nibName: "AvailableLoadsListViewController", bundle: nil)
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc , animated: true)
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        
        clearAllFields()
    }
    
    
    func setupDropdownCountryFields()
    {
        guard let countryNames = viewModel?.data?.result?.countries.map({ $0.name }) else {return}
        guard let countryIds = viewModel?.data?.result?.countries.map({ $0.id }) else {return}
        
        setupDropDownsData(pickupCountryTextField, countryNames, dataIds: countryIds) { selectedString, id in
            self.pickupCountryTextField.text = selectedString
            self.paramsData["pick_country"] = selectedString
            self.fetchStates(id, self.pickupStateTextField)
        }
        
        
        setupDropDownsData(dropOffCountryTextField, countryNames, dataIds: countryIds) { selectedString, id in
            self.dropOffCountryTextField.text = selectedString
            self.paramsData["drop_country"] = selectedString
            self.fetchStates(id, self.dropOffStateTextField)
        }
        
    }
    
    func setupDropDownStatesFields()
    {
        
        guard let statesNames = viewModel?.statesData?.states?.map({ $0.name }) else {return}
        guard let statesIds = viewModel?.statesData?.states?.map({ $0.id }) else {return}
        
        setupDropDownsData(pickupStateTextField, statesNames, dataIds: statesIds) { selectedString, id in
            self.pickupStateTextField.text = selectedString
            self.paramsData["pick_state"] = selectedString
            self.fetchCities(5, self.pickupCityTextField)
        }
        
        setupDropDownsData(dropOffStateTextField, statesNames, dataIds: statesIds) { selectedString, id in
            self.dropOffStateTextField.text = selectedString
            self.paramsData["drop_state"] = selectedString
            self.fetchCities(5, self.dropOffCityTextField)
        }
    }
    
    func setupDropdownCitiesFields()
    {
        
        guard let citiesNames = viewModel?.citiesData?.citties?.map({ $0.name }) else {return}
        guard let citiesIds = viewModel?.citiesData?.citties?.map({ $0.id }) else {return}
        
        setupDropDownsData(pickupCityTextField, citiesNames, dataIds: citiesIds) { selectedString, id in
            self.pickupCityTextField.text = selectedString
            self.paramsData["pick_city"] = selectedString
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
        self.pickupStateTextField.text = ""
        self.pickupCityTextField.text = ""
        self.dropOffCountryTextField.text = ""
        self.dropOffStateTextField.text = ""
        self.dropOffCityTextField.text = ""
        self.paramsData.removeAll()
    }
    
}


// MARK:- API Related Methods

extension AvailableLoadsViewController {
    
    func fetchLoads()
    {
        viewModel?.FetchLoads(params: paramsData, { data, error, success, message in
            
            if success ?? false, error == nil {
                
                self.setupDropdownCountryFields()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
            
        })
    }
    
    func fetchStates(_ id : Int, _ anchorView : DropDown)
    {
        
        let params = ["country_id": id]
        viewModel?.FetchStates(params: params, { data, error, success, message in
            
            if success ?? false, error == nil {
                
                self.setupDropDownStatesFields()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
            
        })
    }
    
    func fetchCities(_ id : Int, _ anchorView : DropDown)
    {
        
        let params = ["state_id": id]
        viewModel?.FetchCities(params: params, { data, error, success, message in
            
            if success ?? false, error == nil {
                
                self.setupDropdownCitiesFields()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
            
        })
    }
}

