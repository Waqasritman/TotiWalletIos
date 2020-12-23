//
//  SelectPlanVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SelectPlanVC: BaseVC {

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var toolTitle: UILabel!
    let repo:UtilityRepository = UtilityRepository()
    @IBOutlet weak var planTableView: UITableView!
    var plansData:[GetPrepaidPlan] = Array()
    override func viewDidLoad() {
        super.viewDidLoad()

        toolTitle.text = "mobile_top_up".localized
        pageTitle.text = "select_plan".localized
        
        
        planTableView.delegate = self
        planTableView.dataSource = self
        showProgress()
        
        repo.getPrepaidPlans(request: HTTPConnection.openConnection(stringParams: GetWRPrepaidPlansRequest.shared.getXML(), action: SoapActionHelper.shared.ACTION_GET_PREPAID_PLAN), completion: {(response , error) in
            self.hideProgress()
            if let error = error {
                self.showError(message: error)
            } else if response!.responseCode == 101 {
              //  self.showSuccess(message: String(response!.plansData.count))
                self.plansData.removeAll()
                self.plansData.append(contentsOf: response!.plansData)
                
                self.planTableView.reloadData()
            } else {
                self.showError(message: response!.description!)
            }
        })
    }

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
}

//MARK : TableView Functions
extension SelectPlanVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plansData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTableCell") as! PlanTableCell
        cell.viewMain.layer.cornerRadius = 8
        cell.lblAmount.text = plansData[indexPath.row].rechargeAmount
        cell.lblBillerName.text = plansData[indexPath.row].rechargeSubType
        cell.lblDescription.text = plansData[indexPath.row].benefits
        cell.dropShadow()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ControllerID.mobileTopUpPaymentVC.instance
        self.pushWithFullScreen(nextVC)
        
        
        WRPrepaidRechargeRequest.shared.planId = plansData[indexPath.row].planId
        WRPrepaidRechargeRequest.shared.customerNo = preferenceHelper.getCustomerNo()
        WRPrepaidRechargeRequest.shared.payOutAmount = plansData[indexPath.row].rechargeAmount
    }
}
