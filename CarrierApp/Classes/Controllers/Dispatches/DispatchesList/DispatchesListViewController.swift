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
    var selectedTab = 0
    var dispatchesStatusArray = [DispatchesStatus.scheduled, DispatchesStatus.in_transit, DispatchesStatus.delivered]
    var viewModel: DispatchesListVM?
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
        viewModel = DispatchesListVM()
        viewModel?.fetchDispatchesData({ result, error, status, message in
            
            if status ?? false, error == nil {
                self.checkData()
            } else {
                self.showToast(message: error?.localizedDescription ?? message)
            }
        })
    }
    
    func tableviewHandlings()
    {
        tableView.register(UINib(nibName: "DispatchesListTableViewCell", bundle: nil), forCellReuseIdentifier: "DispatchesListTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    func checkData(){
        if let count = viewModel?.data?.result?.array[selectedTab].count, count > 0 {
            showTable(true)
        } else {
            showTable(false)
        }
        self.tableView.reloadData()

    }
    
    func showTable(_ flag: Bool){
        if flag {
            tableView.isHidden = false
            noDataLabel.isHidden = true
        } else {
            tableView.isHidden = true
            noDataLabel.text = "No \(dispatchesStatusArray[selectedTab].rawValue) Dispatches Available"
            noDataLabel.isHidden = false
        }
    }
    
    func unSelectTabs(){
        scheduledTab.isSelected = false
        scheduledTab.backgroundColor = .clear
        inTransitTab.isSelected = false
        inTransitTab.backgroundColor = .clear
        deliveredTab.isSelected = false
        deliveredTab.backgroundColor = .clear
    }
    
    // MARK: - IBOutlets
    @IBAction func tabPressed(_ sender: UIButton) {
        unSelectTabs()
        sender.isSelected = true
        sender.backgroundColor = .white
    
        selectedTab = sender.tag
        selectedIndex = nil
        checkData()
        
    }
    @objc func DispatchDetailBtnPressed(sender:UIButton){
        let indexPathRow = sender.tag
        let detailVC = DispatchesDetailViewController(nibName: "DispatchesDetailViewController", bundle: nil)
        let detailVM = DispatchesDetailVM()
        detailVM.id = viewModel?.data?.result?.array[selectedTab][indexPathRow].id ?? 0
        detailVC.viewModel = detailVM
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension DispatchesListViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.data?.result?.array[selectedTab].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchesListTableViewCell", for: indexPath) as! DispatchesListTableViewCell
        cell.dispatchButton.tag = indexPath.row
        cell.dispatchButton.addTarget(self, action: #selector(DispatchDetailBtnPressed(sender:)), for: .touchUpInside)
        let cellData = viewModel?.data?.result?.array[selectedTab][indexPath.row]
        cell.configCell(data: cellData!, status: dispatchesStatusArray[selectedTab])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.beginUpdates()
        if selectedIndex == indexPath {
            
            if let cell = tableView.cellForRow(at: indexPath) as? DispatchesListTableViewCell
            {
                cell.collapse()
                self.selectedIndex = nil
            }
        }
        else if selectedIndex != nil
        {
            if let cell = tableView.cellForRow(at: selectedIndex!) as? DispatchesListTableViewCell
            {
                cell.collapse()
            }
            
            if let cell = tableView.cellForRow(at: indexPath) as? DispatchesListTableViewCell
            {
                cell.expand()
            }
            selectedIndex = indexPath
        }
        else if selectedIndex == nil {
            if let cell = tableView.cellForRow(at: indexPath) as? DispatchesListTableViewCell
            {
                cell.expand()
                self.selectedIndex = indexPath
            }
        }
        
        tableView.endUpdates()
       
    }
}

