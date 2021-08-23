//
//  QuotationListViewController.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class DispatchesDetailViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!
    //MARK: - Variables
    var viewModel: DispatchesDetailVM?
    var isDataLoaded: Bool = false
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewHandlings()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadDispatchesDetails()
    }
    
    func loadDispatchesDetails() {
        viewModel?.FetchDispatchesDetailData({ data, error, status, message in
            if (status ?? false), error == nil {
                self.isDataLoaded = true
                self.tableView.reloadData()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
        })
    }
    
    func tableviewHandlings()
    {
        tableView.register(UINib(nibName: "DispatchesDetailStatusCell", bundle: nil), forCellReuseIdentifier: "DispatchesDetailStatusCell")
        tableView.register(UINib(nibName: "DispatchesDetailPickDropCell", bundle: nil), forCellReuseIdentifier: "DispatchesDetailPickDropCell")

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    @objc func trackOrderBtnPressed(_ sender: UIButton){
        let trackerVC = TrackerViewController(nibName: "TrackerViewController", bundle: nil)
        let trackerVM = TrackerVM()
        trackerVM.data = viewModel?.data
        trackerVC.viewModel = trackerVM
        self.navigationController?.pushViewController(trackerVC, animated: true)
    }
    @objc func viewOrderDetailBtnPressed(_ sender: UIButton){
        let orderDetailVC = DispatchesOrderDetail(nibName: "DispatchesOrderDetail", bundle: nil)
        orderDetailVC.viewModel = self.viewModel
        self.navigationController?.pushViewController(orderDetailVC, animated: true)
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
             cell.trackOrderBtn.addTarget(self, action: #selector(trackOrderBtnPressed(_:)), for: .touchUpInside)
             cell.viewOrderDetailBtn.addTarget(self, action: #selector(viewOrderDetailBtnPressed(_:)), for: .touchUpInside)
            
            let cellData = viewModel?.data?.result?.details
            let status = viewModel?.data?.result?.dispatchStatus
            cell.configCell(data: cellData, status: status ?? .scheduled)
             return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchesDetailPickDropCell", for: indexPath) as! DispatchesDetailPickDropCell
            cell.delegate = self
            let cellData = viewModel?.data?.result?.pickup
            cell.configCell(data: cellData, status: DispatchesDeliveryType.pickup)
            cell.arrivedBtn.makeEnable(value: Utility.isTextFieldHasText(textField: cellData?.departure))
            cell.imageUploadBtn.makeEnable(value: Utility.isTextFieldHasText(textField: cellData?.arrival))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchesDetailPickDropCell", for: indexPath) as! DispatchesDetailPickDropCell
            cell.delegate = self
            let cellData = viewModel?.data?.result?.delivery
            cell.configCell(data: cellData, status: DispatchesDeliveryType.delivery)
            cell.departedBtn.makeEnable(value: Utility.isTextFieldHasText(textField: viewModel?.data?.result?.pickup?.arrival ?? ""))
            cell.arrivedBtn.makeEnable(value: Utility.isTextFieldHasText(textField: cellData?.departure))
            cell.imageUploadBtn.makeEnable(value: Utility.isTextFieldHasText(textField: cellData?.arrival))

            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

//MARK: - Protocol

extension DispatchesDetailViewController: DispatchesDetailDelegate {
    func sendDisptachAction(action: DispatchesActionsType) {
        viewModel?.sendDispatchAction(action: action, { data, error, status, message in
            if status ?? false, error == nil {
                self.loadDispatchesDetails()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
        })
    }
    
    
}
