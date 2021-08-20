//
//  QuotationDetailViewController.swift
//  CarrierApp
//
//  Created by MAC on 27/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class AvailableLoadsDetailViewController: BaseViewController {

    // MARK: - Outlet
    
    @IBOutlet weak var mainHolderView: UIView!
    @IBOutlet weak var quotationNoLabel: UILabel!
    @IBOutlet weak var originDestinationHolderView: UIView!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var originAddressLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var destinationAdressLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityValueLabel: UILabel!
    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var vehicleTypeValueLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceValueLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var provideQuotationLabel: UILabel!
    @IBOutlet weak var provideQuotationTextField: UITextField!
    
    // MARK: - Outlet
    
    
    var viewModel : AvailabelLoadsViewModel?
    var detailVM: AvailabelLoadsDetailViewModel?
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acceptButton.makeEnable(value: false)
        dataPopulate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        detailVM = AvailabelLoadsDetailViewModel()
    }

    
    // MARK: - Actions
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        
        guard let id = viewModel?.loadsDetail?.id else {return }
        guard let price = provideQuotationTextField.text else {return }
        let params : [String : Any] = [ "price": price,
                                       "post_id": id]
        
        detailVM?.sendQuotationRequest(params: params, { data, error, success, message in
            
            if success ?? false, error == nil {
                
                self.showAlerts("Success", data?.message ?? "Quotation has been send successfully !") {
                    
                    let vc = AvailableLoadsViewController(nibName: "AvailableLoadsViewController", bundle: nil)
                    Utility.setupRoot([vc], navgationController: self.navigationController)
                }
                
            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
            
        })
        
    }
    

}

extension AvailableLoadsDetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Utility.selectTextField(textField.superview!, isSelected: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEmpty {
            Utility.selectTextField(textField.superview!, isSelected: false)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text!.count > 0 {
            
            acceptButton.makeEnable(value: true)
        }
        else
        {
            acceptButton.makeEnable(value: false)
        }
    }
}


extension AvailableLoadsDetailViewController{
    
    
    func dataPopulate()
    {
        let orderNo = viewModel?.loadsDetail?.id ?? 0
        quotationNoLabel.setAttributedTextInLable("Order", "1C2439", 16, " #\(orderNo)", "1C2439", 16)
        originAddressLabel.text = viewModel?.loadsDetail?.pick_up ?? "-"
        destinationAdressLabel.text = viewModel?.loadsDetail?.drop_off ?? "-"
        quantityValueLabel.text = "\(viewModel?.loadsDetail?.quantity ?? 0)"
        vehicleTypeValueLabel.text = viewModel?.loadsDetail?.vehicle_type ?? "-"
        distanceValueLabel.text = viewModel?.loadsDetail?.distance ?? "-"
    }
}
