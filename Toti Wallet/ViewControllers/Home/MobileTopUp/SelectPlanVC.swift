//
//  SelectPlanVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SelectPlanVC: UIViewController {

    @IBOutlet weak var planTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        planTableView.delegate = self
        planTableView.dataSource = self
    }

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        if let destinationViewController = navigationController?.viewControllers
            .filter(
                {$0 is CustomTabBarController})
            .first {
            navigationController?.popToViewController(destinationViewController, animated: true)
        }
    }
    
}

//MARK : TableView Functions
extension SelectPlanVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTableCell") as! PlanTableCell
        cell.viewMain.layer.cornerRadius = 8
        cell.dropShadow()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ControllerID.mobileTopUpPaymentVC.instance
        self.pushWithFullScreen(nextVC)
    }
}
