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
    case none = ""
}

enum DispatchesActionsType: String {
    case departedToPickup = "Departed To Pickup"
    case pickupArrived = "Pickup Arrived"
    case pickupImage = "PICK_UP"
    case departedToDeliver = "Departed To Deliver"
    case delivered = "Delivered"
    case deliveryImage = "DROP_OFF"
    case none = ""
}

protocol DispatchesDetailDelegate: AnyObject {
    func sendDisptachAction (action: DispatchesActionsType)
}

class DispatchesDetailPickDropCell: BaseTableViewCell {

    @IBOutlet weak var DeliveryIcon: UIImageView!
    @IBOutlet weak var DeliveryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var commodityLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var departedBtn: UIButton!
    @IBOutlet weak var arrivedBtn: UIButton!
    @IBOutlet weak var imageUploadBtn: UIButton!
    
    
    weak var delegate: DispatchesDetailDelegate?
    var status: DispatchesDeliveryType = .pickup
    
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
        self.status = status
        switch status {
        case .pickup:
            DeliveryIcon.image = UIImage(named: "Pick up Icon with Bg Big")
            DeliveryLabel.text = "Pickup"
        case .delivery:
            DeliveryIcon.image = UIImage(named: "Drop Off Icon with Bg Big")
            DeliveryLabel.text = "Delivery"
        case .none:
            print("")
        }
        
        locationLabel.text = data?.location
        commodityLabel.text = data?.commodity
        arrivalLabel.text = data?.arrival
        departureLabel.text = data?.departure
    }


//    //MARK: - Actions
//    @IBAction func departedPressed(_ sender: Any) {
//        switch status {
//        case .pickup:
//            delegate?.sendDisptachAction(action: .departedToPickup)
//        case .delivery:
//            delegate?.sendDisptachAction(action: .departedToDeliver)
//        }
//    }
//
//    @IBAction func arrivedPressed(_ sender: Any) {
//        switch status {
//        case .pickup:
//            delegate?.sendDisptachAction(action: .pickupArrived)
//        case .delivery:
//            delegate?.sendDisptachAction(action: .delivered)
//        }
//    }
    
}
