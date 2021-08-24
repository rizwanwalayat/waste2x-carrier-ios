//
//  DispatchesDetailStatusCell.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class DispatchesDetailStatusCell: BaseTableViewCell {

    // MARK: - Outlets
    

    @IBOutlet weak var vehicleTypeLabel : UILabel!
    @IBOutlet weak var regNoLabel : UILabel!
    @IBOutlet weak var dateCreatedValueLabel: UILabel!
    @IBOutlet weak var dispatchStatusLabel: UILabel!
    @IBOutlet weak var dispatchIDLabel: UILabel!
    @IBOutlet weak var deliveredTimeLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var coloredStatusView: UIView!
    @IBOutlet weak var viewOrderDetailBtn: UIButton!
    @IBOutlet weak var trackOrderBtn: UIButton!
    
    
    // MARK: - Variables
    var redScheduled = UIColor(named: "redScheduled")
    var yellowTransit = UIColor(named: "yellowTransit")
    var greenDelivered = UIColor(named: "greenDelivered")
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configCell(data: DispatchesDetailDetailsModel?, status: DispatchesStatus)
    {
        vehicleTypeLabel.text = data?.vehicle_type
        regNoLabel.text = data?.reg_number
        dateCreatedValueLabel.text = data?.created_at
        dispatchIDLabel.text = "#\(data?.dispatch_id ?? 0)"
        deliveredTimeLabel.text = status == .delivered ? data?.delivery_time : ""
//        dispatchStatusLabel.text = 
        
        switch status {
        case .scheduled:
            coloredStatusView.backgroundColor = redScheduled
            dispatchStatusLabel.text = DispatchesStatus.scheduled.rawValue
            dispatchStatusLabel.textColor = redScheduled
        case .in_transit:
            coloredStatusView.backgroundColor = yellowTransit
            dispatchStatusLabel.text = DispatchesStatus.in_transit.rawValue
            dispatchStatusLabel.textColor = yellowTransit
        case .delivered:
            coloredStatusView.backgroundColor = greenDelivered
            dispatchStatusLabel.text = DispatchesStatus.delivered.rawValue
            dispatchStatusLabel.textColor = greenDelivered
        }
    }
}

