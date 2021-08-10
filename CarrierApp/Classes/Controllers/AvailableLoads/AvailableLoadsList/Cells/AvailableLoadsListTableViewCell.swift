//
//  AvailableLoadsListTableViewCell.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 27/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class AvailableLoadsListTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var pickupLabel: UILabel!
    @IBOutlet weak var pickupCityLabel: UILabel!
    @IBOutlet weak var dropOffLabel: UILabel!
    @IBOutlet weak var dropOffCityLabel: UILabel!
    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var vehicalValueLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityValueLabel: UILabel!
    @IBOutlet weak var actionsLabel: UILabel!
    @IBOutlet weak var actionsValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ cellData : LoadsDataModel){
        
        pickupCityLabel.text = cellData.pick_up
        dropOffCityLabel.text = cellData.drop_off
        vehicalValueLabel.text = cellData.vehicle_type
        quantityValueLabel.text = String(cellData.quantity)
        actionsValueLabel.text = "-"
        
    }
}
