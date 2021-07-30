//
//  ContractsTableViewCell.swift
//  CarrierApp
//
//  Created by MAC on 30/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class ContractsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var mainHolderView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var statusSignHolderView : UIView!
    @IBOutlet weak var statusSignImageView : UIImageView!
    @IBOutlet weak var loadPostLabel: UILabel!
    @IBOutlet weak var loadPostValueLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var signDocLabel: UILabel!
    @IBOutlet weak var signDcoValueLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var TransporterLabel: UILabel!
    @IBOutlet weak var TransporterValueLabel: UILabel!
    
    
    // MARK: - Variables
    
    var rejectedColorCode = "E74C3C"
    var acceptedColorCode = "8BC46C"
    var rejectedImageViewString = "Reject-status"
    var acceptedImageViewString = "accept-Status"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configCell(_ status: ContractsSignedStatus)
    {
        
        signDcoValueLabel.text = status.rawValue
        
        switch status {
        case .YES:
            
            statusSignHolderView.backgroundColor = UIColor(hexString: acceptedColorCode, alpha: 0.1)
            statusSignImageView.image = UIImage(named: acceptedImageViewString)
            signDcoValueLabel.textColor = UIColor(hexString: acceptedColorCode)
            
        case .NO:
        
            statusSignHolderView.backgroundColor = UIColor(hexString: rejectedColorCode, alpha: 0.1)
            statusSignImageView.image = UIImage(named: rejectedImageViewString)
            signDcoValueLabel.textColor = UIColor(hexString: rejectedColorCode)

        }
    }
}

enum ContractsSignedStatus: String {
    case YES = "True"
    case NO = "False"
}
