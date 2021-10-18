//
//  QuotationListViewController.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DispatchesDetailViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!
    
    //MARK: - Variables
    
    var viewModel: DispatchesDetailVM?
    var isDataLoaded: Bool = false
//    var selectedState = DispatchesActionsType.departToPickup
    var selectedState = 0
    var dispatchStates = DispatchesActionsType.allCases
    var deliveryType = DispatchesDeliveryType.none
    var isSwitchButtonOn = false
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewHandlings()
        locationPermissionHandlings()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadDispatchesDetails()
    }
    
    private func loadDispatchesDetails() {
        viewModel?.FetchDispatchesDetailData({ data, error, status, message in
            if (status ?? false), error == nil {
                self.isDataLoaded = true
                self.dataPopulateHandlings()
                self.tableView.reloadData()

            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
        })
    }
    
    private func tableviewHandlings()
    {
        tableView.register(UINib(nibName: "DispatchesDetailStatusCell", bundle: nil), forCellReuseIdentifier: "DispatchesDetailStatusCell")
        tableView.register(UINib(nibName: "DispatchesDetailPickDropCell", bundle: nil), forCellReuseIdentifier: "DispatchesDetailPickDropCell")

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func locationPermissionHandlings()
    {
        if !isLocationServicesEnabled(){
            alertForAccesLocationMandatory()
        }
    }
    
    private func dataPopulateHandlings()
    {
        if viewModel?.data?.result?.dispatchStatus == .in_transit{
            locationUpdateAndSwitchHandlings(true)
        }
        
        if viewModel?.data?.result?.dispatchStatus == .delivered {
            selectedState = 5
            deliveryType = .none
            locationUpdateAndSwitchHandlings(false)
        }
        else if !Utility.isBlankString(text: viewModel?.data?.result?.delivery?.arrival ?? "") {
            selectedState = 4
            deliveryType = .delivery
        }
        else if !Utility.isBlankString(text: viewModel?.data?.result?.delivery?.departure ?? "") {
            selectedState = 3
            deliveryType = .delivery
        }
        else if !Utility.isBlankString(text: viewModel?.data?.result?.pickup?.arrival ?? "") {
            selectedState = 2
            deliveryType = .delivery
        }
        else if !Utility.isBlankString(text: viewModel?.data?.result?.pickup?.departure ?? "") {
            selectedState = 1
            deliveryType = .pickup
        } else {
            selectedState = 0
            deliveryType = .pickup
        }
        
        
        self.tableView.reloadData()
    }
    
    func sendDisptachAction(action: DispatchesActionsType) {

        viewModel?.sendDispatchAction(action: action, { data, error, status, message in
            if status ?? false, error == nil
            {
                self.loadDispatchesDetails()
                
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
        })
    }
    
    private func sendImage(_ params: [String: Any])
    {
        viewModel?.uploadImageToServer(params, { data, error, status, message in
            
            if status ?? false, error == nil
            {
                self.showToast(message: "Image uploaded successfully" )
                self.loadDispatchesDetails()
                
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
        })
    }
    
    
    fileprivate func locationUpdateAndSwitchHandlings(_ flag : Bool) {
        
        if !flag {
            stopUpdatingLocation()
            
            isSwitchButtonOn = false
//            let indexPath = IndexPath(item: 0, section: 0)
//            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        else {
            startUpdatingLocation()
            
            if !isSwitchButtonOn {
                isSwitchButtonOn = true
//                let indexPath = IndexPath(item: 0, section: 0)
//                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    
}

extension DispatchesDetailViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isDataLoaded ? 3 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchesDetailStatusCell", for: indexPath) as! DispatchesDetailStatusCell
            
            // actions button handlings
             cell.getDirectionsBtn.addTarget(self, action: #selector(getDirectionsBtnPressed(_:)), for: .touchUpInside)
             cell.viewOrderDetailBtn.addTarget(self, action: #selector(viewOrderDetailBtnPressed(_:)), for: .touchUpInside)
            cell.switchButton.isOn = isSwitchButtonOn
            cell.getDirectionsBtn.makeEnable(value: deliveryType != .none)
            
            // data Handlings
            let cellData = viewModel?.data?.result?.details
            let status = viewModel?.data?.result?.dispatchStatus
            cell.configCell(data: cellData, status: status ?? .scheduled)
             return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchesDetailPickDropCell", for: indexPath) as! DispatchesDetailPickDropCell
            
            // cell's button handlings
            cell.departedBtn.tag = indexPath.row
            cell.arrivedBtn.tag = indexPath.row
            cell.departedBtn.addTarget(self, action: #selector(departedPressed(_:)), for: .touchUpInside)
            cell.arrivedBtn.addTarget(self, action: #selector(arrivalPressed(_:)), for: .touchUpInside)
            
            cell.departedBtn.makeEnable(value: false)
            cell.arrivedBtn.makeEnable(value: false)
            
            
            // cell's data handling
            
            if indexPath.row == 1 {
                
                let cellData = viewModel?.data?.result?.pickup
                cell.configCell(data: cellData, status: DispatchesDeliveryType.pickup)
                
                cell.departedBtn.makeEnable(value: selectedState == 0 )
                cell.arrivedBtn.makeEnable(value: selectedState == 1)
                cell.markDepartCompleted(value: selectedState > 0)
                cell.markArrivedCompleted(value: selectedState > 1 )
                
            }
            else if indexPath.row == 2
            {
            
                let cellData = viewModel?.data?.result?.delivery
                cell.configCell(data: cellData, status: DispatchesDeliveryType.delivery)
            
                cell.departedBtn.makeEnable(value: selectedState == 2)
                cell.arrivedBtn.makeEnable(value: selectedState == 3)
                cell.markDepartCompleted(value: selectedState > 2)
                cell.markArrivedCompleted(value: selectedState > 3 )
            }
            
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

//MARK: - Cells Actions

extension DispatchesDetailViewController: DispatchesDetailDelegate
{
    @objc func getDirectionsBtnPressed(_ sender: UIButton){
        
        let trackerVC = TrackerViewController(nibName: "TrackerViewController", bundle: nil)
        let trackerVM = TrackerVM()
        trackerVM.data = viewModel?.data
        trackerVC.viewModel = trackerVM
        trackerVC.deliveryType = deliveryType
        self.navigationController?.pushViewController(trackerVC, animated: true)
    }
    
    @objc func viewOrderDetailBtnPressed(_ sender: UIButton){
        let orderDetailVC = DispatchesOrderDetail(nibName: "DispatchesOrderDetail", bundle: nil)
        orderDetailVC.viewModel = self.viewModel
        self.navigationController?.pushViewController(orderDetailVC, animated: true)
    }
    
    @objc func departedPressed(_ sender: UIButton)
    {
        if sender.tag == 1 && selectedState == 0 {
            
            locationUpdateAndSwitchHandlings(true)
            sendDisptachAction(action: .departToPickup)
        }
        if sender.tag == 2 && selectedState == 2{
            
            sendDisptachAction(action: .departToDeliver)
        }

    }

    @objc func arrivalPressed(_ sender: UIButton)
    {
        if sender.tag == 1 && selectedState == 1{
            
            sendDisptachAction(action: .pickupArrive)
        }
        if sender.tag == 2 && selectedState == 3 {
            
            sendDisptachAction(action: .delivered)
        }
    }

//    @objc func camImagePressed(_ sender: UIButton)
//    {
//        if sender.tag == 1 && selectedState == .pickupImage{
//
//            ImagePickerVC.shared.showImagePickerFromVC(fromVC: self, isGalleryOpen: nil)
//
//        }
//        if sender.tag == 2 && selectedState == .deliveryImage{
//            ImagePickerVC.shared.showImagePickerFromVC(fromVC: self, isGalleryOpen: nil)
//        }
//    }
}

extension DispatchesDetailViewController
{
    
    @objc func locationDataUpdated()
    {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("dispatch_id/\(viewModel?.id ?? 0)")
        ref.getData { error, data in
            if error == nil{
                
                //MARK: - For fireBase Location Again
                
                let lastChildData = data.children.allObjects
                print(lastChildData)
            }
        }
    }
    
    func startUpdatingLocation() {
        LocationManager.shared.startUpdatingLocation()
        FirebaseManager.shared.startUpdatingLocation(dispatchID: viewModel?.id ?? -1, viewModel?.data )
        DataManager.shared.saveDispatchesInTransitData(dispatchID: viewModel?.id ?? -1, viewModel?.data)
    }
    
    func stopUpdatingLocation() {
        LocationManager.shared.stopUpdatingLocation()
        FirebaseManager.shared.stopUpdatingLocation()
        DataManager.shared.removeDispatchesInTransit()
    }
}
