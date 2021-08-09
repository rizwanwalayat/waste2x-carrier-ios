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
    
    //MARK: - Variables
    var viewModel : QuotationViewModel?
    var quoteNo = Int()
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quotationNoLabel.setAttributedTextInLable("Quote", "1C2439", 16, " #38", "1C2439", 16)
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.quotationNoLabel.text = "Quote #\(quoteNo)"
        viewModel = QuotationViewModel()
        viewModel?.FetchQuotationDetailData(qoute: "\(quoteNo)", { result, error, success, message in
            
            if success ?? false, error == nil {
                self.dataUpdate()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )

            }
        })
        
    }
    func dataUpdate() {
        if let dataOfModel = viewModel?.detaildata?.result{
            self.originAddressLabel.text = dataOfModel.origin
            self.destinationAdressLabel.text = dataOfModel.destination
            self.statusValueLabel.text = dataOfModel.status
            self.priceValueLabel.text = "$\(dataOfModel.price)"
            self.transporterValueLabel.text = dataOfModel.transporterName
            self.CommodityValueLabel.text = dataOfModel.commodity
            self.quantityValueLabel.text = "\(dataOfModel.quantity)"
            self.unitValueLabel.text = dataOfModel.unit
            
        }
        
        
        
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
        print("Accepted")
        viewModel?.SendQuotationResponceData(responce: "Accepted", id: quoteNo){ result, error, success, message in
            
            if success ?? false, error == nil {
                self.showToast(message: message )
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showToast(message: error?.localizedDescription ?? message )

            }
        }
        
    }
    
    func quotationRejected() {
        print("Rejected")
        viewModel?.SendQuotationResponceData(responce: "Rejected", id: quoteNo){ result, error, success, message in
            if success ?? false, error == nil {
                self.showToast(message: message)
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showToast(message: error?.localizedDescription ?? message )

            }
        }
    }
    
    
}
