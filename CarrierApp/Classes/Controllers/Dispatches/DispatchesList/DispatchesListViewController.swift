//
//  DispatchesListViewController.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class DispatchesListViewController: BaseViewController {

    var dispatchesStatus = DispatchesStatus.scheduled
    var dispatchesStatusArray = [DispatchesStatus.scheduled, DispatchesStatus.inTransit, DispatchesStatus.delivered]
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var mainHolderView : UIView!
    
    
    // MARK: - Controller's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mainHolderView.addGradient(colors: [UIColor(hexString: "FFFFFF").cgColor, UIColor(hexString: "F0F2F4").cgColor])
        
        tableviewHandlings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        mainHolderView.layer.cornerRadius = 36
        mainHolderView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    
    func tableviewHandlings()
    {
        tableview.register(UINib(nibName: "DispatchesListTableViewCell", bundle: nil), forCellReuseIdentifier: "DispatchesListTableViewCell")
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
    }

}

extension DispatchesListViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dispatchesStatusArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 48))
        view.backgroundColor = .clear
        let image = UIImageView(frame: CGRect(x: 0, y: 24, width: 24, height: 24))
        image.image = UIImage(named: "Schedule Icon")
        view.addSubview(image)
        let label = UILabel(frame: CGRect(x: image.frame.width + 16, y: 24, width: UIScreen.main.bounds.width - 46, height: 24))
        label.font = UIFont.poppinFont(withSize: 16)
        label.text = "Scheduled"
        view.addSubview(label)
        let status = dispatchesStatusArray[section]
        switch status {
        case .scheduled:
            image.image = UIImage(named: "Schedule Icon")
            label.text = DispatchesStatus.scheduled.rawValue
        case .inTransit:
            image.image = UIImage(named: "In Transit Icon")
            label.text = DispatchesStatus.inTransit.rawValue
        case .delivered:
            image.image = UIImage(named: "Delivered Icon")
            label.text = DispatchesStatus.delivered.rawValue
  
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesListTableViewCell", for: indexPath) as! DispatchesListTableViewCell
        
        cell.configCell(dispatchesStatusArray[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DispatchesTrackingViewController(nibName: "DispatchesTrackingViewController", bundle: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

enum DispatchesStatus:String {
    case scheduled = "Scheduled"
    case inTransit = "In Transit"
    case delivered = "Delivered"

}
