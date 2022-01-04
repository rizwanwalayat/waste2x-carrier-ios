//
//  QuotationDetailViewController.swift
//  CarrierApp
//
//  Created by MAC on 27/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class DispatchesOrderDetail: BaseViewController {

    // MARK: - Outlet
    
    @IBOutlet weak var mainHolderView: UIView!
    @IBOutlet weak var quotationNoLabel: UILabel!
    @IBOutlet weak var originDestinationHolderView: UIView!
    @IBOutlet weak var commodityLabel: UILabel!
    @IBOutlet weak var commodityValueLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    @IBOutlet weak var shipperLabel: UILabel!
    @IBOutlet weak var shipperValueLabel: UILabel!
    @IBOutlet weak var consigneeLabel: UILabel!
    @IBOutlet weak var consigneeValueLabel: UILabel!
    @IBOutlet weak var pickupLabel: UILabel!
    @IBOutlet weak var pickupValueLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var deliveryValueLabel: UILabel!
  
    
    
    // MARK: - Variables
    
    var viewModel: DispatchesDetailVM?
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateControllersData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = true
    }

    func populateControllersData()
    {
        quotationNoLabel.text = "\(viewModel?.data?.result?.shipment?.order_id ?? 0)"
        commodityValueLabel.text = viewModel?.data?.result?.shipment?.commodity ?? "-"
        weightValueLabel.text = viewModel?.data?.result?.shipment?.weight != 0 ? "\(viewModel?.data?.result?.shipment?.weight ?? 0)" : "Weight not available."
        shipperValueLabel.text = viewModel?.data?.result?.shipment?.shipper ?? "-"
        consigneeValueLabel.text = viewModel?.data?.result?.shipment?.consignee ?? "-"
        pickupValueLabel.text = viewModel?.data?.result?.shipment?.pickup ?? "-"
        deliveryValueLabel.text = viewModel?.data?.result?.shipment?.delivery ?? "-"
    }
}
