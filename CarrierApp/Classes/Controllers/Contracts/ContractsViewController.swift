//
//  ContractsViewController.swift
//  CarrierApp
//
//  Created by MAC on 30/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class ContractsViewController: BaseViewController {

    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Controller's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ContractsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractsTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

// MARK: - Tableview Extenstions

extension ContractsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractsTableViewCell", for: indexPath) as! ContractsTableViewCell
        
        if indexPath.row % 2 == 0
        {
            cell.configCell(.NO)
        }
        else
        {
            cell.configCell(.YES)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
