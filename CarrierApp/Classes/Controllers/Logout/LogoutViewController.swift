//
//  LogoutViewController.swift
//  CarrierApp
//
//  Created by MAC on 30/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class LogoutViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var confirmButtonPressed: (()->())?
    
    // MARK: - Controller's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainContentView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [],  animations: {
            
          self.mainContentView.transform = .identity
        })
    }
    
    func logoutRemoveToken(){
        Global.shared.sidemenuLastSlectedIndex = .none
        DataManager.shared.removeUserDetial()
        TwillioChatDataModel.shared.shutdown()

    }
    
    func hidePopup(_ isAccepted : Bool)
    {
        mainContentView.alpha = 1
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            
            self.mainContentView.alpha = 0
            self.mainContentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        }) { (success) in
            
            if isAccepted{
                self.confirmButtonPressed?()
            }
            self.dismiss(animated: false, completion: nil)
        }
    }

    @IBAction func backButton(_ sender: Any) {
        
        hidePopup(false)
        
    }
    @IBAction func confirmPressed(_ sender: Any) {
        logoutRemoveToken()
        hidePopup(true)
        
    }
    @IBAction func cancelPressed(_ sender: Any) {
        
        hidePopup(false)
    }
}
