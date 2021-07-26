//
//  AvailableLoadsViewController.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class AvailableLoadsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
//        var imageView = UIImageView(frame: view.frame)
//        imageView.image = UIImage(named: "NavBar Header")
//        imageView.contentMode = .scaleAspectFill
//        view.insertSubview(imageView, at: 0)
//        self.view.addSubview(view)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "NavBar Header"), for: UIBarMetrics.default)


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

