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

enum DispatchesActionsType: String, CaseIterable {
    case none = ""
    case departToPickup = "Departed To Pickup"
    case pickupArrive = "Pickup Arrived"
    case departToDeliver = "Departed To Deliver"
    case delivered = "Delivered"
    case deliveryImage = "POD"
    
    init?(id: Int) {
        switch id {
        case 0: self = .none
        case 1: self = .departToPickup
        case 2: self = .pickupArrive
        case 3: self = .departToPickup
        case 4: self = .delivered
        case 5: self = .deliveryImage
        default: return nil
        }
   
    }
 
}

protocol DispatchesDetailDelegate: AnyObject {
    func sendDisptachAction (action: DispatchesActionsType)
}

class DispatchesDetailPickDropCell: BaseTableViewCell {

    @IBOutlet weak var DeliveryIcon: UIImageView!
    @IBOutlet weak var DeliveryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
 
    @IBOutlet weak var departedBtn: UIButton!
    @IBOutlet weak var arrivedBtn: UIButton!
    @IBOutlet weak var departCompletedView: UIView!
    @IBOutlet weak var arrivedCompletedView: UIView!
    
    
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
            DeliveryLabel.text = "Trip To Pickup Site"
        case .delivery:
            DeliveryIcon.image = UIImage(named: "Drop Off Icon with Bg Big")
            DeliveryLabel.text = "Trip To Delivery Site"
        case .none:
            print("")
        }
        
        locationLabel.text = data?.location
    }

    func markDepartCompleted(value: Bool){
        departCompletedView.isHidden = !value
        markedButtonColor(value: value, button: departedBtn)

    }
    func markArrivedCompleted(value: Bool){
        arrivedCompletedView.isHidden = !value
        markedButtonColor(value: value, button: arrivedBtn)
      
    }
    func markedButtonColor(value: Bool, button: UIButton){
        if value{
            button.alpha = 1
            button.backgroundColor = UIColor(named: "greenDelivered")
            button.setTitleColor(.white, for: .normal)
        } 
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
