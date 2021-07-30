//
//  SideMenuViewController.swift
//  Waste2x
//
//  Created by HaiD3R AwaN on 25/05/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit

class SideMenuViewController: BaseViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNoHolderView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var leadingConstOfScrollView : NSLayoutConstraint!
    @IBOutlet weak var mainShadowView: UIView!
    
    //MARK: - Variables
    
    var selectionIndex = -1
    var reload = -1
    var timerTest : Timer?
    var counter = 0
    var imgArray = [#imageLiteral(resourceName: "available-Loads"),#imageLiteral(resourceName: "Quotations"), #imageLiteral(resourceName: "Dispatches"), #imageLiteral(resourceName: "Receivable"), #imageLiteral(resourceName: "Contract"), #imageLiteral(resourceName: "Payment"), #imageLiteral(resourceName: "FAQs"), #imageLiteral(resourceName: "Contact"), #imageLiteral(resourceName: "Logout")]
    var textArray = ["My Available Loads","My Quotations", "My Dispatches", "My Receivables", "My Contracts", "Payments", "FAQ", "Contact", "Logout"]
    let unSelectedBodyLabelTextColor = UIColor(named: "unselectedText")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leadingConstOfScrollView.constant    = -270
        mainShadowView.alpha                 = 0
        customMethodsForSideMenu()
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        headerView.layer.cornerRadius = 30
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        headerView.layer.masksToBounds = true
        self.phoneNumberLabel.text = self.userData?.phone
        phoneNoHolderView.layer.cornerRadius = 20
        phoneNoHolderView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        leadingConstOfScrollView.constant   = 0
        UIView.animate(withDuration: 0.3,
                   delay: 0.1,
                   options: UIView.AnimationOptions.curveEaseInOut,
                   animations: { () -> Void in
                    
                    self.mainShadowView.alpha = 1
                    self.view.layoutIfNeeded()
                    
        }, completion: { (finished) -> Void in
        // ....
        })
    }
    
    func customMethodsForSideMenu()
    {
//        editProfileLabel.text           = "Edit Profile"
        let swipeLeftMainView           = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeftMainView.direction     = .left
        let swipeLeftSubView            = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeftSubView.direction      = .left
        let swipeLeftTopView            = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeftTopView.direction      = .left
        let swipeLeftBottomView         = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeftBottomView.direction   = .left
        
        self.headerView.addGestureRecognizer(swipeLeftMainView)
        self.tableView.addGestureRecognizer(swipeLeftSubView)
        
    }
    
    func hideSideMenu(completionHandler : @escaping( ) -> Void)
    {
        leadingConstOfScrollView.constant   = -UIScreen.main.bounds.width * 0.821256
        UIView.animate(withDuration: 0.3,
                   delay: 0.1,
                   options: UIView.AnimationOptions.curveEaseInOut,
                   animations: { () -> Void in
                    
                    self.mainShadowView.alpha = 0
                    self.view.layoutIfNeeded()
                    
        }, completion: { (finished) -> Void in
            
            self.dismiss(animated: false, completion: nil)
            
            completionHandler()
        })
    }
    
    
    //MARK: - Action Buttons
    
    @IBAction func hideSideMenu(_ sender : UIButton)
    {
        hideSideMenu {
            //nil
        }
    }
    
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       
        print("Side Menu gesture Cliceked ")
        hideSideMenu {
            //nil
        }
    }
    
}

//MARK: - Extentions
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(SideMenuItemsTableViewCell.self, indexPath: indexPath)
        
        if selectionIndex == indexPath.row
        {
            cell.selectionView.isHidden = false
            cell.imgView.tintColor = UIColor.appColor
        }
        else
        {
            cell.selectionView.isHidden = true
            cell.imgView.tintColor = unSelectedBodyLabelTextColor
        }
        
        cell.config(textArray[indexPath.row], imgArray[indexPath.row])
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
                    
            // Available loads controller shows
            if selectionIndex != 0 {
                
                self.hideSideMenu {
                    let vc = AvailableLoadsViewController(nibName: "AvailableLoadsViewController", bundle: nil)
                    Utility.setupRoot(controller: vc)
                }
                
            }

        case 1:
            
            // Quotations loads controller shows
            if selectionIndex != 1 {
                
                self.hideSideMenu {
                    let vc = QuotationListViewController(nibName: "QuotationListViewController", bundle: nil)
                    Utility.setupRoot(controller: vc)
                }
            }
            
        case 2:
            
            // Dispatches controller shows
            if selectionIndex != 1 {
                
                self.hideSideMenu {
                    let vc = DispatchesListViewController(nibName: "DispatchesListViewController", bundle: nil)
        case 3:
            
            if selectionIndex != 3 {
                
                self.hideSideMenu {
                    let vc = ReceivableListViewController(nibName: "ReceivableListViewController", bundle: nil)
                    Utility.setupRoot(controller: vc)
                }
            }
            
        case 4:
            
            if selectionIndex != 3 {
                
                self.hideSideMenu {
                    let vc = ContractsViewController(nibName: "ContractsViewController", bundle: nil)
                    Utility.setupRoot(controller: vc)
                }
            }
            
        case 8:
            
            let actionVc = LogoutViewController(nibName: "LogoutViewController", bundle: nil)
            actionVc.modalPresentationStyle = .overFullScreen
            actionVc.confirmButtonPressed = {
                
                self.hideSideMenu {
                    let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    Utility.setupRoot(controller: vc)
                }
            }
            self.present(actionVc, animated: false, completion: nil)
            
        default:
            
            break
        }
        
        self.selectionIndex = indexPath.row
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
