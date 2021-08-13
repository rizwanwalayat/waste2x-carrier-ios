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
    @IBOutlet weak var tableview : UITableView!
    //MARK: - Variables
    var viewModel: DispatchesDetailVM?
    var isDataLoaded: Bool = false
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableviewHandlings()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.FetchDispatchesDetailData({ data, error, status, message in
            if (status ?? false), error == nil {
                self.isDataLoaded = true
                self.tableview.reloadData()
            } else {
                
            }
        })
    }
    func tableviewHandlings()
    {
        tableview.register(UINib(nibName: "DispatchesDetailStatusCell", bundle: nil), forCellReuseIdentifier: "DispatchesDetailStatusCell")
        tableview.register(UINib(nibName: "DispatchesDetailPickDropCell", bundle: nil), forCellReuseIdentifier: "DispatchesDetailPickDropCell")

        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
    }

    @objc func trackOrderBtnPressed(_ sender: UIButton){
        let trackerVC = TrackerViewController(nibName: "TrackerViewController", bundle: nil)
        self.navigationController?.pushViewController(trackerVC, animated: true)
    }
    @objc func viewOrderDetailBtnPressed(_ sender: UIButton){
        let orderDetailVC = DispatchesOrderDetail(nibName: "DispatchesOrderDetail", bundle: nil)
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
            let cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesDetailStatusCell", for: indexPath) as! DispatchesDetailStatusCell
             cell.trackOrderBtn.addTarget(self, action: #selector(trackOrderBtnPressed(_:)), for: .touchUpInside)
             cell.viewOrderDetailBtn.addTarget(self, action: #selector(viewOrderDetailBtnPressed(_:)), for: .touchUpInside)
            let cellData = viewModel?.data?.result?.details
            let status = viewModel?.data?.result?.dispatchStatus
            cell.configCell(data: cellData, status: status ?? .scheduled)
             return cell
        case 1:
            let cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesDetailPickDropCell", for: indexPath) as! DispatchesDetailPickDropCell
            let cellData = viewModel?.data?.result?.pickup
            cell.configCell(data: cellData, status: DispatchesDeliveryType.pickup)
            return cell
        case 2:
            let cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesDetailPickDropCell", for: indexPath) as! DispatchesDetailPickDropCell
            let cellData = viewModel?.data?.result?.delivery
            cell.configCell(data: cellData, status: DispatchesDeliveryType.delivery)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
