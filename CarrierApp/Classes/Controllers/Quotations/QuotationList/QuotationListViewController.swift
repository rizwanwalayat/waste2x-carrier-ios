//
//  QuotationListViewController.swift
//  CarrierApp
//
//  Created by MAC on 26/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class QuotationListViewController: BaseViewController {
    
    //MARK: - Variables
    
    var viewModel : QuotationViewModel?
    var selectedTab = 0
    var dataShowArray = [QuotationStatusResult]()
    var currentTabSelect = ""
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var pendingTab: UIButton!
    @IBOutlet weak var inProcessTab: UIButton!
    @IBOutlet weak var acceptedTab: UIButton!
    
    
    // MARK: - Controller's LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewHandlings()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        viewModel = QuotationViewModel()
        viewModel?.FetchQuotationData({ result, error, success, message in
            
            if success ?? false, error == nil {
                self.checkData()
            } else {
                self.showTable(false)
                self.showToast(message: error?.localizedDescription ?? message )

            }
        })
        
    }
        
    func tableviewHandlings()
    {
        tableView.register(UINib(nibName: "QuotationsTableViewCell", bundle: nil), forCellReuseIdentifier: "QuotationsTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func showTable(_ flag: Bool){
        if flag {
            tableView.isHidden = false
            noDataLabel.isHidden = true
        } else {
            tableView.isHidden = true
            noDataLabel.isHidden = false
            noDataLabel.text = "No \(currentTabSelect) Quotations Available"
        }
    }
    func checkData()
    {
        if selectedTab == 0 {
            dataShowArray = (viewModel?.data?.result?.pending ?? []) + (viewModel?.data?.result?.revise ?? [])
            currentTabSelect = "Pending"
        }
        else if selectedTab == 1 {
            
            dataShowArray = (viewModel?.data?.result?.contract_sent ?? []) + (viewModel?.data?.result?.contract_signed ?? [])
            currentTabSelect = "In Process"
        }
        else if selectedTab == 2 {
            
            dataShowArray = (viewModel?.data?.result?.accepted ?? []) + (viewModel?.data?.result?.rejected ?? [])
            currentTabSelect = "Completed"
        }
        
        let count = dataShowArray.count
        if count > 0 {
            self.tableView.reloadData()
            showTable(true)
        } else {
            showTable(false)
        }
    }
    
    func unSelectTabs(){
        pendingTab.isSelected = false
        pendingTab.backgroundColor = .clear
        inProcessTab.isSelected = false
        inProcessTab.backgroundColor = .clear
        acceptedTab.isSelected = false
        acceptedTab.backgroundColor = .clear
    }
    
    // MARK: - Action
    @IBAction func tabPressed(_ sender: UIButton) {
        unSelectTabs()
        sender.isSelected = true
        sender.backgroundColor = .white
        selectedTab = sender.tag
        checkData()
    }

}

extension QuotationListViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataShowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuotationsTableViewCell", for: indexPath) as! QuotationsTableViewCell
        let dataOfModel = dataShowArray[indexPath.row]
        
        cell.configCell(dataOfModel.quotationStatus)
        
        cell.TransporterValueLabel.text = dataOfModel.transporterName
        cell.quotationLabel.text =  "Quote #\(dataOfModel.id)"
        cell.postLabel.text = "post #\(dataOfModel.loadId)"
        cell.priceValueLabel.text = "\(dataOfModel.price)".appendDollarSign()
        cell.TransporterValueLabel.text = dataOfModel.transporterName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = QuotationDetailViewController(nibName: "QuotationDetailViewController", bundle: nil)
        detailVC.quoteNo = dataShowArray[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
