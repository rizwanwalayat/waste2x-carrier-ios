//
//  ChatMessagesViewModel.swift
//  Waste2x
//
//  Created by MAC on 18/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import Foundation
import UIKit
import TwilioChatClient

extension ChatMessagesViewController : UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == textFildPlaceholder {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolderText
            textView.textColor = textFildPlaceholder
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        view.layoutIfNeeded()
        let sizeToFitIn = CGSize(width: self.enterMessageTextView.bounds.size.width, height: CGFloat(100))
        let newSize = self.enterMessageTextView.sizeThatFits(sizeToFitIn)
        
        if newSize.height < 25
        {
            self.constHeightMessagesTextView.constant = 25
        }
        else if newSize.height > 100
        {
            self.constHeightMessagesTextView.constant = 100
        }
        else
        {
            self.constHeightMessagesTextView.constant = newSize.height
        }
        
        UIView.animate(withDuration: 1.0, animations: {
             self.view.layoutIfNeeded()
        })
    }
}

extension ChatMessagesViewController : TwillioChatDataModelDelegate
{
    func failedToConnect() {
        
        self.showToast(message: "Twillio Client Faild to connect ... !")
    }
    
    func connectCompleted() {
        
        self.showToast(message: "Connected ... !")
    }
    
    func reloadAllMessages() {
        
        self.tableViewMessages.reloadData()
    }
    
    func receivedNewMessage() {
        
        scrollToBottomMessage()
    }
    
    func tokeExpired() {
        
        viewModel?.refreshAccessToken({ data, error, success, message in
            if data != nil && (success ?? false) {
                
                guard let accessToken = data?.result?.access_token else {
                    self.showToast(message: "Token not fetched")
                    Utility.hideLoading()
                    return
                }
                
                TwillioChatDataModel.shared.delegate = self
                TwillioChatDataModel.shared.loginToTwillio(with:  accessToken)
                
            } else {
                Utility.hideLoading()
                self.showToast(message: error?.localizedDescription ?? message)
            }
        })
    }
}

extension ChatMessagesViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TwillioChatDataModel.shared.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell", for: indexPath) as! MessagesTableViewCell
        
        let arrayIndex  = TwillioChatDataModel.shared.messages.count - indexPath.row
        let message = TwillioChatDataModel.shared.messages[arrayIndex - 1]
        
        cell.messagesHandling(message)
        /// code for pagination
        if indexPath.row == TwillioChatDataModel.shared.messages.count - 1
        {
            if TwillioChatDataModel.shared.messages.count >= TwillioChatDataModel.shared.messagesPageCount
            {
                TwillioChatDataModel.shared.fetchMoreMesseges()
            }
        }
        
        return cell
    }
    
    
}
