//
//  MessagesViewController.swift
//  Waste2x
//
//  Created by MAC on 07/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit
import TwilioChatClient
import IQKeyboardManagerSwift

class ChatMessagesViewController: BaseViewController {

    
    //MARK: - Outlets
    
    @IBOutlet weak var enterMessageTextView: UITextView!
    @IBOutlet weak var constHeightMessagesTextView: NSLayoutConstraint!
    @IBOutlet weak var tableViewMessages: UITableView!
    @IBOutlet weak var sendbutton: UIButton!
    @IBOutlet weak var sendIndicator: UIActivityIndicatorView!
    @IBOutlet weak var bottomConstOfView: NSLayoutConstraint!
    
    
    //MARK: - Declarations
    
    var textFildPlaceholder = UIColor(hexString: "9F9F9F")
    var placeHolderText = "Write message"
    var viewModel : MessagesViewModel?
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterMessageTextView.text       = placeHolderText
        enterMessageTextView.textColor  = textFildPlaceholder
        tableViewsIntegrations()
        
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.keyboardNotification(notification:)),
               name: UIResponder.keyboardWillChangeFrameNotification,
               object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = MessagesViewModel()
        
        if TwillioChatDataModel.shared.client == nil {
            
            self.viewModel?.fetchTwillioAccessToken({ data, error, success, message in
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
        else
        {
            TwillioChatDataModel.shared.delegate = self
        }
        
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enable = true
        NotificationCenter.default.removeObserver(self)
    }

    //MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        //self.enterMessageTextView.resignFirstResponder()
        
        if enterMessageTextView.text == "" || enterMessageTextView.text == placeHolderText
        {
            self.showToast(message: "Please enter text first")
            return
        }
        
        self.sendbutton.isHidden = true
        self.sendIndicator.startAnimating()
        TwillioChatDataModel.shared.sendMessage(enterMessageTextView.text!) { result, message in
            
            self.sendbutton.isHidden = false
            self.sendIndicator.stopAnimating()
            
            if result != nil {
                
                if result!.isSuccessful() {
                    
                    self.enterMessageTextView.text = ""
                    self.constHeightMessagesTextView.constant = 34.0
                    self.view.layoutIfNeeded()
                }
            } else {
                
                self.showToast(message: "Unable to send message")
            }
        }
    }
    
    func tableViewsIntegrations()
    {
        tableViewMessages.register(UINib(nibName: "MessagesTableViewCell", bundle: nil), forCellReuseIdentifier: "MessagesTableViewCell")
        tableViewMessages.rowHeight = UITableView.automaticDimension
        tableViewMessages.estimatedRowHeight = UITableView.automaticDimension
        tableViewMessages.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableViewMessages.keyboardDismissMode = .interactive
        self.constHeightMessagesTextView.constant = 34
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
    
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.bottomConstOfView?.constant = 0.0
        } else {
            self.bottomConstOfView?.constant = endFrame?.size.height ?? 0.0
        }
        
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }
    
    func scrollToBottomMessage()
    {
        if TwillioChatDataModel.shared.messages.count == 0 {
            return
        }
        
        DispatchQueue.main.async {
            let bottomMessageIndex = IndexPath(row: 0,
                                               section: 0)
            self.tableViewMessages.scrollToRow(at: bottomMessageIndex, at: .top, animated: true)
        }
    }
}
