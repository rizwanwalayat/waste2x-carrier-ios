//
//  QuotationsTableViewCell.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class DispatchesTrackingStatusCell: BaseTableViewCell {

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
    @IBOutlet weak var viewOrderDetailBtn: UIButton!
    @IBOutlet weak var trackOrderBtn: UIButton!
    
    
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
    
    
    func configCell(_ status: DispatchesStatus)
    {
        
        quotationLabel.setAttributedTextInLable("Quote", "1C2439", 16, " #38", "1C2439", 16)
        postLabel.setAttributedTextInLable("Post", "525A64", 10, " #2", "1C2439", 14)
        statusValueLabel.text = status.rawValue
        
        switch status {
        case .scheduled:
            
            statusSignHolderView.backgroundColor = UIColor(hexString: acceptedColorCode, alpha: 0.1)
            statusSignImageView.image = UIImage(named: acceptedImageViewString)
            statusValueLabel.textColor = UIColor(hexString: acceptedColorCode)
            
        case .in_transit:
        
            statusSignHolderView.backgroundColor = UIColor(hexString: rejectedColorCode, alpha: 0.1)
            statusSignImageView.image = UIImage(named: rejectedImageViewString)
            statusValueLabel.textColor = UIColor(hexString: rejectedColorCode)

        case .delivered:
        
            statusSignHolderView.backgroundColor = UIColor(hexString: rejectedColorCode, alpha: 0.1)
            statusSignImageView.image = UIImage(named: rejectedImageViewString)
            statusValueLabel.textColor = UIColor(hexString: rejectedColorCode)

        }
    }
}

