//
//  QuotationActionViewController.swift
//  CarrierApp
//
//  Created by MAC on 29/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

protocol QuotationActionViewControllerDelegate {
    
    func quotationAccepted()
    func quotationRejected()
}

class QuotationActionViewController: UIViewController {

    
    // MARK: - Outlets
    
    @IBOutlet weak var holderViews: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    
    var delegate : QuotationActionViewControllerDelegate?
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.holderViews.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [],  animations: {
            
          self.holderViews.transform = .identity
        })
    }
    
    
    func hidePopup(_ isAccepted : Bool)
    {
        holderViews.alpha = 1
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            
            self.holderViews.alpha = 0
            self.holderViews.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        }) { (success) in
            
            if isAccepted
            {
                self.delegate?.quotationAccepted()
            }
            else
            {
                self.delegate?.quotationRejected()
            }
            
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    // MARK: - Actions

    @IBAction func backgroundButton(_ sender: Any) {
        
        hidePopup(false)
    }
    
    @IBAction func acceptPressed(_ sender: Any) {
        hidePopup(true)
    }
    
    @IBAction func rejectPressed(_ sender: Any) {
        hidePopup(false)
    }
    
}
