//
//  QuotationDetailViewController.swift
//  CarrierApp
//
//  Created by MAC on 27/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class QuotationDetailViewController: BaseViewController {

    // MARK: - Outlet
    
    @IBOutlet weak var mainHolderView: UIView!
    @IBOutlet weak var quotationNoLabel: UILabel!
    @IBOutlet weak var originDestinationHolderView: UIView!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var originAddressLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var destinationAdressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var transporterLabel: UILabel!
    @IBOutlet weak var transporterValueLabel: UILabel!
    @IBOutlet weak var CommodityLabel: UILabel!
    @IBOutlet weak var CommodityValueLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityValueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var unitValueLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        quotationNoLabel.setAttributedTextInLable("Quote", "1C2439", 16, " #38", "1C2439", 16)
    }

    
    // MARK: - Actions
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        
        let actionVc = QuotationActionViewController(nibName: "QuotationActionViewController", bundle: nil)
        actionVc.modalPresentationStyle = .overFullScreen
        actionVc.delegate = self
        self.present(actionVc, animated: false, completion: nil)
    }
    
}


extension QuotationDetailViewController: QuotationActionViewControllerDelegate
{
    func quotationAccepted() {
        print("accepted")
    }
    
    func quotationRejected() {
        print("rejected")
    }
    
    
}
