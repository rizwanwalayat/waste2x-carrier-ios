//
//  QuotationListViewController.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class QuotationListViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableview : UITableView!
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableviewHandlings()
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
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "QuotationsTableViewCell", for: indexPath) as! QuotationsTableViewCell
        
        if indexPath.row == 1
        {
            cell.configCell(.accepted)
        }
        else
        {
            cell.configCell(.rejected)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = QuotationDetailViewController(nibName: "QuotationDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
