//
//  QuotationListViewController.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class DispatchesTrackingViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var mainHolderView : UIView!
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainHolderView.addGradient(colors: [UIColor(hexString: "FFFFFF").cgColor, UIColor(hexString: "F0F2F4").cgColor])
        
        tableviewHandlings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        mainHolderView.layer.cornerRadius = 36
        mainHolderView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    
    func tableviewHandlings()
    {
        tableview.register(UINib(nibName: "DispatchesTrackingStatusCell", bundle: nil), forCellReuseIdentifier: "DispatchesTrackingStatusCell")
        tableview.register(UINib(nibName: "DispatchesTrackingDetailsCell", bundle: nil), forCellReuseIdentifier: "DispatchesTrackingDetailsCell")

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

extension DispatchesTrackingViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesTrackingStatusCell", for: indexPath) as! DispatchesTrackingStatusCell
             cell.trackOrderBtn.addTarget(self, action: #selector(trackOrderBtnPressed(_:)), for: .touchUpInside)
             cell.viewOrderDetailBtn.addTarget(self, action: #selector(viewOrderDetailBtnPressed(_:)), for: .touchUpInside)
             return cell
        case 1:
            let cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesTrackingDetailsCell", for: indexPath) as! DispatchesTrackingDetailsCell
            cell.configCell(DispatchesDeliveryType.pickup)
            return cell
        case 2:
            let cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesTrackingDetailsCell", for: indexPath) as! DispatchesTrackingDetailsCell
            cell.configCell(DispatchesDeliveryType.delivery)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = DispatchesTrackingStatusCell(nibName: "DispatchesTrackingStatusCell", bundle: nil)
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }
}
