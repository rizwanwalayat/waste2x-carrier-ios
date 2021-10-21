//
//  ProfileViewController.swift
//  CarrierApp
//
//  Created by MAC on 18/10/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    // MARK: - Outlets
    
    
    
    // MARK: - Controller's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    // MARK: - Actions
    @IBAction func editBtnPressed(_ sender: Any) {
        let popupVC = PopupProfileEdit(nibName: "PopupProfileEdit", bundle: nil)
        popupVC.modalPresentationStyle = .overFullScreen
        self.present(popupVC, animated: true, completion: nil)
    }
    
}
