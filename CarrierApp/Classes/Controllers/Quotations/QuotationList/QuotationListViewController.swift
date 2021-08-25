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
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    
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
                self.checkData()
            } else {
                self.showTable(false)
                self.showToast(message: error?.localizedDescription ?? message )

            }
        })
        
    }
        
    func tableviewHandlings()
    {
        tableView.register(UINib(nibName: "QuotationsTableViewCell", bundle: nil), forCellReuseIdentifier: "QuotationsTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func showTable(_ flag: Bool){
        if flag {
            tableView.isHidden = false
            noDataLabel.isHidden = true
        } else {
            tableView.isHidden = true
            noDataLabel.isHidden = false
        }
    }
    func checkData(){
        if let count = viewModel?.data?.result.count, count > 0 {
            self.tableView.reloadData()
            showTable(true)
        } else {
            showTable(false)
        }
    }

}

extension QuotationListViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.data?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuotationsTableViewCell", for: indexPath) as! QuotationsTableViewCell
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
            cell.priceValueLabel.text = "\(dataOfModel.price)".appendDollarSign()
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
