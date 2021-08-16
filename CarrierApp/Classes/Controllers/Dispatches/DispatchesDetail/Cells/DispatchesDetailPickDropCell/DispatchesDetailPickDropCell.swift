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

class DispatchesDetailPickDropCell: BaseTableViewCell {

    @IBOutlet weak var DeliveryIcon: UIImageView!
    @IBOutlet weak var DeliveryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var commodityLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data: DispatchesDetailPickDropModel?, status: DispatchesDeliveryType)
    {
        switch status {
        case .pickup:
            DeliveryIcon.image = UIImage(named: "Pick up Icon with Bg Big")
            DeliveryLabel.text = "Pickup"
        case .delivery:
            DeliveryIcon.image = UIImage(named: "Drop Off Icon with Bg Big")
            DeliveryLabel.text = "Delivery"
        }
        
        locationLabel.text = data?.location
        commodityLabel.text = data?.commodity
        arrivalLabel.text = data?.arrival
        departureLabel.text = data?.departure
        
    }
}
