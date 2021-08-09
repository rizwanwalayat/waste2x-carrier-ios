//
//  QuotationListViewController.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class QuotationListViewController: BaseViewController {
    
    //MARK: - Variables
    
    var viewModel : QuotationViewModel?
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableview : UITableView!
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewHandlings()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        viewModel = QuotationViewModel()
        viewModel?.FetchQuotationData({ result, error, success, message in
            
            if success ?? false, error == nil {
                self.tableview.reloadData()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )

            }
        })
        
    }
        
    func tableviewHandlings()
    {
        tableview.register(UINib(nibName: "QuotationsTableViewCell", bundle: nil), forCellReuseIdentifier: "QuotationsTableViewCell")
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
    }

}

extension QuotationListViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.data?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "QuotationsTableViewCell", for: indexPath) as! QuotationsTableViewCell
        if let dataOfModel = viewModel?.data?.result[indexPath.row] {
            if dataOfModel.status == "Contract Sent"{
                cell.configCell(.accepted)
            }
            else{
                cell.configCell(.rejected)
            }
            cell.TransporterValueLabel.text = dataOfModel.transporterName
            cell.quotationLabel.text =  "Quote #\(dataOfModel.id)"
            cell.postLabel.text = "post #\(dataOfModel.loadId)"
            cell.priceValueLabel.text = "\(dataOfModel.price)"
            cell.TransporterValueLabel.text = dataOfModel.transporterName
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = QuotationDetailViewController(nibName: "QuotationDetailViewController", bundle: nil)
        detailVC.quoteNo = viewModel?.data?.result[indexPath.row].id ?? 00
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
