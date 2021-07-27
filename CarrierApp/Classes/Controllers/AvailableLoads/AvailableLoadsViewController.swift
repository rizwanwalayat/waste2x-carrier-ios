//
//  AvailableLoadsViewController.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class AvailableLoadsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    

    
    @IBAction func applyFilter(_ sender: Any) {
        let vc = AvailableLoadsListViewController(nibName: "AvailableLoadsListViewController", bundle: nil)
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc , animated: true)
    }
    
}

