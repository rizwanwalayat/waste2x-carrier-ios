//
//  QuotationListViewController.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class DispatchesTrackingViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var mainHolderView : UIView!
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainHolderView.addGradient(colors: [UIColor(hexString: "FFFFFF").cgColor, UIColor(hexString: "F0F2F4").cgColor])
        
        tableviewHandlings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        mainHolderView.layer.cornerRadius = 36
        mainHolderView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    
    func tableviewHandlings()
    {
        tableview.register(UINib(nibName: "DispatchesTrackingStatusCell", bundle: nil), forCellReuseIdentifier: "DispatchesTrackingStatusCell")
        tableview.register(UINib(nibName: "DispatchesTrackingDetailsCell", bundle: nil), forCellReuseIdentifier: "DispatchesTrackingDetailsCell")

        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
    }

}

extension DispatchesTrackingViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell
       
       if indexPath.row == 0 {
            cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesTrackingStatusCell", for: indexPath) as! DispatchesTrackingStatusCell
        }
        else {
            cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesTrackingDetailsCell", for: indexPath) as! DispatchesTrackingDetailsCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = DispatchesTrackingStatusCell(nibName: "DispatchesTrackingStatusCell", bundle: nil)
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }
}
