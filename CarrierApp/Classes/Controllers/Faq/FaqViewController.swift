//
//  NotificationsViewController.swift
//  ContainerView
//
//  Created by HaiD3R AwaN on 13/04/2021.
//

import UIKit

class FaqViewController: BaseViewController {
    
    
//MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables

    var viewModel : FAQsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//        tableView.addSubview(refreshControl)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        viewModel = FAQsViewModel()
        viewModel?.FetchFAQsData({ result, error, success, message in
            
            if success ?? false, error == nil {
                self.tableView.reloadData()
            } else {
                self.showToast(message: error?.localizedDescription ?? message )

            }
        })
        
    }

}


//MARK: - Extentions
extension FaqViewController : UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return viewModel?.data?.result?.faqs.count ?? 0

        } else {
            return viewModel?.data?.result?.others.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0
        {
            let cell = tableView.register(FaqTableViewCell.self, indexPath: indexPath)
            
            let cellData = viewModel?.data?.result?.faqs[indexPath.row]
            cell.config(data: cellData)
            
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell = tableView.register(FaqTableViewCell.self, indexPath: indexPath)
            
            let cellData = viewModel?.data?.result?.others[indexPath.row]
            cell.config(data: cellData)
            
            cell.selectionStyle = .none
            return cell
        }


    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) as? FaqTableViewCell
        {
            cell.expandCollapse()
        }

        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
           return "About Apps"
        }
        else {
            return "Others"
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 25, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.font = UIFont(name: "Poppins-Medium", size: 18)
        label.textColor = .black
        if section == 0
        {
            label.text = "About Apps"
        }
        else
        {
            label.text = "Others"
        }
        headerView.addSubview(label)
        return headerView
    }


}

