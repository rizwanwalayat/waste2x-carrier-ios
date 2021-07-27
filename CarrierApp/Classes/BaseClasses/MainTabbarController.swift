//
//  MainTabbarController.swift
//  FindaDoctor
//
//  Created by Adeel on 03/09/2019.
//  Copyright © 2019 Adeel. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController, UITabBarControllerDelegate {

    var tabbarSelectedItem = Int()
    var isThirdTapSelected = false
    
    var arrayOfImageNameForSelectedState = ["Unselected Quotation Icon", "Unselected Dispatches Icon", "Unselected Available Load", "Unselected Receivable Icon", "Unselected Contract Icon"]
    var arrayOfImageNameForUnselectedState = ["Unselected Quotation Icon", "Unselected Dispatches Icon", "Unselected Available Load", "Unselected Receivable Icon", "Unselected Contract Icon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
                
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }
        
//        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
//        let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)
//
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
        tabbarSelectedItem = item.tag
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //print("selected view controller \(tabbarSelectedItem)")
        
        
    }
}
