//
//  HeaderView.swift
//  CarrierApp
//
//  Created by MAC on 27/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate {
    func menuPressed()
    func backPressed()
}


@IBDesignable class HeaderView: UIView {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    
    private var proxyView: HeaderView?
    var delegate : HeaderViewDelegate?
    
    
    @IBInspectable public var title: String = "" {
        didSet {
            self.proxyView?.titleLable.text = title
        }
    }
    
    @IBInspectable public var menuShow: Bool = true {
        didSet {
            if menuShow {
                
                
                self.proxyView?.backButton.isHidden = true
                self.proxyView?.menuButton.isHidden = false
            }
            else {
                
                self.proxyView?.backButton.isHidden = false
                self.proxyView?.menuButton.isHidden = true
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = self.loadNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.proxyView = view
        self.addSubview(self.proxyView!)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func awakeAfterUsingCoder(aDecoder: NSCoder!) -> AnyObject! {
        if self.subviews.count == 0 {
            let view = self.loadNib()
            view.translatesAutoresizingMaskIntoConstraints = false
            let contraints = self.constraints
            self.removeConstraints(contraints)
            view.addConstraints(contraints)
            view.proxyView = view
            return view
        }
        return self
    }
    
    private func loadNib() -> HeaderView {
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed("HeaderView", owner: nil, options: nil)?[0] as! HeaderView
        return view
    }
    
    
    @IBAction func backPressed(_ sender: UIButton)
    {
        delegate?.backPressed()
    }
    
        
    @IBAction func menuPressed(_ sender: UIButton)
    {
        delegate?.menuPressed()
    }
}
