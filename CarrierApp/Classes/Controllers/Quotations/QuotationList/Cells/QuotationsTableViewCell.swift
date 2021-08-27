//
//  QuotationsTableViewCell.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class QuotationsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var quotationLabel : UILabel!
    @IBOutlet weak var postLabel : UILabel!
    @IBOutlet weak var statusSignHolderView : UIView!
    @IBOutlet weak var statusSignImageView : UIImageView!
    @IBOutlet weak var statusTitleLabel : UILabel!
    @IBOutlet weak var statusValueLabel : UILabel!
    @IBOutlet weak var priceTitleLabel : UILabel!
    @IBOutlet weak var priceValueLabel : UILabel!
    @IBOutlet weak var TransporterTitleLabel : UILabel!
    @IBOutlet weak var TransporterValueLabel : UILabel!
    
    
    // MARK: - Variables
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configCell(_ status: QuotationsStatusess)
    {
        
        quotationLabel.setAttributedTextInLable("Quote", "1C2439", 16, " #38", "1C2439", 16)
        postLabel.setAttributedTextInLable("Post", "525A64", 10, " #2", "1C2439", 14)
        statusValueLabel.text = status.rawValue
        statusValueLabel.textColor = UIColor(hexString: status.statusCode)
    }
}
