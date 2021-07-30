//
//  ReceivableListViewController.swift
//  CarrierApp
//
//  Created by MAC on 30/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class ReceivableListViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ReceivableLIstTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceivableLIstTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        mainContentView.layer.cornerRadius = 36
        mainContentView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        mainContentView.addGradient(colors: [UIColor(hexString: "FFFFFF").cgColor, UIColor(hexString: "F0F2F4").cgColor])
    }

}


// MARK: - Tableview Extenstions

extension ReceivableListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivableLIstTableViewCell", for: indexPath) as! ReceivableLIstTableViewCell
        
        if indexPath.row == 0
        {
            cell.config(.delivered)
        }
        
        else if indexPath.row == 1
        {
            cell.config(.inTransit)
        }
        
        else if indexPath.row == 2
        {
            cell.config(.scheduled)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
