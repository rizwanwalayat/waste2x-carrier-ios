//
//  DispatchesListViewController.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

enum DispatchesStatus:String {
    case scheduled = "Scheduled"
    case in_transit = "In Transit"
    case delivered = "Delivered"
}

class DispatchesListViewController: BaseViewController {
    
    // MARK: - Variables
    var dispatchesStatus = DispatchesStatus.scheduled
    var dispatchesStatusArray = [DispatchesStatus.scheduled, DispatchesStatus.in_transit, DispatchesStatus.delivered]
    var viewModel: DispatchesListVM?
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableview : UITableView!
    
    
    // MARK: - Controller's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewHandlings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = DispatchesListVM()
        viewModel?.fetchDispatchesData({ result, error, status, message in
            
            if status ?? false, error == nil {
                self.tableview.reloadData()
            } else {
                self.showToast(message: error?.localizedDescription ?? message)
            }
        })
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.data?.result?.array[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let array = viewModel?.data?.result?.array[section], !array.isEmpty {
            return 48
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let array = viewModel?.data?.result?.array[section], !array.isEmpty {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 48))
            view.backgroundColor = .clear
            let image = UIImageView(frame: CGRect(x: 0, y: 24, width: 24, height: 24))
            image.image = UIImage(named: "Schedule Icon")
            view.addSubview(image)
            let label = UILabel(frame: CGRect(x: image.frame.width + 16, y: 24, width: UIScreen.main.bounds.width - 46, height: 24))
            label.font = UIFont.poppinFont(withSize: 16)
            label.text = "Scheduled"
            view.addSubview(label)
            
            switch section {
            case 0:
                image.image = UIImage(named: "Schedule Icon")
                label.text = DispatchesStatus.scheduled.rawValue
            case 1:
                image.image = UIImage(named: "In Transit Icon")
                label.text = DispatchesStatus.in_transit.rawValue
            case 2:
                image.image = UIImage(named: "Delivered Icon")
                label.text = DispatchesStatus.delivered.rawValue
            default:
                image.image = UIImage(named: "Schedule Icon")
                label.text = DispatchesStatus.scheduled.rawValue
            }
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "DispatchesListTableViewCell", for: indexPath) as! DispatchesListTableViewCell
        let cellData = viewModel?.data?.result?.array[indexPath.section][indexPath.row]
        cell.configCell(data: cellData!, status: dispatchesStatusArray[indexPath.section])
        
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

