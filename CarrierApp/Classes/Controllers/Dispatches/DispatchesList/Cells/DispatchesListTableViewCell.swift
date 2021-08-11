//
//  DispatchesListTableViewCell.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 29/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class DispatchesListTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var dispatchesButton: UIImageView!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var dispatchRepLabel: UILabel!
    @IBOutlet weak var pickUpLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data: DispatchesListResultItem, status: DispatchesStatus) {
        
        dateCreatedLabel.text = data.date_created
        dispatchRepLabel.text = data.dispatch_rep
        pickUpLabel.text = data.pick_up
        deliveryLabel.text = data.drop_off
        
        var statusColor: UIColor
        
        switch status {
        case .scheduled:
            statusColor = UIColor(named: "redScheduled") ??  UIColor.red
            dispatchesButton.setImageColor(color: statusColor)
            bottomBorder.backgroundColor = statusColor
        case .in_transit:
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
