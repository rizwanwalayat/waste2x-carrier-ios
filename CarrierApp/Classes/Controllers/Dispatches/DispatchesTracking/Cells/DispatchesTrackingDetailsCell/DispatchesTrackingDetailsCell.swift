//
//  DispatchesListTableViewCell.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 29/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

enum DispatchesDeliveryType: String {
    case pickup = "Pickup"
    case delivery = "Delivery"
}

class DispatchesTrackingDetailsCell: BaseTableViewCell {

    @IBOutlet weak var DeliveryIcon: UIImageView!
    @IBOutlet weak var DeliveryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ status: DispatchesDeliveryType)
    {
        switch status {
        case .pickup:
            DeliveryIcon.image = UIImage(named: "Pick up Icon with Bg Big")
            DeliveryLabel.text = "Pickup"
        case .delivery:
            DeliveryIcon.image = UIImage(named: "Drop Off Icon with Bg Big")
            DeliveryLabel.text = "Delivery"
        }
    }
}
