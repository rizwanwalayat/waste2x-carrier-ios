//
//  ContractsViewController.swift
//  CarrierApp
//
//  Created by MAC on 30/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class ContractsViewController: BaseViewController {

    //MARK: - Variables
    
    var viewModel : ContractsViewModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Controller's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ContractsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractsTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        viewModel = ContractsViewModel()
        viewModel?.FetchContractsData({ result, error, success, message in
            
            if success ?? false, error == nil {
                self.tableView.reloadData()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )

            }
        })
        
    }
}

// MARK: - Tableview Extenstions

extension ContractsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        viewModel?.data?.result?.dispatchContracts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractsTableViewCell", for: indexPath) as! ContractsTableViewCell
        
        if let dataOfModel = viewModel?.data?.result?.dispatchContracts[indexPath.row]{
            if dataOfModel.isSigned == true{
                cell.configCell(.YES)
            }
            else if dataOfModel.isSigned == false{
                cell.configCell(.NO)
            }
            cell.priceValueLabel.text = String(dataOfModel.price)
            cell.numberLabel.text = "#\(dataOfModel.id)"
            cell.loadPostValueLabel.text = String(dataOfModel.loadId)
            cell.TransporterValueLabel.text = dataOfModel.transporterName
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
