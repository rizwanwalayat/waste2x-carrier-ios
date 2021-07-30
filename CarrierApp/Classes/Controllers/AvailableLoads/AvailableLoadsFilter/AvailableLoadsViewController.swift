//
//  AvailableLoadsViewController.swift
//  CarrierApp
//
//  Created by MAC on 28/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class AvailableLoadsViewController: BaseViewController{

    // MARK: - Outlets
    
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
//        switch sender.tag {
//        case 0:
//            // for pickup country
//
//            setUpDropDown(pickupCountryTextField, countryData)
//
//        case 1:
//
//            // for pickup state
//            setUpDropDown(pickupStateTextField, stateData)
//
//        case 2:
//
//            // for pickup city
//            setUpDropDown(pickupCityTextField, cityData)
//
//        case 3:
//
//            // for dropOff country
//            setUpDropDown(dropOffCountryTextField, countryData)
//
//        case 4:
//
//            // for dropOff state
//            setUpDropDown(dropOffStateTextField, stateData)
//
//        case 5:
//
//            // for dropOff city
//            setUpDropDown(dropOffCityTextField, cityData)
//
//        default: break
//
//        }
    }
    
}


