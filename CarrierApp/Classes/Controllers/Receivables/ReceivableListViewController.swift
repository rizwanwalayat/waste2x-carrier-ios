//
//  ReceivableListViewController.swift
//  CarrierApp
//
//  Created by MAC on 30/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class ReceivableListViewController: BaseViewController {

    
    //MARK: - Variables
    
    var viewModel : ReceiveableViewModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ReceivableLIstTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceivableLIstTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        viewModel = ReceiveableViewModel()
        viewModel?.FetchReceiveableData({ result, error, success, message in
            
            if success ?? false, error == nil {
                self.tableView.reloadData()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )

            }
        })
        
    }
    

}


// MARK: - Tableview Extenstions

extension ReceivableListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel?.data?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivableLIstTableViewCell", for: indexPath) as! ReceivableLIstTableViewCell
        
        if let dataOfModel = viewModel?.data?.result[indexPath.row] {
            
            if dataOfModel.status == "Completed" {
                cell.config(.delivered)
                
            }
            else if dataOfModel.status == "In Transit" {
                cell.config(.inTransit)
                
            }
            else {
                cell.config(.scheduled)
                
            }
            cell.dispatchNoValueLabel.text = dataOfModel.dispatchId
            cell.currencyValueLabel.text = dataOfModel.currency
            cell.outstandingAmountValueLabel.text = dataOfModel.outstandingAmount
            cell.totalAmountValueLabel.text = dataOfModel.total
            cell.receivedAmountValueLabel.text = dataOfModel.receivedAmount
                
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
