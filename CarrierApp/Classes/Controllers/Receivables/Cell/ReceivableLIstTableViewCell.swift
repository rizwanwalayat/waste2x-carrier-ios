//
//  ReceivableLIstTableViewCell.swift
//  CarrierApp
//
//  Created by MAC on 30/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class ReceivableLIstTableViewCell: UITableViewCell {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var bottomSepratorView: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyValueLabel: UILabel!
    @IBOutlet weak var dispatchNoLabel: UILabel!
    @IBOutlet weak var dispatchNoValueLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var outstandingAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var outstandingAmountValueLabel: UILabel!
    @IBOutlet weak var totalAmountValueLabel: UILabel!
    @IBOutlet weak var receivedAmountLabel: UILabel!
    @IBOutlet weak var receivedAmountValueLabel: UILabel!
    @IBOutlet weak var outerNoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(_ status : ReceivableStatus)
    {
        switch status {
        case .paid:
            
            statusValueLabel.text = status.rawValue
            statusValueLabel.textColor = UIColor(hexString: "1BB55C")
            bottomSepratorView.backgroundColor = UIColor(hexString: "1BB55C")
            
        case .pending:
            statusValueLabel.text = status.rawValue
            statusValueLabel.textColor = UIColor(hexString: "FFBB12")
            bottomSepratorView.backgroundColor = UIColor(hexString: "FFBB12")
            
        }
    }
}

enum ReceivableStatus : String{
    //New Statuses
    case pending = "Pending"
    case paid = "Paid"
}
