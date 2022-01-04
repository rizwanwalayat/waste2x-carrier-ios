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
    
    func expand()
    {
        self.expandView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                        self.layoutIfNeeded()}, completion: { finished in
                            if self.expandArrow.image == UIImage(named: "Arrow Up")
                            {
                                self.expandArrow.image = UIImage(named: "Arrow Down")
                            }
                            else
                            {
                                self.expandArrow.image = UIImage(named: "Arrow Up")
                            }
                        })
    }
    
    func collapse()
    {
        self.expandView.isHidden = true
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                        self.layoutIfNeeded()}, completion: { finished in
                            if self.expandArrow.image == UIImage(named: "Arrow Up")
                            {
                                self.expandArrow.image = UIImage(named: "Arrow Down")
                            }
                            else
                            {
                                self.expandArrow.image = UIImage(named: "Arrow Up")
                            }
                        })
    }
    
    
    func configCell(data: DispatchesListResultItem, status: DispatchesStatus) {
        
        deliveryDateLabel.text = data.deliveryDate
        commodityLabel.text = data.commodity
        deliveryLabel.text = data.drop_off
        dispatchIDLabel.text = "\(data.id)"
        weightLabel.text = data.weight
        
        if data.pick_up.isEmpty {
            pickUpLabel.text = "--"
            dispatchButton.isHidden = true
        } else {
            pickUpLabel.text = data.pick_up
            dispatchButton.isHidden = false
        }
        
        var statusColor: UIColor
        
        switch status {
        case .scheduled:
            statusColor = UIColor(named: "redScheduled") ??  UIColor.red
          
        case .in_transit:
            statusColor = UIColor(named: "yellowTransit") ??  UIColor.yellow
            
        case .delivered:
            statusColor = UIColor(named: "greenDelivered") ??  UIColor.green
            
            
        }
        dispatchButton.backgroundColor = statusColor
        bottomBorder.backgroundColor = statusColor
    }
}
