//
//  HeaderView.swift
//  CarrierApp
//
//  Created by MAC on 27/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    var isMenuButtonShows = false
    @IBInspectable
    var isMenuShow: Bool {
        
        get {
            isMenuButtonShows = false
            return false
        }
        
        set {
            
            isMenuButtonShows = newValue
            commonInit()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //commonInit()
    }

    
    private func commonInit()
    {
        if isMenuButtonShows {
            
            backButton.isHidden = false
            menuButton.isHidden = true
        }
        else {
            
            backButton.isHidden = true
            menuButton.isHidden = false
        }
    }
    
    
    @IBAction func backPressed(_ sender: UIButton)
    {
        
    }
    
    @IBAction func menuPressed(_ sender: UIButton)
    {
        
    }
}
