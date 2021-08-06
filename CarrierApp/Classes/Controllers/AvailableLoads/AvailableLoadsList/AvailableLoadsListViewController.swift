//
//  AvailableLoadsListViewController.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 27/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class AvailableLoadsListViewController: BaseViewController {

    
    // MARK: - Outelts
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Outlet
    
    var viewModel : AvailabelLoadsViewModel?
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableViewSetup()
    }


    func tableViewSetup(){
        tableView.register(UINib(nibName: "AvailableLoadsListTableViewCell", bundle: nil), forCellReuseIdentifier: "AvailableLoadsListTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }

}

extension AvailableLoadsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.data?.result?.loads.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableLoadsListTableViewCell", for: indexPath) as! AvailableLoadsListTableViewCell
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = AvailableLoadsDetailViewController(nibName: "AvailableLoadsDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
