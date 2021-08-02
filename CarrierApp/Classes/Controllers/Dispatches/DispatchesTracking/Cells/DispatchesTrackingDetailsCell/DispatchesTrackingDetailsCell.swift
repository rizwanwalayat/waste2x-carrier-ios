//
//  DispatchesListTableViewCell.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 29/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class DispatchesTrackingDetailsCell: UITableViewCell {

    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var dispatchesButton: UIImageView!
    
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
        var statusColor: UIColor
        switch status {
        case .scheduled:
            statusColor = UIColor(named: "redScheduled") ??  UIColor.red
            dispatchesButton.setImageColor(color: statusColor)
            bottomBorder.backgroundColor = statusColor
        case .inTransit:
            statusColor = UIColor(named: "yellowTransit") ??  UIColor.red
            dispatchesButton.setImageColor(color: statusColor)
            bottomBorder.backgroundColor = statusColor
        case .delivered:
            statusColor = UIColor(named: "greenDelivered") ??  UIColor.red
            dispatchesButton.setImageColor(color: statusColor)
            bottomBorder.backgroundColor = statusColor
            
        }
    }
}
