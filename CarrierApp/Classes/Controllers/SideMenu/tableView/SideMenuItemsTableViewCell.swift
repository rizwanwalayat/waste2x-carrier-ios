//
//  SideMenuItemsTableViewCell.swift
//  Waste2x
//
//  Created by HaiD3R AwaN on 25/05/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit

class SideMenuItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var sepratorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(_ title : String, _ image : UIImage) {
        
        nameLabel.text = title
        imgView.image = image
        self.sepratorView.isHidden = true
        if title == "My Contracts"
        {
            self.sepratorView.isHidden = false
        }
    }
    
}
