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
    @IBOutlet weak var dispatchButton: UIButton!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var commodityLabel: UILabel!
    @IBOutlet weak var pickUpLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var dispatchIDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var expandView: UIStackView!
    @IBOutlet weak var expandArrow: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expandView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func toggleCard(){
        let arrowImage = expandView.isHidden ? UIImage(named: "Arrow Up") : UIImage(named: "Arrow Down")
        self.expandView.isHidden = !self.expandView.isHidden
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()}, completion: { finished in
                self.expandArrow.image = arrowImage
        })
    }
    
    func configCell(data: DispatchesListResultItem, status: DispatchesStatus) {
        
        deliveryDateLabel.text = data.date_created
        commodityLabel.text = data.dispatch_rep
        pickUpLabel.text = data.pick_up
        deliveryLabel.text = data.drop_off
        dispatchIDLabel.text = "\(data.id)"
        
        var statusColor: UIColor
        
        switch status {
        case .scheduled:
            statusColor = UIColor(named: "redScheduled") ??  UIColor.red
          
        case .in_transit:
            statusColor = UIColor(named: "yellowTransit") ??  UIColor.red
            
        case .delivered:
            statusColor = UIColor(named: "greenDelivered") ??  UIColor.red
            
            
        }
        dispatchButton.backgroundColor = statusColor
        bottomBorder.backgroundColor = statusColor
    }
}
