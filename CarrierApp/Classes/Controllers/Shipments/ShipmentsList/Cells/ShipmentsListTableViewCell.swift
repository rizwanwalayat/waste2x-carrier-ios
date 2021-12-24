//
//  ShipmentsListTableViewCell.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 29/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class ShipmentsListTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var deliveryDate: UILabel!
    @IBOutlet weak var destinationName: UILabel!
    @IBOutlet weak var deliveryLocation: UILabel!
    @IBOutlet weak var shipmentIDLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    
    func configCell(data: ShipmentsListResultItem, status: ShipmentsStatus) {
        
        deliveryDate.text = data.deliveryDate
        destinationName.text = data.destination
        deliveryLocation.text = data.deliveryLocation
        shipmentIDLabel.text = "\(data.id)"
        
        var statusColor: UIColor
        
        switch status {
        case .scheduled:
            statusColor = UIColor(named: "redScheduled") ??  UIColor.red
          
            
        case .completed:
            statusColor = UIColor(named: "greenDelivered") ??  UIColor.green
            
            
        }
        bottomBorder.backgroundColor = statusColor
    }
}
