//
//  CreateAnOtherLoadViewController.swift
//  CarrierApp
//
//  Created by MAC on 16/10/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class PopupProfileEdit: BaseViewController {

    enum ButtonSelectedStates {
        case iAmAllDone
        case createAnotherLoad
        case none
    }
    // MARK: - Outlets
    
    @IBOutlet weak var mainContentView: UIView!
    
    
    var iAmAllDoneButtonPressed: (()->())?
    var createAnothetLoadButtonPressed: (()->())?
    
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
    
    
    func hidePopup(_ buttonState : ButtonSelectedStates)
    {
        mainContentView.alpha = 1
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            
            self.mainContentView.alpha = 0
            self.mainContentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        }) { (success) in
            
            switch buttonState {
            case .createAnotherLoad:
                
                self.createAnothetLoadButtonPressed?()
                
            case .iAmAllDone:
                
                self.iAmAllDoneButtonPressed?()
                
            case .none:
                
                print("nothing pressed")
            }
            
            self.dismiss(animated: false, completion: nil)
        }
    }

    @IBAction func backButton(_ sender: Any) {
        
        hidePopup(.none)
        
    }
    @IBAction func iAmAllDonePressed(_ sender: Any) {
    
        hidePopup(.iAmAllDone)
        
    }
    @IBAction func createAnotherLoadPressed(_ sender: Any) {
        
        hidePopup(.createAnotherLoad)
    }

}
