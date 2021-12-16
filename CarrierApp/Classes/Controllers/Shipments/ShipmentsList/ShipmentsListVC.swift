//
//  ShipmentsListVC.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

enum ShipmentsStatus:String {
    case scheduled = "Scheduled"
    case completed = "Completed"
}

class ShipmentsListVC: BaseViewController {
    
    // MARK: - Variables
    var selectedTab = 0
    var shipmentsStatusArray = [ShipmentsStatus.scheduled, ShipmentsStatus.completed]
    var viewModel: ShipmentsListVM?
    var selectedIndex : IndexPath?
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var scheduledTab: UIButton!
    @IBOutlet weak var inTransitTab: UIButton!
    @IBOutlet weak var deliveredTab: UIButton!
    
    // MARK: - Controller's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewHandlings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = ShipmentsListVM()
        viewModel?.fetchShipmentsData({ result, error, status, message in
            
            if status ?? false, error == nil {
                self.checkData()
            } else {
                self.showToast(message: error?.localizedDescription ?? message)
            }
        })
    }
    
    func tableviewHandlings()
    {
        tableView.register(ShipmentsListTableViewCell.self, forCellReuseIdentifier: "ShipmentsListTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    func checkData(){
        if let count = viewModel?.data?.result?.array[selectedTab].count, count > 0 {
            self.tableView.reloadData()
            showTable(true)
        } else {
            showTable(false)
        }
    }
    
    func showTable(_ flag: Bool){
        if flag {
            tableView.isHidden = false
            noDataLabel.isHidden = true
        } else {
            tableView.isHidden = true
            noDataLabel.text = "No \(shipmentsStatusArray[selectedTab].rawValue) Shipments Available"
            noDataLabel.isHidden = false
        }
    }
    
    func unSelectTabs(){
        scheduledTab.isSelected = false
        scheduledTab.backgroundColor = .clear
        deliveredTab.isSelected = false
        deliveredTab.backgroundColor = .clear
    }
    
    // MARK: - IBOutlets
    @IBAction func tabPressed(_ sender: UIButton) {
        unSelectTabs()
        sender.isSelected = true
        sender.backgroundColor = .white
    
        selectedTab = sender.tag
        checkData()
        
    }
  
}

extension ShipmentsListVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.data?.result?.array[selectedTab].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShipmentsListTableViewCell", for: indexPath) as! ShipmentsListTableViewCell
  
        let cellData = viewModel?.data?.result?.array[selectedTab][indexPath.row]
        cell.configCell(data: cellData!, status: shipmentsStatusArray[selectedTab])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
       
    }
}

