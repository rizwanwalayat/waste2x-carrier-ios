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
    
    var rejectedColorCode = "E74C3C"
    var acceptedColorCode = "8BC46C"
    var rejectedImageViewString = "Reject-status"
    var acceptedImageViewString = "accept-Status"
    
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
        switch status {
        case .accepted:
            
            statusSignHolderView.backgroundColor = UIColor(hexString: acceptedColorCode, alpha: 0.1)
            statusSignImageView.image = UIImage(named: acceptedImageViewString)
            statusValueLabel.textColor = UIColor(hexString: acceptedColorCode)
            
        case .rejected:
        
            statusSignHolderView.backgroundColor = UIColor(hexString: rejectedColorCode, alpha: 0.1)
            statusSignImageView.image = UIImage(named: rejectedImageViewString)
            statusValueLabel.textColor = UIColor(hexString: rejectedColorCode)

        }
        
    }
    
}

enum QuotationsStatusess  {
    case accepted
    case rejected
}
