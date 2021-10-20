//
//  MessagesTableViewCell.swift
//  Waste2x
//
//  Created by MAC on 07/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit
import TwilioChatClient

class MessagesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var senderContentView: UIView!
    @IBOutlet weak var senderMessagesview : UIView!
    @IBOutlet weak var messageLabel : UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var receiverContentView: UIView!
    @IBOutlet weak var receiverMessagesView: UIView!
    @IBOutlet weak var receiverTimeLabel: UILabel!
    @IBOutlet weak var receiverMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let sMaxRoundValue = CGFloat(20.0)
        let rMaxRoundValue = CGFloat(20.0)
        senderMessagesview.roundCornersTopAndBottomRightView(sMaxRoundValue)
        receiverMessagesView.roundCornersTopAndBottomRightView(rMaxRoundValue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func messagesHandling(_ cellData : TCHMessage)
    {
        senderContentView.isHidden = true
        receiverContentView.isHidden = true
        messageLabel.text = cellData.body
        timeLabel.text = cellData.timestampAsDate?.dateToString("HH:mm")
        receiverMessageLabel.text = cellData.body
        receiverTimeLabel.text = cellData.timestampAsDate?.dateToString("HH:mm")
        
        self.transform  = CGAffineTransform(scaleX: 1, y: -1)
        if let author = cellData.author?.trimmingCharacters(in: .whitespaces).uppercased() {
            
            var phone = DataManager.shared.getUsersDetail()?.phone ?? ""
            phone = phone.trimmingCharacters(in: .whitespaces).uppercased()
            let authorPhone = author.split(separator: "=").last ?? ""
            if authorPhone == phone
            {
                senderContentView.isHidden = false
            }
            else
            {
                receiverContentView.isHidden = false
            }
        }
    }
    
    func timeStampStringToTimeReturn(_ timeStamp : String) -> String?
    {
        let dateTime = timeStamp.stringToDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        let dateString = dateTime?.dateToString("HH:mm")
        return dateString
    }
    func date(){
        
    }
}
